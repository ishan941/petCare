import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/customs/customform.dart';
import 'package:project_petcare/view/logins/loginpage.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        "Create an account",
                        style: TextStyle(fontSize: 25),
                      ),

                      //name
                      CustomForm(
                        onChanged: (value) {
                          signUpProvider.name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person),
                        hintText: "Full Name",
                      ),
                      //phone
                      CustomForm(
                        onChanged: (value) {
                          signUpProvider.phone = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your contact number";
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Contact Number",
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
                            return "Please enter your Password";
                          }
                          // else if (value == password){
                          //   return "Password doesn't match";
                          // }
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
                                if (signUpProvider.password !=
                                    signUpProvider.confirmPassword) {
                                  Helper.snackBar(
                                      "Your Password doesn't match", context);
                                } else {
                                  await signUpProvider
                                      .sendUserLoginValueToFireBase();

                                  if (signUpProvider.signUpUtil ==
                                      StatusUtil.success) {
                                    Helper.snackBar(
                                        successfullySavedStr, context);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    Helper.snackBar(failedToSaveStr, context);
                                  }
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
