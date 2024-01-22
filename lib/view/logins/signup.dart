import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
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

  String? name, phone, email, password;
  bool obscureText = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 233, 249),
      body: Consumer<PetCareProvider>(
        builder: (context, petcareProvider, child) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SizedBox(
                              height: 120,
                              child: Image.asset(
                                  "assets/images/Screenshot_2023-12-15_at_18.50.26-removebg-preview.png")),
                        ),
                        Text(
                          "Create an account",
                          style: TextStyle(fontSize: 25),
                        ),

                        //name
                        CustomForm(
                          onChanged: (value) {
                            name = value;
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
                            phone = value;
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
                            email = value;
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
                            password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          obscureText: petcareProvider.showPassword ? true : false,

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
                          obscureText: petcareProvider.confirmPassword? true: false,
                          
                          onChanged: (value) {
                            password = value;
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
                          suffixIcon: IconButton(onPressed: (){
                            if(petcareProvider.confirmPassword){
                              petcareProvider.setPasswordVisibility2(false);
                            }else{
                              petcareProvider.setPasswordVisibility2(true);
                            }
                          }, icon: Icon(petcareProvider.confirmPassword? 
                          Icons.visibility_off_outlined:
                          Icons.visibility
                          )),
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
                                 
                                },
                                child: Text('Submit')),
                          ),
                        ),
                      ],
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
    );
  }
}
