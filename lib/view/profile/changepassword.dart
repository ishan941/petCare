import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/profile/verifications/phonenumber.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
        title: Text('Change password',
        style: appBarTitle,
        ),
      ),
      body: SafeArea(
        child: Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) => Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ShopTextForm(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        labelText: "Previous password",
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
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ShopTextForm(
                        prefixIcon: Icon(Icons.mail_outline_sharp),
                        labelText: "New Password",
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
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: ShopTextForm(
                      prefixIcon: Icon(Icons.mail_outline_sharp),
                      labelText: "Confirm password",
                      onChanged: (value) {
                        petCareProvider.emailVerify = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return valiEmailStr;
                        }

                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneNumberUi()));
                          },
                          child: Text("Forgot password ?"))
                    ],
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .9,
                  //   child: FlutterPhoneNumberField(
                  //     focusNode: focusNode,
                  //     initialCountryCode: "NP",
                  //     pickerDialogStyle: PickerDialogStyle(
                  //       countryFlagStyle: const TextStyle(fontSize: 17),
                  //     ),
                  //     decoration: InputDecoration(
                  //       hintText: 'Phone Number',
                  //       border: OutlineInputBorder(
                  //           borderSide: BorderSide(),
                  //           borderRadius: BorderRadius.circular(10)),
                  //     ),
                  //     languageCode: "NP",
                  //     onChanged: (phone) {
                  //       print(phone);
                  //       phoneNumber = phone.countryCode + phone.number;
                  //       print(phoneNumber);
                  //       if (kDebugMode) {
                  //         print(phone.completeNumber);
                  //       }
                  //     },
                  //     onCountryChanged: (country) {
                  //       if (kDebugMode) {
                  //         print('Country changed to: ${country.name}');
                  //       }
                  //     },
                  //   ),
                  // ),
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
