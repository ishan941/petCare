import 'package:flutter/material.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/profile/settingsAndPrivacy.dart';
import 'package:project_petcare/view/test.dart/foradmin.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.primaryColor,
        actionsIconTheme: IconThemeData.fallback(),
        elevation: 0,
        title: Text(
          "Account",
          style: appBarTitle,
        ),
      ),
      backgroundColor: ColorUtil.primaryColor,
      body: SingleChildScrollView(
        child: Consumer<SignUpProvider>(
          builder: (context, signUpProvider, child) => Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                            color: Color(0xFFDFE2FF),
                            height: MediaQuery.of(context).size.height),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(6, 6),
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                )
                              ]),
                          width: 120,
                          height: 120,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(signUpProvider.fullName),
                          Text(signUpProvider.userEmail),
                          Text(signUpProvider.userPhone),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      testPage(context),
                      formCollection(context),
                     
                      settingsAndPrivacy(context),
                       forAdmin(context),
                      LogOut(context),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget LogOut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          dialogBuilder(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 244, 54, 54).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          height: 45,
                          width: 45,
                          child: Icon(Icons.logout_outlined)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                      size: 18,
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

  Widget testPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ForAdmin()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          height: 45,
                          width: 45,
                          child: Icon(Icons.person_2_outlined)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "User Details",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                      size: 18,)
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

  Widget formCollection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          height: 45,
                          width: 45,
                          child: Icon(Icons.dashboard_customize_outlined)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Documents",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                      size: 18,
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

  Widget forAdmin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          height: 45,
                          width: 45,
                          child: Icon(Icons.new_releases_outlined)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Report",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                      size: 18,
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

  Widget settingsAndPrivacy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsAndPrivacy()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          height: 45,
                          width: 45,
                          child: Icon(Icons.new_releases_outlined)),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Settings and Privacy",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                      size: 18,
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
