import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/view/customs/consttextform.dart';
import 'package:provider/provider.dart';

class DonateNow extends StatefulWidget {
  const DonateNow({super.key});

  @override
  State<DonateNow> createState() => _DonateNowState();
}

class _DonateNowState extends State<DonateNow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? petname,
      petweight,
      petage,
      gender,
      petbread,
      imageUrl,
      location,
      phone;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: ColorUtil.BackGroundColorColor,
          title: Text(
            donateNowStr,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<DonateProvider>(
                builder: (context, donateProvider, child) => Stack(
                      children: [
                        uiforDonateFore(context, donateProvider),
                        loader(donateProvider)
                      ],
                    )),
          ),
        ),
      ),
    );
  }

  Widget loader(DonateProvider donateProvider) {
    if (donateProvider.donageUtil == StatusUtil.loading) {
      return Helper.backdropFilter(context);
    } else {
      return const SizedBox();
    }
  }

  Widget uiforDonateFore(BuildContext context, DonateProvider donateProvider) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignm
        //ent: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(20),
                  //   boxShadow: [
                  //      BoxShadow(
                  //             spreadRadius: 10,
                  //             blurRadius: 3,
                  //             color: const Color.fromARGB(255, 13, 10, 10).withOpacity(0.5),
                  //             offset: Offset(2, 4),
                  //           ),
                  //   ]
                  // ),

                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: donateProvider.image != null
                      ? Image.file(File(donateProvider.image!.path))
                      : Image.asset(
                          "assets/images/cat pp.jpeg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 3),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            height: 60,
                            width: 50,
                            child: donateProvider.image != null
                                ? Image.file(File(donateProvider.image!.path))
                                : Image.asset(
                                    "assets/images/rabbitCategories.png")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        return null;
                      },
                      icon: const Icon(
                        Icons.photo_library_sharp,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 60,
                      width: 50,
                      child: IconButton(
                          onPressed: () {
                            pickImageFromGallery(donateProvider);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          )))
                ],
              ),
            ],
          ),
          Text(
            petNameStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: luffyStr,
            validator: (value) {
              if (value!.isEmpty) {
                return petNameValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              petname = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            petWeightStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: hintweightStr,
            validator: (value) {
              if (value!.isEmpty) {
                return petWeightValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              petweight = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            petAgeStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: hintAgeStr,
            validator: (value) {
              if (value!.isEmpty) {
                return petAgeValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              petage = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            petSexStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: hintpetSexStr,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            validator: (value) {
              if (value!.isEmpty) {
                return petSexValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              gender = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            petBreadStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: hintBreadStr,
            validator: (value) {
              if (value!.isEmpty) {
                return petBreadValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              petbread = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            locationStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: locationStr,
            validator: (value) {
              if (value!.isEmpty) {
                return locationValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              location = value;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            contactNumberStr,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.5)),
          ),
          ConstTextForm(
            hintText: contactNumberStr,
            validator: (value) {
              if (value!.isEmpty) {
                return phoneValidatorStr;
              }
              return null;
            },
            onChanged: (value) {
              phone = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorUtil
                          .primaryColor // Change this color to the desired background color
                      ),
                  onPressed: () async {
                    await donateProvider.uploadImageInFireBase();

                    if (_formKey.currentState!.validate() &&
                        donateProvider.image != null) {
                      Donate donate = Donate(
                          imageUrl: donateProvider.imageUrl,
                          petname: petname,
                          location: location,
                          phone: phone,
                          petage: petage,
                          petweight: petweight,
                          gender: gender,
                          petbread: petbread);
                      await donateProvider.donateData(donate).then((value) {
                        if (donateProvider.donageUtil == StatusUtil.success) {
                          Helper.snackBar(successfullySavedStr, context);
                        } else {
                          Helper.snackBar(failedToSaveStr, context);
                        }
                      });
                    } else {
                      Helper.snackBar("Hello", context);
                    }
                  },
                  child: Text(submitStr))),
          Container(
            height: 100,
          )
        ],
      ),
    );
  }

  pickImageFromGallery(DonateProvider donateProvider) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) return;

    donateProvider.setImage(image);
  }
}
