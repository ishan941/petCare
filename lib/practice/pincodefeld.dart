import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/view/profile/account.dart';

class pinCodeTEst extends StatefulWidget {
 final String? verificationCode, phoneNumber;
  pinCodeTEst({
    super.key,
    this.phoneNumber,
    this.verificationCode,
  });

  @override
  State<pinCodeTEst> createState() => _pinCodeTEstState();
}

class _pinCodeTEstState extends State<pinCodeTEst> {
  String? optCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                 try{
                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationCode!, smsCode: optCode!);

                  // Sign the user in (or link) with the credential
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signInWithCredential(credential);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Account()), (route) => false);
                 }catch(e){
                  return Helper.snackBar("Invalid code", context);
                 }
                },
                child: Text("Verify"))
          ],
        ),
      ),
    );
  }
}
