import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_petcare/helper/textStyle_const.dart';


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
}
