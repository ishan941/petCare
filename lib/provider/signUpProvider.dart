import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage;
  String? name, phone, email, password, confirmPassword;
  bool isUserLoggedIn = false;
  String token = "";

  List<SignUp> userSignInDataList = [];

  bool isGoogleLoggedIn = false;
  bool googleLogIn = false;
  String userName = "";
  String fullName = "";
  String userEmail = "";
  String userPhone = "";

  StatusUtil _signUpUtil = StatusUtil.idle,
      _loginUtil = StatusUtil.idle,
      _userDetailsStatus = StatusUtil.idle;
  StatusUtil _verifyEmailUtil = StatusUtil.idle;

  StatusUtil get signUpUtil => _signUpUtil;
  StatusUtil get loginUtil => _loginUtil;
  StatusUtil get userDetailsStatus => _userDetailsStatus;
  StatusUtil get verifyEmailUtil => _verifyEmailUtil;

  setSignUpUtil(StatusUtil statusUtil) {
    _signUpUtil = statusUtil;
    notifyListeners();
  }

  setLoginUtil(StatusUtil statusUtil) {
    _loginUtil = statusUtil;
    notifyListeners();
  }

  setUserDetailsStatus(StatusUtil statusUtil) {
    _userDetailsStatus = statusUtil;
    notifyListeners();
  }

  setVeryfyEmailUtil(StatusUtil statusUtil) {
    _verifyEmailUtil = statusUtil;
    notifyListeners();
  }

  sendUserLoginValueToFireBase() async {
    if (_signUpUtil != StatusUtil.loading) {
      setSignUpUtil(StatusUtil.loading);
    }
    SignUp signUp =
        SignUp(name: name, password: password, email: email, phone: phone);
    try {
      ApiResponse response =
          await petCareService.userLoginDetails(signUp, token);
      if (response.statusUtil == StatusUtil.success) {
        setSignUpUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setSignUpUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setSignUpUtil(StatusUtil.error);
      print("Error: $errorMessage");
    }
  }

  Future<void> userLoginDetails() async {
    SignUp signUp = SignUp(email: email, password: password);

    try {
      ApiResponse response = await petCareService.userLogin(signUp);

      if (response.statusUtil == StatusUtil.success) {
        token = response.data['token'];
        
        setLoginUtil(StatusUtil.success);
        notifyListeners();
      } else {
        setLoginUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setLoginUtil(StatusUtil.error);
    }
  }

  Future<void> sendVerificationByEmail() async {
    if (_verifyEmailUtil != StatusUtil.loading) {
      setVeryfyEmailUtil(StatusUtil.loading);
    }
    SignUp signUp = SignUp(email: email, phone: phone
    );

    try {
      ApiResponse response = await petCareService.verifyEmail(signUp);

      if (response.statusUtil == StatusUtil.success) {
        setVeryfyEmailUtil(StatusUtil.success);
        notifyListeners();
      } else {
        setVeryfyEmailUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setVeryfyEmailUtil(StatusUtil.error);
    }
  }

 Future<void> SaveValueToSharedPreference(String fcmToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isUserLoggedIn", true);
  await prefs.setBool("isGoogleLoggedIn", true); // Adjust this if necessary
  await prefs.setString("token",  fcmToken ); // Adjust this if necessary
  notifyListeners();
}

  

  readValueFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
    token = prefs.getString("token") ?? "";
    notifyListeners();
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    print("$token");
    notifyListeners();
  }

  Future<void> clearLoginStatus(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("isUserLoggedIn");
      await prefs.remove("isGoogleLoggedIn");
      await prefs.remove('token');

      if (googleLogIn) {
        final GoogleSignIn googleSignIn = GoogleSignIn();

        try {
          if (!kIsWeb) {
            await googleSignIn.signOut();
          }
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          Helper.snackBar("Failed to logout ", context);
        }
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }
  // checkUserLoginFromFireBase() async {
  //   if (_loginUtil != StatusUtil.loading) {
  //     setLoginUtil(StatusUtil.loading);
  //   }
  //   SignUp signUp = SignUp(email: email, password: password);
  //   try {
  //     ApiResponse response = await petCareService.isUserLoggedIn(signUp, token);
  //     if (response.statusUtil == StatusUtil.success) {
  //       // userName = response.data['name'];
  //       // fullName = response.data['name'];
  //       // userEmail = response.data['email'];
  //       // userPhone = response.data['phone'];
  //       // // userImage = response.data['userImage'];
  //       // // saveUserToSharedPreferences();
  //       // setLoginUtil(StatusUtil.success);
  //       notifyListeners();
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       setLoginUtil(StatusUtil.error);
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     setLoginUtil(StatusUtil.error);
  //   }
  // }

// Future<void> userLogout() async {
//   try {
//     ApiResponse response = await petCareService.userLogout();

//     if (response.statusUtil == StatusUtil.success) {
//       // Handle successful logout
//       // Clear user information from SharedPreferences, update UI, etc.
//     } else {
//       // Handle logout failure
//       errorMessage = response.errorMessage;
//       // Handle the failure according to your app's logic
//     }
//   } catch (e) {
//     // Handle exceptions
//     errorMessage = "$e";
//     // Handle the exception according to your app's logic
//   }
// }

//

  Future<void> saveUserToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setString("fullName", fullName);
    prefs.setString('userEmail', userEmail);
    prefs.setString("userPhone", userPhone);
    // prefs.setString("userImage", userImage);
  }

  Future<void> initilizedProvider() async {
    await readUserFromSharedPreferences();
  }

  Future<void> readUserFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName = prefs.getString('userName') ?? 'User';
    List<String> nameParts = fullName.split(' ');
    userName = nameParts.isNotEmpty ? nameParts.first : 'User';
    userEmail = prefs.getString('userEmail') ?? 'Email';
    userPhone = prefs.getString("userPhone") ?? "Phone";
    // userImage = prefs.getString("userImage") ?? "userImage";

    notifyListeners();
  }

  SignUpProvider() {
    initilizedProvider();
  }

  Future<bool> readGooogelValueFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isGoogleLoggedIn = prefs.getBool('isGoogleLooggedIn') ?? false;
    return isGoogleLoggedIn;
  }
}
