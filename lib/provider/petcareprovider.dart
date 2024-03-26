import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetCareProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  SignUpProvider signUpProvider = SignUpProvider();

  XFile? userImage;
  String? userImageurl;
  String? profilePicture;

  String? errorMessage;
  String? name, phone, email, password;
  String? contactNumber, code, emailVerify;
  String? userProfilePicture;

  String? userName, userPhone, userEmail, userLocation, userFullName;
  String? otpCode;
  bool showPassword = false;
  bool confirmPassword = false;

  SignUp? signUp;
  String token = "";

  String _greeting = "";
  String get greeting => _greeting;

  StatusUtil _statusUtil = StatusUtil.idle,
      _verificationUtil = StatusUtil.idle,
      _userImageUtil = StatusUtil.idle,
      _getUserNameUtil = StatusUtil.idle,
      _getUserEmailUtil = StatusUtil.idle,
      _getUserPhoneUtil = StatusUtil.idle;

  StatusUtil get dataStatusUtil => _statusUtil;
  StatusUtil get verificationUtil => _verificationUtil;
  StatusUtil get userImageUtil => _userImageUtil;
  StatusUtil get getUserNameUtil => _getUserNameUtil;
  StatusUtil get getUserEmailUtil => _getUserEmailUtil;
  StatusUtil get getUserPhoneUtil => _getUserPhoneUtil;

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

// show good moring and others
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

  // NOtification on or off
  bool _isSwitched = true;
  bool get isSwitched => _isSwitched;
  void getToggledSwitch() {
    _isSwitched = !_isSwitched;
    notifyListeners();
  }

  // notification vibration
  bool _vibrationEnabled = true;
  bool get vibrationEnabled => _vibrationEnabled;
  void toggleVibration(bool value) {
    _vibrationEnabled = value;
    notifyListeners();
  }

  setStatusUtil(StatusUtil statusUtil) {
    _statusUtil = statusUtil;
    notifyListeners();
  }

  setGetUserName(StatusUtil statusUtil) {
    _getUserNameUtil = statusUtil;
    notifyListeners();
  }

  setGetUserEmail(StatusUtil statusUtil) {
    _getUserEmailUtil = statusUtil;
    notifyListeners();
  }

  setGetUserPhone(StatusUtil statusUtil) {
    _getUserPhoneUtil = statusUtil;
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

  setProfilePicture(String? profilePicture) {
    this.profilePicture = profilePicture;
    notifyListeners();
  }

  setUserPhone(String? userPhone) {
    this.userPhone = userPhone;
    notifyListeners();
  }
  setUserName(String? userName) {
    this.userName = userName;
    notifyListeners();
  }

  getUserName() async {
    if (_getUserNameUtil != StatusUtil.loading) {
      setGetUserName(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getUserName(token);
      if (response.statusUtil == StatusUtil.success) {
        userName = response.data["name"];
        setGetUserName(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetUserName(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetUserName(StatusUtil.error);
    }
  }

  getUserFullName() async {
    if (_getUserNameUtil != StatusUtil.loading) {
      setGetUserName(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getUserFullName(token);
      if (response.statusUtil == StatusUtil.success) {
        userFullName = response.data["name"];
        setGetUserName(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetUserName(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetUserName(StatusUtil.error);
    }
  }

  getUserEmail() async {
    if (_getUserEmailUtil != StatusUtil.loading) {
      setGetUserEmail(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getUserEmail(token);
      if (response.statusUtil == StatusUtil.success) {
        userEmail = response.data["name"];
        setGetUserEmail(StatusUtil.success);         
      } else {
        errorMessage = response.errorMessage;
        setGetUserEmail(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetUserEmail(StatusUtil.error);
    }
  }

  getUserPhone() async {
    if (_getUserPhoneUtil != StatusUtil.loading) {
      setGetUserPhone(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getUserPhone(token);
      if (response.statusUtil == StatusUtil.success) {
        userPhone = response.data["name"];
        setGetUserPhone(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetUserPhone(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetUserPhone(StatusUtil.error);
    }
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

        signUp!.userImage = userImageurl;
        await petCareService.updateProfile(signUp!);
        setUserImageUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setUserImageUtil(StatusUtil.error);
      }
    }
  }

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
      userEmail: signUpProvider.userEmail,
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

  sendUserDetails() async {
    await uploadeImageInFirebase();
    if (_userImageUtil != StatusUtil.loading) {
      setUserImageUtil(StatusUtil.loading);
    }
    SignUp signUp = SignUp(
      userImage: userImageurl,
    );
    try {
      ApiResponse response =
          await petCareService.saveUserDetails(signUp, token);
      if (response.statusUtil == StatusUtil.success) {
        setUserImageUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
      }
    } catch (e) {
      errorMessage = e.toString();
      setUserImageUtil(StatusUtil.error);
    }
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
