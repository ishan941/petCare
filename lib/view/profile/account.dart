import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/profile/myprofile.dart';
import 'package:project_petcare/view/profile/settingsAndPrivacy.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  SignUp? signUp;
  Account({super.key});

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
        child: Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) =>
              Consumer<SignUpProvider>(
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
                              color: ColorUtil.BackGroundColorColor,
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
                          child: GestureDetector(
                            onTap: () {
                              // _showAlertDialog(context, petCareProvider);
                              // pickImageFromGallery(petCareProvider);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyProfile()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(6, 6),
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                    )
                                  ]),
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: petCareProvider
                                                                .profilePicture !=
                                                            null
                                                        ? NetworkImage(
                                                            petCareProvider
                                                                .profilePicture!)
                                                        : AssetImage(
                                                                "assets/images/emptypp.png")
                                                            as ImageProvider,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 4,
                                                top: 39,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    petCareProvider
                                                                .profilePicture !=
                                                            null
                                                        ? _showAlertDialog(
                                                            context,
                                                            petCareProvider)
                                                        : _showAlertDialogNOProfile(
                                                            context,
                                                            petCareProvider);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 21,
                                                    )),
                                                    // height: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text("My Profile"),
                                        Text(
                                          signUpProvider.fullName,
                                          style: mainTitleText,
                                        ),
                                        // Text(signUpProvider.userEmail),
                                        // Text(signUpProvider.userPhone),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                              color: Color.fromARGB(255, 244, 54, 54)
                                  .withOpacity(0.5),
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
                      Icon(
                        Icons.arrow_forward_ios,
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyProfile()));
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
                      Icon(
                        Icons.arrow_forward_ios,
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
                      Icon(
                        Icons.arrow_forward_ios,
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
                      Icon(
                        Icons.arrow_forward_ios,
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsAndPrivacy()));
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
                      Icon(
                        Icons.arrow_forward_ios,
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

  pickImageFromGallery(PetCareProvider petCareProvider) async {
    final userImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (userImage == null) return;
    await petCareProvider.setImage(userImage);
  }

  void _showAlertDialog(BuildContext context, PetCareProvider petCareProvider) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
            "Profile Picture",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: Text(
              "Do you want to change your profile picture for your account ?"),
          actions: [
            petCareProvider.profilePicture != null
                ? Image.network(petCareProvider.profilePicture!)
                : SizedBox(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery(petCareProvider);
              },
              child: Text("Gallery"),
            ),
            ElevatedButton(
              onPressed: () async {
                await petCareProvider.uploadeImageInFirebase();
                // await petCareProvider.updateProfilePicture();
                if (petCareProvider.userImageUtil == StatusUtil.success) {
                  Helper.snackBar("Successfully Saved", context);
                   Navigator.pop(context);
                } else {
                  Helper.snackBar('Failed to save', context);
                }
              },
              child: Text("Upload"),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialogNOProfile(
      BuildContext context, PetCareProvider petCareProvider) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
            "Profile Picture",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          content: Column(
            children: [
              Text("Do You want to add you profile picture For your account?"),
              petCareProvider.userImage != null ?
              Image.file(File(petCareProvider.userImage!.path)):
              SizedBox()
            ],
          ),
        
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery(petCareProvider);
              },
              child: Text("Choose Image form gallery"),
            ),
            ElevatedButton(
              onPressed: () async {
                await petCareProvider.uploadeImageInFirebase();
                if (petCareProvider.userImageUtil == StatusUtil.success) {
                  Helper.snackBar("Successfully Saved", context);
                  Navigator.pop(context);
                } else {
                  Helper.snackBar('Failed to save', context);
                }
              },
              child: Text("Upload"),
            ),
          ],
        );
      },
    );
  }
}
