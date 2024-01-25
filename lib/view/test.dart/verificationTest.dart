import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constFormField.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:project_petcare/view/test.dart/confirmVerificationTest.dart';
import 'package:provider/provider.dart';

class VerificationTest extends StatefulWidget {
  const VerificationTest({super.key});

  @override
  State<VerificationTest> createState() => _VerificationTestState();
}

class _VerificationTestState extends State<VerificationTest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios_new_outlined)),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ShopTextForm(
                          hintText: "Full Name",
                          onChanged: (value) {
                            petCareProvider.userName = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ShopTextForm(
                          hintText: "Email",
                          onChanged: (value) {
                            petCareProvider.userEmail = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ShopTextForm(
                          hintText: "Location",
                          onChanged: (value) {
                            petCareProvider.userLocation = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // ShopTextForm(
                        //   hintText: "Phone",
                        //   onChanged: (value) {
                        //     petCareProvider.userPhone = value;
                        //   },
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        ShopTextForm(
                          hintText: "Image",
                          onChanged: (value) {
                            petCareProvider.userImage = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
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
                        //       petCareProvider.userPhone =
                        //           phone.countryCode + phone.number;
                        //       print(petCareProvider.userPhone);
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
                        ConstPhoneField(
                          onChanged: (phone) {
                            petCareProvider.userPhone =
                                phone.countryCode + phone.number;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        ConstElevated(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: petCareProvider.userPhone,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TestConfirmVerification(phoneNumber: petCareProvider.userPhone,
                                  verificationCode: verificationId,)));
                                },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                             
                            }
                          },
                        )
                      ],
                    ),
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
