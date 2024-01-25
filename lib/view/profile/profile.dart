import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/logins/loginpage.dart';

import 'package:project_petcare/view/ourservice/service_form.dart';
import 'package:project_petcare/view/profile/verifyYourAccount_1.dart';
import 'package:project_petcare/view/test.dart/testPage.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  SignUp? signUp;
  Profile({super.key, this.signUp});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        actionsIconTheme: IconThemeData.fallback(),
        actions: [
          Icon(
            Icons.notifications_none_rounded,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.favorite_outline_rounded),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceForm()));
              },
              icon: Icon(Icons.add_home_work_outlined)),
        ],
      ),
      body: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) =>
            Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) =>
              Consumer<ShopProvider>(
            builder: (context, shopProvider, child) => SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  "assets/images/emptypp.png",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  signUpProvider.name ?? "User",
                                  style: subTitleText,
                                ),
                                // Text(
                                //  widget.signUp?.name?? "User",
                                //   style: TextStyle(fontSize: 20),
                                // ),
                                Text(signUpProvider.email ?? "",
                                    style: textStyleSmallSized),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyYourAccount()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Verify your account"),
                                  Icon(Icons.arrow_forward_rounded)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        dialogBuilder(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Logout"),
                                  Icon(Icons.arrow_forward_rounded)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TestPage()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Test"),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_rounded)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
