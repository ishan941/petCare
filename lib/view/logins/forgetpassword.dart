import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/logins/phonecode.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  FocusNode focusNode = FocusNode();

  String? name, phone, email, password, confirmPassword;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getToken();
    });

    super.initState();
  }

  getToken() async {
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    await signUpProvider.getTokenFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        title: Text(
          "ForgotPassword",
          style: appBarTitle,
        ),
        iconTheme: IconThemeData.fallback(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<SignUpProvider>(
            builder: (context, signUpProvider, child) =>
                ui(signUpProvider, context),
          ),
        ),
      ),
    );
  }

  loader() {}

  Widget ui(SignUpProvider signUpProvider, BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
                onChanged: (value) {
                  signUpProvider.email = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Enter your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: FlutterPhoneNumberField(
                focusNode: focusNode,
                initialCountryCode: "NP",
                pickerDialogStyle: PickerDialogStyle(
                  countryFlagStyle: const TextStyle(fontSize: 17),
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your Phone Number',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10)),
                ),
                languageCode: "NP",
                onChanged: (phone) {
                  print(phone);
                  signUpProvider.phone = phone.countryCode + phone.number;
                  print(phoneNumber);
                  if (kDebugMode) {
                    print(phone.completeNumber);
                  }
                },
                onCountryChanged: (country) {
                  if (kDebugMode) {
                    print('Country changed to: ${country.name}');
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signUpProvider.sendVerificationByEmail();
                    if (signUpProvider.verifyEmailUtil == StatusUtil.success) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: signUpProvider.phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => pinCodeTEst(
                                        phoneNumber: signUpProvider.phone,
                                        verificationCode: verificationId,
                                      )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    } else if (signUpProvider.verifyEmailUtil ==
                        StatusUtil.error) {
                      Helper.snackBar(
                          "Email or number doesn't match from our database", context);
                    }
                  }
                },
                child: Text("Send")),
          ],
        ),
      ),
    );
  }
}
