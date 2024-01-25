import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:provider/provider.dart';

class TestConfirmVerification extends StatefulWidget {
  String? verificationCode, phoneNumber;
  TestConfirmVerification({
    super.key,
    this.phoneNumber,
    this.verificationCode,
  });

  @override
  State<TestConfirmVerification> createState() =>
      _TestConfirmVerificationState();
}

class _TestConfirmVerificationState extends State<TestConfirmVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) => Center(
          child: Column(
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
                    petCareProvider.otpCode = value;
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
                              smsCode: petCareProvider.otpCode!);

                      // Sign the user in (or link) with the credential
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithCredential(credential);
                      await petCareProvider.sendVerificationValueToFireBase();
                      if (petCareProvider.verificationUtil ==
                          StatusUtil.success) {
                        Helper.snackBar(
                            "Your Account has been Verified", context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                            (route) => false);
                      } else if (petCareProvider.verificationUtil ==
                          StatusUtil.error) {
                        {
                          Helper.snackBar(
                              "Failed to Verify, Please try again later",
                              context);
                        }
                      }

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                          (route) => false);
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
