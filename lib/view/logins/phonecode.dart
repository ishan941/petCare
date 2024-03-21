import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/logins/loginpage.dart';
import 'package:project_petcare/view/profile/account.dart';
import 'package:provider/provider.dart';

class PhoneCode extends StatefulWidget {
  final String? verificationCode, phoneNumber;
  PhoneCode({
    super.key,
    this.phoneNumber,
    this.verificationCode,
  });

  @override
  State<PhoneCode> createState() => _PhoneCodeState();
}

class _PhoneCodeState extends State<PhoneCode> {
  String? optCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<SignUpProvider>(
          builder: (context, signUpProvider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('We have sent 6 digit code to \n${widget.phoneNumber}'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      optCode = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verificationCode!,
                              smsCode: optCode!);

                      // Sign the user in (or link) with the credential
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithCredential(credential);
                      await signUpProvider.sendUserLoginValueToFireBase();

                      try {
                        if (signUpProvider.signUpUtil == StatusUtil.success) {
                          Helper.snackBar(
                              "Successfully created an account", context);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
                        } else if (signUpProvider.signUpUtil ==
                            StatusUtil.error) {
                          Helper.snackBar(
                              "Failed to create an account", context);
                        }
                      } catch (e) {
                        Helper.snackBar(e.toString(), context);
                      }

                     
                    } catch (e) {
                      return Helper.snackBar("Invalid code", context);
                    }
                  },
                  child: Text("Verify"))
            ],
          ),
        ),
      ),
    );
  }
}
