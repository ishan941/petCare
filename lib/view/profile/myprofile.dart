import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/profile/account.dart';
import 'package:project_petcare/view/profile/settingsAndPrivacy.dart';
import 'package:project_petcare/view/profile/verifyYourAccount_1.dart';
import 'package:project_petcare/view/test.dart/verificationTest.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double offsetY = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) => Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) => SafeArea(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {},
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: _profile(signUpProvider, petCareProvider),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Transform.translate(
                            offset: Offset(0.0, offsetY),
                            child: petCareProvider.profilePicture != null
                                ? Image.network(
                                    petCareProvider.profilePicture!,
                                    fit: BoxFit.cover,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showAlertDialogNOProfile(
                                              context, petCareProvider);
                                        },
                                        child: Text(
                                            "You haven't set your profile picture"),
                                      ),
                                      Text("Click here for profile Picture"),
                                    ],
                                  ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // _profile(signUpProvider, petCareProvider),
                        Container(
                          height: 200,
                          color: Colors.green,
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 100,
                          color: Colors.red,
                        ),
                        Container(
                          height: 200,
                          color: Colors.green,
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue,
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

  Widget _profile(
      SignUpProvider signUpProvider, PetCareProvider petCareProvider) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerifyYourAccount()));
          },
          child: ClipRRect(
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        height: 40,
                        width: 40,
                        child: petCareProvider.profilePicture != null
                            ? Image.network(
                                petCareProvider.profilePicture!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset("assets/images/emptypp.png")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                ],
              ),
            ),
          ),
        ));
  }

  pickImageFromGallery(PetCareProvider petCareProvider) async {
    final userImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (userImage == null) return;
    await petCareProvider.setImage(userImage);
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
              petCareProvider.userImage != null
                  ? Image.file(File(petCareProvider.userImage!.path))
                  : SizedBox()
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
