import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  String? errorMessage;
  String? name, phone, email, password;

  String? userName, userEmail;

  List<SignUp> userSignInDataList = [];

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

  setLoginUtil(StatusUtil statusUtil) {
    _loginUtil = statusUtil;
  }

  setUserDetailsStatus(StatusUtil statusUtil) {
    _userDetailsStatus = statusUtil;
    notifyListeners();
  }

 

  

  sendUserLoginValueToFireBase() async {
    
    try {
      SignUp signUp =
          SignUp(name: name, password: password, email: email, phone: phone);
      await userLoginDetails(signUp);
    } catch (e) {
      print("$e");
    }
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
  Future<void> userData() async {
    if (userDetailsStatus != StatusUtil.loading) {
      setUserDetailsStatus(StatusUtil.loading);
    }
     
    FireResponse response = await petCareService.getUserLoginData();
    if (response.statusUtil == StatusUtil.success) {
      userName = response.data.name;
      userEmail = response.data.email;
      
      
      setUserDetailsStatus(StatusUtil.success);
    } else if (response.statusUtil == StatusUtil.success) {
      errorMessage = response.errorMessage;
      setUserDetailsStatus(StatusUtil.error);
    }
  }

  checkUserLoginFromFireBase() async {
    if (_loginUtil != StatusUtil.loading) {
      setLoginUtil(StatusUtil.loading);
    }
    SignUp signUp = SignUp(phone: phone, password: password);
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

 

//   
  Future<void> SaveValueToSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isUserLoggedIn", true);
  }

  Future<void> saveUserToSharedPreferences(SignUp signUp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', signUp.name ?? 'User');
    prefs.setString('userEmail', signUp.email ?? '');
    prefs.setString("userPhone", signUp.phone ?? '');

  }
  Future<void> initilizedProvider()async{
    await readUserFromSharedPreferences();
  }

  Future<void> readUserFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? 'User';
    userEmail = prefs.getString('userEmail') ?? '';
    phone = prefs.getString("userPhone") ?? "";
    notifyListeners();
  }
 Future<void> logout() async {
    await clearLoginStatus();
  }

  Future<void> clearLoginStatus() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isUserLoggedIn", false);
    } catch (e) {
      print("$e");
    }
  }

  SignUpProvider() {
 initilizedProvider();
    
  }
  

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
