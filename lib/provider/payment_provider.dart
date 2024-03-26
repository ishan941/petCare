import 'package:flutter/foundation.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/payment.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  List<Payment> myPaymentList = [];
  List<Payment> paymenList = [];
  String? price, userName, productName, errorMessage, email;
  String token = "";

  StatusUtil _savePaymentUtil = StatusUtil.idle;
  StatusUtil _getMyPaymentUtil = StatusUtil.idle;

  StatusUtil get savePaymentUtil => _savePaymentUtil;
  StatusUtil get getMyPaymentUtil => _getMyPaymentUtil;

  setPaymentUtil(StatusUtil statusUtil) {
    _savePaymentUtil = statusUtil;
    notifyListeners();
  }

  setGetMyPaymentUtil(StatusUtil statusUtil) {
    _getMyPaymentUtil = statusUtil;
    notifyListeners();
  }

  setUserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }

  setProductName(String productName) {
    this.productName = productName;
    notifyListeners();
  }

  setPrice(String price) {
    this.price = price;
    notifyListeners();
  }
  setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

// Future<void> saveOurServiceDto() async {
//     if (_professionUtil != StatusUtil.loading) {
//       setOurServiceDto(StatusUtil.loading);
//     }

//     try {
//       await uploadProfilePictureInFireBase();
//       OurServiceDto ourServiceDto = OurServiceDto(
//         // profession: profession,
//         fullName: userName,
//         email: email,
//         phone: phone,
//         location: loaction,
//         image: profilePictureUrl,
//         description: description,
//       );

//       ApiResponse response =
//           await petCareService.saveOurServiceDto(ourServiceDto, token);
//       if (response.statusUtil == StatusUtil.success) {
//         setOurServiceDto(StatusUtil.success);
//       } else if (response.statusUtil == StatusUtil.error) {
//         errorMessage = response.errorMessage;
//         setOurServiceDto(
//           StatusUtil.error,
//         );
//       }
//     } catch (e) {
//       errorMessage = "$e";
//       setOurServiceDto(StatusUtil.error);
//     }
//   }

  savePaymentDetails() async {
    try {
      Payment payment =
          Payment(price: price, productName: productName, userName: userName, email: email);
      ApiResponse response =
          await petCareService.savePaymentDetails(payment, token);
      if (response.statusUtil == StatusUtil.success) {
        setPaymentUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        setPaymentUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setPaymentUtil(StatusUtil.error);
    }
  }


  getMyPayment() async {
    if (_getMyPaymentUtil != StatusUtil.loading) {
      setGetMyPaymentUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getMyPaymentDetails(token);

      if (response.statusUtil == StatusUtil.success) {
        setGetMyPaymentUtil(StatusUtil.success);
        myPaymentList = Payment.listFromJson(response.data['data']);
      } else if (response.statusUtil == StatusUtil.error) {
        setGetMyPaymentUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetMyPaymentUtil(StatusUtil.error);
    }
  }
    getPaymentDetails() async {
    if (_getMyPaymentUtil != StatusUtil.loading) {
      setGetMyPaymentUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getPaymentDetails(token);

      if (response.statusUtil == StatusUtil.success) {
        setGetMyPaymentUtil(StatusUtil.success);
        paymenList = Payment.listFromJson(response.data['data']);
      } else if (response.statusUtil == StatusUtil.error) {
        setGetMyPaymentUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetMyPaymentUtil(StatusUtil.error);
    }
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
