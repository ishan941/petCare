import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class PetCareProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage;
  String? name, phone, email, password;
  String? contactNumber, code, emailVerify;

  String? userName, userPhone, userEmail, userImage, userLocation;
  String? otpCode;
  bool showPassword = false;
  bool confirmPassword = false;

  StatusUtil _statusUtil = StatusUtil.idle, _verificationUtil = StatusUtil.idle;

  StatusUtil get dataStatusUtil => _statusUtil;
  StatusUtil get verificationUtil => _verificationUtil;

  setStatusUtil(StatusUtil statusUtil) {
    _statusUtil = statusUtil;
    notifyListeners();
  }

  setVerificationUtil(StatusUtil statusUtil) {
    _verificationUtil = statusUtil;
    notifyListeners();
  }

  setPasswordVisibility(bool value) {
    showPassword = value;
    notifyListeners();
  }

  setPasswordVisibility2(bool value) {
    confirmPassword = value;
    notifyListeners();
  }

  Future<void> sendVerificationValueToFireBase() async {
    if (_verificationUtil != StatusUtil.loading) {
      setVerificationUtil(StatusUtil.loading);
    }
    VerificationTools verificationTools = VerificationTools(
      userEmail: userEmail,
      userImage: userImage,
      userLocation: userLocation,
      userName: userName,
      userPhone: userPhone,
    );
    try {
      FireResponse response =
          await petCareService.userVerification(verificationTools);
      if (response.statusUtil == StatusUtil.success) {
        setVerificationUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setVerificationUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setVerificationUtil(StatusUtil.error);
    }
  }
}
