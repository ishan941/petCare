import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class YourProfession extends StatefulWidget {
  const YourProfession({Key? key}) : super(key: key);

  @override
  State<YourProfession> createState() => _YourProfessionState();
}

class _YourProfessionState extends State<YourProfession> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> professionList = ["Shop", "Medical", "Trainer"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: Text(
          ("OurService Form"),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => ourServiceProvider
                    .dashServiceUtil ==
                StatusUtil.loading
            ? Center(
                child: CircularProgressIndicator(), // Show loading indicator
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          // height: MediaQuery.of(context).size.height * .8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Full name"),
                              SizedBox(
                                height: 5,
                              ),
                              ShopTextForm(
                                hintText: enterYourFullNameStr,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please${enterYourFullNameStr}";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.userName = val;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(emailStr),
                              SizedBox(
                                height: 5,
                              ),
                              ShopTextForm(
                                hintText: emailStr,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "$pleaseEnterStr$emailStr";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.email = val;
                                },
                              ),
                              SizedBox(height: 15,),
                              Text(selectProfessionStr),
                              SizedBox(
                                height: 5,
                              ),
                              ShopTextForm(
                                hintText: emailStr,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "$pleaseEnterStr$emailStr";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.service = val;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              
                              // CustomDropDown(
                              //     onChanged: (value) {
                              //       ourServiceProvider.service = value;
                              //     },
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return valiProfissionStr;
                              //       }
                              //       return null;
                              //     },
                              //     hintText: selectProfessionStr,
                              //     itemlist: professionList),
                              SizedBox(
                                height: 15,
                              ),
                              Text(contactNumberStr),
                              SizedBox(
                                height: 5,
                              ),
                              ShopTextForm(
                                hintText: contactNumberStr,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "$pleaseEnterStr$contactNumberStr";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.phone = val;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Description"),
                              ShopTextForm(
                                hintText: "Description",
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "$pleaseEnterStr$contactNumberStr";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.description = val;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Location"),
                              ShopTextForm(
                                hintText: "Location",
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "$pleaseEnterStr$contactNumberStr";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  ourServiceProvider.loaction = val;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(uploadforPpStr),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pickImageFromGallery(ourServiceProvider);
                                    },
                                    child: DottedBorder(
                                      dashPattern: [5, 5, 5, 5],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      padding: EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          child: Icon(
                                            Icons.add,
                                            size: 70,
                                          ),
                                          height: 120,
                                          width: 120,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      height: 120,
                                      width: 120,
                                      child:
                                          ourServiceProvider.profilePicture !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    File(ourServiceProvider
                                                        .profilePicture!.path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : SizedBox()),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .9,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await ourServiceProvider
                                            .saveOurServiceDto();
                                        if (ourServiceProvider
                                                .ourServiceDtoUtil ==
                                            StatusUtil.success) {
                                          Helper.snackBar(
                                              successfullySavedStr, context);
                                          Navigator.pop(context);
                                          ourServiceProvider
                                              .clearOurServiceDtoData();
                                        } else if (ourServiceProvider
                                                .ourServiceDtoUtil ==
                                            StatusUtil.error) {
                                          Helper.snackBar(
                                              failedToSaveStr, context);
                                        }
                                      }
                                    },
                                    child: Text(submitStr)),
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  pickImageFromGallery(OurServiceProvider ourServiceProvider) async {
    final profilePicture =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (profilePicture == null) return;

    ourServiceProvider.setProfilPicture(profilePicture);
  }
}
