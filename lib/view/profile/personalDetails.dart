import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/profile/passwordandSecurity.dart';
import 'package:project_petcare/view/test.dart/testPage.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: IconThemeData.fallback(),
        title: Text(
          "Personal details",
          style: appBarTitle,
        ),
      ),
      body: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) => Column(
          children: [
            Container(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text("Account settings"),
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
                                        builder: (context) =>
                                            PasswordAndSecurity()));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Contact info"),
                                      Text(
                                          "${signUpProvider.userEmail},${signUpProvider.userPhone}",
                                          style: textStyleSmallSized,
                                          )
                                    ],
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
                                        builder: (context) =>
                                            PersonalDetails()));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.class_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Personal details"),
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
                                        builder: (context) => TestPage()));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.perm_device_info_sharp),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Your information and permissions"),
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
                                        builder: (context) => TestPage()));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add_task_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Ad preferences"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
