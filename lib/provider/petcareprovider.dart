import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';

import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:project_petcare/view/logins/loginpage.dart';

class PetCareProvider extends ChangeNotifier {
  String? errorMessage;
  bool isUserLogin = false;
  bool showPassword = false;
  bool confirmPassword = false;
  PetCareService petCareService = PetCareImpl();
  List<PetCare> userDataList = [];
  String? name, phone, email, password;

  String? contactNumber, code, emailVerify;

  //signup
  StatusUtil _statusUtil = StatusUtil.idle,
      _getUserDetailsUtil = StatusUtil.idle;

  StatusUtil get dataStatusUtil => _statusUtil;
  StatusUtil get getUserDetailsUtil => _getUserDetailsUtil;

  setGetUserDetailsUtil(StatusUtil statusUtil) {
    _getUserDetailsUtil = statusUtil;
    notifyListeners();
  }

  setStatusUtil(StatusUtil statusUtil) {
    _statusUtil = statusUtil;
    notifyListeners();
  }

  //login
  StatusUtil _loginstatusUtil = StatusUtil.idle;
  StatusUtil get loginStatusUtil => _loginstatusUtil;

  setLoginStatusUtil(StatusUtil statusUtil) {
    _loginstatusUtil = statusUtil;
    notifyListeners();
  }

//signup
  Future<void> petCareData(PetCare petCare) async {
    if (_statusUtil != StatusUtil.loading) {
      setStatusUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.petCareData(petCare);
      if (response.statusUtil == StatusUtil.success) {
        setStatusUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setStatusUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = unExpectedErroeStr;
      setStatusUtil(StatusUtil.error);
      // print('Unexpected error in petCareData: $e');
    }
  }
  //obsecureText

  setPasswordVisibility(bool value) {
    showPassword = value;
    notifyListeners();
  }

  setPasswordVisibility2(bool value) {
    confirmPassword = value;
    notifyListeners();
  }

  //login
  // Future<void> checkUserExistance(PetCare petCare) async {
  //   if (_loginstatusUtil != StatusUtil.loading) {
  //     setLoginStatusUtil(StatusUtil.loading);
  //   }
  //   try {
  //     FireResponse response = await petCareService.isUserExist(petCare);
  //     if (response.statusUtil == StatusUtil.success) {
  //       isUserLogin = response.data;
  //       setLoginStatusUtil(StatusUtil.success);
  //       notifyListeners();
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       setLoginStatusUtil(StatusUtil.error);
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     setLoginStatusUtil(StatusUtil.error);
  //   }
  // }

  Future<void> getUserData() async {
    if (_getUserDetailsUtil != StatusUtil.loading) {
      setGetUserDetailsUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getUserDetails();
      if (response.statusUtil == StatusUtil.success) {
        userDataList = response.data;
        setGetUserDetailsUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        setGetUserDetailsUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetUserDetailsUtil(StatusUtil.error);
    }
  }

  sendSignInDataInFireBase(BuildContext context) async {
    PetCare petCare = PetCare(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
    await petCareService.petCareData(petCare).then((value) {
      if ( dataStatusUtil == StatusUtil.success) {
        Helper.snackBar(successfullySavedStr, context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Helper.snackBar(failedToSaveStr, context);
      }
    });
  }
}
