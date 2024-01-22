import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/string_const.dart';

import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class PetCareProvider extends ChangeNotifier {
  String? errorMessage;
  bool isUserLogin = false;
  bool showPassword = false;
  bool confirmPassword = false;
  PetCareService petCareService = PetCareImpl();
  List<PetCare>userDataList =[];

  //signup
  StatusUtil _statusUtil = StatusUtil.idle,
  _getUserDetailsUtil = StatusUtil.idle;


  StatusUtil get dataStatusUtil => _statusUtil;
  StatusUtil get getUserDetailsUtil => _getUserDetailsUtil;

  setGetUserDetailsUtil(StatusUtil statusUtil){
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
  setLoginStatus(StatusUtil statusUtil) {
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
  Future<void> isUserExist(PetCare petCare) async {
    if (_loginstatusUtil != StatusUtil.loading) {
      setLoginStatus(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.isUserExist(petCare);
      if (response.statusUtil == StatusUtil.success) {
        isUserLogin = response.data;
        setLoginStatus(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setLoginStatus(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
       setLoginStatus(StatusUtil.error);
    }
  }
  Future<void> getUserData()async{
    if( _getUserDetailsUtil != StatusUtil.loading){
      setGetUserDetailsUtil(StatusUtil.loading);
    }
    try{
      FireResponse response = await petCareService.getUserDetails();
      if(response.statusUtil == StatusUtil.success){
        userDataList = response.data;
        setGetUserDetailsUtil(StatusUtil.success);
      }else if(response.statusUtil == StatusUtil.error){
        setGetUserDetailsUtil(StatusUtil.error);
      }


    }catch(e){
      errorMessage = "$e";
      setGetUserDetailsUtil(StatusUtil.error);
    }
   
  }
}
