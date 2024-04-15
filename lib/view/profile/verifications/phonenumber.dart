import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';

class PhoneNumberUi extends StatefulWidget {
  const PhoneNumberUi({super.key});

  @override
  State<PhoneNumberUi> createState() => _PhoneNumberUiState();
}

class _PhoneNumberUiState extends State<PhoneNumberUi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        title: Text(
          'Verification',
          style: appBarTitle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Verify this is your account "),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: FlutterPhoneNumberField(
                      focusNode: focusNode,
                      initialCountryCode: "NP",
                      pickerDialogStyle: PickerDialogStyle(
                        countryFlagStyle: const TextStyle(fontSize: 17),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      languageCode: "NP",
                      onChanged: (phone) {
                        print(phone);
                        phoneNumber = phone.countryCode + phone.number;
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
                ],
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                    onPressed: () async {
              
                      if (_formKey.currentState!.validate()) {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pinCodeTEst(
                                          phoneNumber: phoneNumber,
                                          verificationCode: verificationId,
                                        )));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },
                    child: Text("Verify")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
