import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/sharedpref.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/payment.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/edit/adminedit.dart';
import 'package:project_petcare/view/feeds/approve_selling.dart';
import 'package:project_petcare/view/feeds/approvel.dart';
import 'package:project_petcare/view/profile/about_us.dart';
import 'package:project_petcare/view/profile/changepassword.dart';
import 'package:project_petcare/view/form_collections.dart';
import 'package:project_petcare/view/profile/mypayments.dart';
import 'package:project_petcare/view/profile/myprofile.dart';
import 'package:project_petcare/view/profile/paymentlist.dart';
import 'package:project_petcare/view/shop/mycart.dart';
import 'package:project_petcare/view/shop/shopFavourite.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  final SignUp? signUp;
  Account({super.key, this.signUp});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isSwitched = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getUser();
    });

    super.initState();
  }

  getUser() async {
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    await petCareProvider.getTokenFromSharedPref();
    await petCareProvider.getUserEmail();
    await petCareProvider.getUserName();
    await petCareProvider.getUserFullName();
    await petCareProvider.getUserPhone();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtil.primaryColor,
          actionsIconTheme: IconThemeData.fallback(),
          elevation: 0,
          title: Text(
            accountStr,
            style: appBarTitle,
          ),
        ),
        backgroundColor: ColorUtil.primaryColor,
        body: Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) =>
              Consumer<SignUpProvider>(
            builder: (context, signUpProvider, child) => SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .12),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Container(
                              color: ColorUtil.BackGroundColorColor,
                              height: MediaQuery.of(context).size.height,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .08),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyProfile()));
                              },
                              child: profile(
                                  context, petCareProvider, signUpProvider),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _general(context),
                          _preferences(context, petCareProvider),
                          // petCareProvider.userEmail == "admin@gmail.com"
                              // ? 
                              _forms(context, petCareProvider)
                              // : SizedBox()
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profile(BuildContext context, PetCareProvider petCareProvider,
      SignUpProvider signUpProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorUtil.primaryColor, ColorUtil.BackGroundColorColor],
        ),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .2,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: petCareProvider.profilePicture != null
                                ? NetworkImage(petCareProvider.profilePicture!)
                                : AssetImage("assets/images/emptypp.png")
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        top: 39,
                        child: GestureDetector(
                          onTap: () {
                            // petCareProvider.profilePicture != null
                            //     ? _showAlertDialog(context, petCareProvider)
                            //     : showAlertDialogNOProfile(
                            //         context, petCareProvider);
                            // pickImageFromGallery(petCareProvider);
                            showAlertDialogNOProfile(context, petCareProvider);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("My Profile"),
                Text(
                  petCareProvider.userFullName ?? "User",
                  style: mainTitleText,
                ),
                Text(petCareProvider.userEmail ?? " No email found"),
                Text(petCareProvider.userPhone ?? " No phone found"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _general(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(generalStr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                SizedBox(height: 15),
                _userDetails(context),
                // _changePassword(context),
                _myPayments(context),
                _myFavourites(context),
                _myCart(context),
                _aboutUs(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _preferences(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(preferenceStr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                SizedBox(height: 15),
                _notification(context, petCareProvider),
                _logOut(context, petCareProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forms(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forms",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)),
                SizedBox(height: 15),
                _formCollection(context, petCareProvider),
                _payments(context, petCareProvider),
                _formsEdit(context, petCareProvider),
                _approveDonate(context, petCareProvider),
                _approveSelling(context, petCareProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userDetails(BuildContext context) {
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
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: ColorUtil.primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.person_2_outlined)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      userDetailsStr,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _changePassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangePassword()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.lock_outlined)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myPayments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyPayments()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.lock_outlined)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "My Payments",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myFavourites(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShopFavourite()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.favorite_border)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "My Favourites",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyCart()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.favorite_border)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "My Cart",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutUs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutUs()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.pets)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "About us",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notification(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          // dialogBuilder(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: ColorUtil.primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: 45,
                        child: Icon(Icons.notifications_none_rounded)),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Switch(
                        value: petCareProvider.isSwitched,
                        onChanged: (value) {
                          petCareProvider.getToggledSwitch();
                        },
                        activeTrackColor: ColorUtil.primaryColor,
                        activeColor: ColorUtil.primaryColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formCollection(
      BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FormCollection()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Form Collection",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _payments(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Payments()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Pay ments",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formsEdit(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditListUi()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Edit Forms",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logOut(BuildContext context, PetCareProvider petCareProvider) {
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
                Row(
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
                      logOutStr,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _approveDonate(BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DonatedApprove()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Approvel Donation",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _approveSelling(
      BuildContext context, PetCareProvider petCareProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SellingApprove()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      "Approve Selling",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
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

  void _addUserImage(BuildContext context, PetCareProvider petCareProvider) {
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
                // await petCareProvider.uploadeImageInFirebase();
                await petCareProvider.sendUserDetails();
                // await petCareProvider.updateProfilePicture();
                if (petCareProvider.userImageUtil == StatusUtil.success) {
                  Helper.snackBar(successfullySavedStr, context);
                  Navigator.pop(context);
                } else {
                  Helper.snackBar(failedToSaveStr, context);
                  Navigator.pop(context);
                }
              },
              child: Text("Upload"),
            ),
          ],
        );
      },
    );
  }

  void showAlertDialogNOProfile(
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
          content: Container(
              height: MediaQuery.of(context).size.height * .2,
              child: Column(
                children: [
                  Text(
                      "Do You want to add your profile picture for your account?"),
                  if (petCareProvider.userImage != null)
                    Container(
                      height: 120, // Adjust the size as needed
                      width: 120, // Adjust the size as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              FileImage(File(petCareProvider.userImage!.path)),
                        ),
                      ),
                    ),
                ],
              )),
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
                // await petCareProvider.uploadeImageInFirebase();
                await petCareProvider.sendUserDetails();
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
