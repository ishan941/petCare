import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/practice/pincodefeld.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/customs/customform.dart';
import 'package:project_petcare/view/logins/loginpage.dart';
import 'package:project_petcare/view/logins/phonecode.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  FocusNode focusNode = FocusNode();

  String? name, phone, email, password, confirmPassword;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 233, 249),
      body: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) => Consumer<PetCareProvider>(
          builder: (context, petcareProvider, child) => SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .2,
                          child: Image.asset("assets/images/petcareLogi.png")),
                      Text(
                        createAccountStr,
                        style: TextStyle(fontSize: 25),
                      ),

                      //name
                      CustomForm(
                        onChanged: (value) {
                          signUpProvider.name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return;
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person),
                        hintText: "Full Name",
                      ),
                      //phone
                      // CustomForm(
                      //   onChanged: (value) {
                      //     signUpProvider.phone = value;
                      //   },
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "Please enter your contact number";
                      //     }
                      //     return null;
                      //   },
                      //   prefixIcon: Icon(Icons.phone),
                      //   hintText: "Contact Number",
                      // ),
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
                      //email
                      CustomForm(
                        onChanged: (value) {
                          signUpProvider.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                      ),
                      //password
                      CustomForm(
                        onChanged: (value) {
                          signUpProvider.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        obscureText:
                            petcareProvider.showPassword ? true : false,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (petcareProvider.showPassword) {
                                petcareProvider.setPasswordVisibility(false);
                              } else {
                                petcareProvider.setPasswordVisibility(true);
                              }
                            },
                            icon: Icon(petcareProvider.showPassword
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        hintText: "Password",
                      ),
                      //confirm password
                      CustomForm(
                        obscureText:
                            petcareProvider.confirmPassword ? true : false,
                        onChanged: (value) {
                          signUpProvider.confirmPassword = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your confirm Password";
                          } else if (signUpProvider.password != value) {
                            return "Password doesn't match";
                          }

                          return null;
                        },
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (petcareProvider.confirmPassword) {
                                petcareProvider.setPasswordVisibility2(false);
                              } else {
                                petcareProvider.setPasswordVisibility2(true);
                              }
                            },
                            icon: Icon(petcareProvider.confirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)),
                        hintText: "Confirm Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              // spreadRadius: 5,
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(6, 6),
                            ),
                          ]),
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: signUpProvider.phone,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {

                                        },
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PhoneCode(
                                                    phoneNumber: phoneNumber,
                                                    verificationCode:
                                                        verificationId,
                                                  )));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {},
                                  );

                                  // await signUpProvider
                                  //     .sendUserLoginValueToFireBase();

                                  // try {
                                  //   if (signUpProvider.signUpUtil ==
                                  //       StatusUtil.success) {
                                  //     Helper.snackBar(
                                  //         "Successfully created an account",
                                  //         context);
                                  //     Navigator.of(context).pushAndRemoveUntil(
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 LoginPage()),
                                  //         (Route<dynamic> route) => false);
                                  //   } else if (signUpProvider.signUpUtil ==
                                  //       StatusUtil.error) {
                                  //     Helper.snackBar(
                                  //         "Failed to create an account",
                                  //         context);
                                  //   }
                                  // } catch (e) {
                                  //   Helper.snackBar(e.toString(), context);
                                  // }
                                }
                              },
                              child: Text('Submit')),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text("Login")),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
