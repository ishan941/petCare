import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/customs/customform.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';
import 'package:project_petcare/view/googleAuth.dart';
import 'package:project_petcare/view/logins/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? name, password, email, phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 233, 249),
      body: SafeArea(
        child: Consumer<SignUpProvider>(
          builder: (context, signUpProvider, child) =>
              Consumer<PetCareProvider>(
            builder: (context, petcareProvider, child) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          child: Image.asset(
                              "assets/images/Screenshot_2023-12-15_at_18.50.26-removebg-preview.png"),
                          height: 100,
                        ),
                        Text(
                          "Login to your account",
                          style: TextStyle(fontSize: 25),
                        ),
                        //Username
                        CustomForm(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                          onChanged: (value) {
                            signUpProvider.phone = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return phoneValidatorStr;
                            }
                            return null;
                          },
                        ),

                        //Password
                        CustomForm(
                          obscureText:
                              petcareProvider.showPassword ? true : false,
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (petcareProvider.showPassword) {
                                petcareProvider.setPasswordVisibility(false);
                              } else {
                                petcareProvider.setPasswordVisibility(true);
                              }
                            },
                            icon: Icon(
                              petcareProvider.showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                            ),
                          ),
                          onChanged: (value) {
                            signUpProvider.password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 8) {
                              return "Your Password must include 8 letetrs ";
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text("Forget Password ?"))
                          ],
                        ),
                        //Elivatedbutton
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 11, 2, 2)
                                      .withOpacity(0.6),
                                  spreadRadius: 8,
                                  blurRadius: 0,
                                  offset: Offset(6, 6),
                                ),
                              ]),
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await signUpProvider
                                        .checkUserLoginFromFireBase();
                                    if (signUpProvider.loginUtil ==
                                        StatusUtil.success) {
                                      SaveValueToSharedPreference();
                                      if (signUpProvider.isUserLoggedIn) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavBar()),
                                                (route) => false);
                                      } else {
                                        _showAlertDialog(context);
                                      }
                                    } else {
                                      Helper.snackBar("Sorry", context);
                                    }

                                    // if (_formKey.currentState!.validate())
                                    //  {
                                    //   PetCare petCare =
                                    //       PetCare(phone: phone, password: password);
                                    //   await petcareProvider
                                    //       .checkUserExistance(petCare)
                                    //       .then((value) {
                                    //     if (petcareProvider.loginStatusUtil ==
                                    //         StatusUtil.success) {
                                    //       SaveValueToSharedPreference();
                                    //       if (petcareProvider.isUserLogin) {
                                    //         Navigator.of(context)
                                    //             .pushAndRemoveUntil(
                                    //                 MaterialPageRoute(
                                    //                     builder:
                                    //                         (context) =>
                                    //                             BottomNavBar()),
                                    //                 (Route<dynamic> route) =>
                                    //                     false);
                                    //       } else {
                                    //         _showAlertDialog(context);
                                    //       }
                                    //     } else {
                                    //       Helper.snackBar("Sorry :(", context);
                                    //     }
                                    //   });
                                    // }
                                  },
                                  child: Text("Login"))),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 17),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(fontSize: 17),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 165,
                          color: const Color.fromARGB(255, 6, 6, 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            child: Text(
                              "Or",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 165,
                          color: const Color.fromARGB(255, 8, 6, 6),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        User? user = await Authentication.signInWithGoogle(
                            context: context);
                        if (user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                              (route) => false);
                          signUpProvider.SaveValueToSharedPreference();
                        } else {
                          Helper.snackBar("No", context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(6, 5),
                                  color: Colors.grey.withOpacity(0.4)),
                            ],
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: const Color.fromARGB(255, 12, 8, 8))),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 40,
                                child: Image.asset(
                                    "assets/images/googlelogo.png")),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              signInGoogleStr,
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(6, 5),
                              color: Colors.grey.withOpacity(0.4)),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 40,
                                child: Image.asset(
                                    "assets/images/Apple-logo-black-and-white-removebg-preview.png")),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              signInAppleStr,
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Username or Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The Provider Username or Password is incorrect. '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('OK')),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
