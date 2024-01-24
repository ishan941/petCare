import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  String? errorMessage;
  String? name, phone, email, password;

  List<SignUp> userSignInDataList=[];

  bool isUserLoggedIn = false;
  

  PetCareService petCareService = PetCareImpl();

  StatusUtil _signUpUtil = StatusUtil.idle,
  _loginUtil = StatusUtil.idle,
  _userDetailsStatus = StatusUtil.idle;

  StatusUtil get signUpUtil => _signUpUtil;
  StatusUtil get loginUtil => _loginUtil;
  StatusUtil get userDetailsStatus => _userDetailsStatus;

  

  setSignUpUtil(StatusUtil statusUtil) {
    _signUpUtil = statusUtil;
    notifyListeners();
  }
  setLoginUtil(StatusUtil statusUtil){
    _loginUtil = statusUtil;
  }
  setUserDetailsStatus(StatusUtil statusUtil){
    _userDetailsStatus = statusUtil;
    notifyListeners();
  }

  Future<void> userLoginDetails(SignUp signUp) async {
    if (_signUpUtil != StatusUtil.loading) {
      setSignUpUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.userLoginDetails(signUp);
      if (response.statusUtil == StatusUtil.success) {
        setSignUpUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setSignUpUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
    }
  }
  Future<void>userData()async{
    if(userDetailsStatus != StatusUtil.loading){
      setUserDetailsStatus(StatusUtil.loading);
    }
    FireResponse response = await petCareService.getUserLoginData();
    if(response.statusUtil == StatusUtil.success){
      userSignInDataList = response.data;
      setUserDetailsStatus(StatusUtil.success);
      
    }else if(response.statusUtil == StatusUtil.success){
      errorMessage = response.errorMessage;
      setUserDetailsStatus(StatusUtil.error);
    }
  }

  sendUserLoginValueToFireBase() async {
    try {
      SignUp signUp =
          SignUp(name: name, password: password, email: email, phone: phone);
      await userLoginDetails(signUp);
    } catch (e) {
     
      print("Error in sendUserLoginValueToFireBase: $e");
    }
  }
  checkUserLoginFromFireBase()async{
  
     if (_loginUtil != StatusUtil.loading) {
      setLoginUtil(StatusUtil.loading);
    }
      SignUp signUp = SignUp(
      phone: phone, password: password
    );
    try {
      FireResponse response = await petCareService.isUserLoggedIn(signUp);
      if (response.statusUtil == StatusUtil.success) {
        isUserLoggedIn = response.data;
        setLoginUtil(StatusUtil.success);
        notifyListeners();
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setLoginUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setLoginUtil(StatusUtil.error);
    }
  }
  
//    Future<void> checkUserAndSaveToSharedPref(SignUp signUp) async {
//     try {
//       await checkUserExistance(signUp);
//       // Update shared preferences
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('isUserLoggedIn', isUserLoggedIn);
//     } catch (e) {
//       print("Error in checkUserAndSaveToSharedPref: $e");
//     }
//   }
//   Future<void> saveValueToSharedPreference() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool("isUserLoggedIn", true);
//     } catch (e) {
//       print("Error in saveValueToSharedPreference: $e");
//     }
//   }
 Future<bool> readValueFromSharedPreference() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
    return isUserLoggedIn;
   
  } catch (e) {
    print('Error reading from SharedPreferences: $e');
    return isUserLoggedIn;
  }
}



  
}
