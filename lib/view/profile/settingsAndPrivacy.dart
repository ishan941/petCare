import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/profile/passwordandSecurity.dart';
import 'package:project_petcare/view/profile/personalDetails.dart';
import 'package:project_petcare/view/profile/verifyYourAccount_1.dart';
import 'package:project_petcare/view/test.dart/foradmin.dart';
import 'package:project_petcare/view/test.dart/testPage.dart';
import 'package:project_petcare/view/form_collections.dart';
import 'package:project_petcare/view/test.dart/verificationTest.dart';
import 'package:provider/provider.dart';

class SettingsAndPrivacy extends StatefulWidget {
  final SignUp? signUp;
  SettingsAndPrivacy({super.key, this.signUp});

  @override
  State<SettingsAndPrivacy> createState() => _ProfileState();
}

class _ProfileState extends State<SettingsAndPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        actionsIconTheme: IconThemeData.fallback(),
        title: Text(
          "Settings and privacy",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) => Consumer<SignUpProvider>(
          builder: (context, signUpProvider, child) =>
              Consumer<OurServiceProvider>(
            builder: (context, ourServiceProvider, child) =>
                Consumer<ShopProvider>(
              builder: (context, shopProvider, child) => SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerifyYourAccount()));
                            },
                            child: ClipRRect(
                              child: Container(
                                color: Colors.white,
                                height: 70,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                          height: 55,
                                          width: 55,
                                          child: petCareProvider
                                                      .profilePicture !=
                                                  null
                                              ? Image.network(
                                                  petCareProvider
                                                      .profilePicture!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/emptypp.png")),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   "My Profiles",
                                        //   style: titleText,
                                        // ),
                                        Text(
                                          signUpProvider.fullName,
                                          style: smallTitleText,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(signUpProvider.userEmail,
                                            style: textStyleSmallSized),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerificationTest()));
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Account_Settings(context),
                        yourActivity(context),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
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
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
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
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestPage()));
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormCollection()));
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("uiTest"),
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
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormCollection()));
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("forms"),
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
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForAdmin()));
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("View"),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Account_Settings(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            "Account settings",
            style: appBarTitle,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white,
            // height: 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordAndSecurity()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.fingerprint),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Password and Security",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalDetails()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.class_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Personal details",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.perm_device_info_sharp),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Your information and permissions",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add_task_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ad preferences",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget yourActivity(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            "Your activity",
            style: appBarTitle,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white,
            // height: 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordAndSecurity()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.filter_list),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Activity log",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalDetails()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.devices_sharp),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Device permissions",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.web_stories_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Apps and websites",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 35,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestPage()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.business_center_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Business integrations",
                          style: smallTitleText,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
