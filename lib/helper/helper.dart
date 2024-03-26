import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/payment_provider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Helper {
 
// static showDialog ( context){
//   var alertBox = showDialog(context: context, builder: )

//   )
// }
  static Future<bool> checkInterNetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  static snackBar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static loadingAnimation(context) {
    return LoadingAnimationWidget.twistingDots(
      leftDotColor: const Color(0xFF1A1A3F),
      rightDotColor: const Color(0xFFEA3799),
      size: 200,
    );
  }

  static backdropFilter(context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 3),
      child: SafeArea(
        child: Stack(
          children: [
            Center(
                child: LoadingAnimationWidget.dotsTriangle(
              color: ColorUtil.primaryColor,
              size: 100,
            )),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0),
            ),
          ],
        ),
      ),
    );
  }
  void onPaymentSuccess(
      String token, BuildContext context, ShopProvider shopProvider) async{
    verify(token);
    displaySnackBar("Payment Successful", context, Icons.check, ColorUtil.primaryColor);
    shopProvider.setPaymentSuccessfull(true);
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.savePaymentDetails();
    // if(paymentProvider.savePaymentUtil == StatusUtil.success){
    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ShopAll()), (route) => false);
    // }
  }

  void onPaymentFailure(BuildContext context) {
    displaySnackBar("Payment Failed", context, Icons.warning, Colors.red);
  }

  void onPaymentCancel(BuildContext context) {
    displaySnackBar(
        "Payment Cancelledl", context, Icons.warning, Colors.red);
  }

  void pay(
      BuildContext context, int ammount, ShopProvider shopProvider) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: ammount * 100,
        productIdentity: 'dells-sssssg5-g5510-2021',
        productName: 'Product Name',
      ),
      preferences: [
        PaymentPreference.khalti,
        PaymentPreference.connectIPS,
        PaymentPreference.sct,
        PaymentPreference.eBanking,
        PaymentPreference.mobileBanking
      ],
      onSuccess: (su) {
        onPaymentSuccess(su.token, context, shopProvider);
      },
      onFailure: (fa) {
        onPaymentFailure(context);
      },
      onCancel: () {
        onPaymentCancel(context);
      },
    );
  }

  void verify(String token) async {
    final dio = Dio();
    dio.options.headers = {
      'content-type': 'application/json',
      'Authorization': 'Key test_secret_key_27d6d605410f40268fa4495457f21186'
    };
    final url = 'https://khalti.com/api/v2/payment/verify/';
    final payload = {
      'token': token,
      'amount': 1000,
    };

    try {
      final response = await dio.post(
        url,
        data: payload,
      );

      if (response.statusCode == 200) {
        print('Response Data: ${response.data}');
      } else {
        print('Failed to verify payment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static displaySnackBar(
      String message, BuildContext context, IconData icon, Color color) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              color: color,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: ColorUtil.BackGroundColorColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      message,
                      style: TextStyle(color:  ColorUtil.BackGroundColorColor,),
                    )
                  ],
                ),
              ));
        });
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }
StreamSubscription<Position>? _positionStream;
String address="";
  launchMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final url = "https://www.google.com/maps/search/?api=1&query=$query";
    try {
      await launch(url);
    } catch (e) {
      print(e);
    }
  }

  getPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Location permissions are denied');
      await Geolocator.requestPermission().then((value) async {
        permission = await Geolocator.checkPermission();
      });
    }
    return permission;
  }

  StreamController<Coordinate> controller = StreamController<Coordinate>();

  Stream<Coordinate> getCoordinateStream() {
    try {
      Stream<Position> positionStream = Geolocator.getPositionStream();
      Stream<Coordinate> coordinateStream =
          positionStream.asyncExpand((Position position) async* {
        double lat = position.latitude;
        double long = position.longitude;
        String address = await getAddress(lat, long);
        yield Coordinate(latitude: lat, longitude: long, address: address);
      });

      coordinateStream.listen((Coordinate coordinate) {
        controller.add(coordinate);
      });
    } catch (e) {
      print(e);
    }

    return controller.stream;
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    address =
        placemarks[3].street! + ", " + placemarks[3].subAdministrativeArea!;
    return address;
  }

  stopLocationUpdates() {
    _positionStream?.cancel();
    _positionStream = null;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double calculateDistance(
      double startLat, double startLng, double endLat, double endLng) {
    const int earthRadius = 6371;

    double startLatRadians = degreesToRadians(startLat);
    double startLngRadians = degreesToRadians(startLng);
    double endLatRadians = degreesToRadians(endLat);
    double endLngRadians = degreesToRadians(endLng);

    double latDiff = endLatRadians - startLatRadians;
    double lngDiff = endLngRadians - startLngRadians;

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(startLatRadians) *
            cos(endLatRadians) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  
}

class Coordinate {
  double? latitude, longitude;
  String? address;
  Coordinate({this.latitude, this.longitude, this.address});
}



