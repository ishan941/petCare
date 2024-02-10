import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class PetCareProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  XFile? userImage;
  String? userImageurl;
  String? profilePicture;
   

  String? errorMessage;
  String? name, phone, email, password;
  String? contactNumber, code, emailVerify;

  String? userName, userPhone, userEmail, userLocation;
  String? otpCode;
  bool showPassword = false;
  bool confirmPassword = false;

  SignUp? signUp;

  String _greeting = "";
  String get greeting => _greeting;

  StatusUtil _statusUtil = StatusUtil.idle,
      _verificationUtil = StatusUtil.idle,
      _userImageUtil = StatusUtil.idle;

  StatusUtil get dataStatusUtil => _statusUtil;
  StatusUtil get verificationUtil => _verificationUtil;
  StatusUtil get userImageUtil => _userImageUtil;

  setUserImageUtil(StatusUtil statusUtil) {
    _userImageUtil = statusUtil;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selecedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  updateGreeting() {
    DateTime now = DateTime.now();
    DateTime localTime = now.toLocal();
    int hour = localTime.hour;
    print("Current hour : $hour");
    if (hour >= 5 && hour < 12) {
      _greeting = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      _greeting = "Good Afternoon";
    } else {
      _greeting = "Good Evening";
    }
    print("Geeting: $_greeting");
    notifyListeners();
  }

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

  setImage(XFile? userImage) {
    this.userImage = userImage;
    notifyListeners();
  }

  setImageUrl(String? userImageUrl) {
    this.userImageurl = userImageUrl;
    notifyListeners();
  }
 

  Future<void> uploadeImageInFirebase() async {
    if (_userImageUtil == StatusUtil.loading) {
      setUserImageUtil(StatusUtil.loading);
    }
    if (userImage != null) {
      final uploadeUserImageRef = await FirebaseStorage.instance.ref();
      var userImageRef = await uploadeUserImageRef.child(userImage!.name);
      try {
        await userImageRef.putFile(File(userImage!.path));
        final downloadeUserImageUrl = userImageRef.getDownloadURL();
        userImageurl = await downloadeUserImageUrl;
        await petCareService.updateProfile(signUp!);
        signUp!.userImage = userImageurl;

        setUserImageUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setUserImageUtil(StatusUtil.error);
      }
    }
  }
  // Future<void> updateProfilePicture() async {
  //   if (signUp != null && userImageurl != null) {
  //     signUp!.userImage = userImageurl;
  //     try {
  //       FireResponse response = await petCareService.updateProfile(signUp!);
  //       if (response.statusUtil == StatusUtil.success) {

  //         setUserImageUtil(StatusUtil.success);
  //       } else {
  //         errorMessage = response.errorMessage;
  //         print("Error updating user profile picture: $errorMessage");
  //         setUserImageUtil(StatusUtil.error);
  //       }
  //     } catch (e) {
  //       errorMessage = "$e";
  //       print("Exception while updating user profile picture: $errorMessage");
  //       setUserImageUtil(StatusUtil.error);
  //     }
  //   } else {
  //     print("Sign-up data is null. Cannot update profile picture.");
  //     setUserImageUtil(StatusUtil.error);
  //   }
  // }

  Future<void> getProfilePicture() async {
    if (_verificationUtil != StatusUtil.loading) {
      setUserImageUtil(StatusUtil.loading);
    }
    try {
      var response = await petCareService.getUserByEmail();
      if (response.statusUtil == StatusUtil.success) {
        signUp = response.data;
        if (signUp?.userImage != null) {
          profilePicture = signUp!.userImage ?? "";
        }

        setUserImageUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        print("Error fetching shop items: $errorMessage");
        setUserImageUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      print("Exception while fetching shop items: $errorMessage");
      setUserImageUtil(StatusUtil.error);
    }
  }

  Future<void> sendVerificationValueToFireBase() async {
    await uploadeImageInFirebase();
    if (_verificationUtil != StatusUtil.loading) {
      setVerificationUtil(StatusUtil.loading);
    }
    VerificationTools verificationTools = VerificationTools(
      userEmail: userEmail,
      userImage: userImageurl,
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
