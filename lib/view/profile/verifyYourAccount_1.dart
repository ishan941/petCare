import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class VerifyYourAccount extends StatefulWidget {
  const VerifyYourAccount({super.key});

  @override
  State<VerifyYourAccount> createState() => _VerifyYourAccountState();
}

class _VerifyYourAccountState extends State<VerifyYourAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        title: Text("Verify your account"),
      ),
      body: SafeArea(
        child: Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) => 
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ShopTextForm(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        labelText: "Email",
                        onChanged: (value) {
                          petCareProvider.emailVerify = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return valiEmailStr;
                          }
            
                          return null;
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ShopTextForm(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        labelText: "Email",
                        onChanged: (value) {
                          petCareProvider.emailVerify = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return valiEmailStr;
                          }
            
                          return null;
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ShopTextForm(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        labelText: "Email",
                        onChanged: (value) {
                          petCareProvider.emailVerify = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return valiEmailStr;
                          }
            
                          return null;
                        },
                      )),
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
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
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
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => pinCodeTEst(
                                              phoneNumber: phoneNumber,
                                              verificationCode: verificationId,
                                            )));
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          }
                        },
                        child: Text("Verify")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
