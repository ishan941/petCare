import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/feedprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class FeedForm extends StatefulWidget {
  const FeedForm({super.key});

  @override
  State<FeedForm> createState() => _FeedFormState();
}

class _FeedFormState extends State<FeedForm> {
  @override
  void initState() {
    getvalue();
    super.initState();
  }

  getvalue() async {
    var feedProvider = Provider.of<FeedProvider>(context, listen: false);
    var petcareProvider = Provider.of<PetCareProvider>(context, listen: false);
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      feedProvider.setProfile(petcareProvider.profilePicture!);
      feedProvider.setUserName(signUpProvider.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: const Text(
          "Create Containe",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<PetCareProvider>(
          builder: (context, petCareProvider, child) => Consumer<FeedProvider>(
            builder: (context, feedProvider, child) => Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(petCareProvider.profilePicture!),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pet Details"),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Next Step: Your Details"),
                      ],
                    ),
                  ]),
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Add your contain"),
                      ShopTextForm(
                        onChanged: (value) {
                          feedProvider.contains = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          pickImageFromGalleryForFeed(feedProvider);
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child:
                              //
                              feedProvider.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: feedProvider.imageUrl != null &&
                                              feedProvider.image != null
                                          ? Image.network(
                                              feedProvider.imageUrl!)
                                          : feedProvider.image != null
                                              ? Image.file(
                                                  File(
                                                      feedProvider.image!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : SizedBox())
                                  : Icon(
                                      Icons.photo_library_outlined,
                                      size: 70,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                          child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        child: ElevatedButton(
                            onPressed: () async {
                              await feedProvider.saveFeedToFireBase();
                              {
                                if (feedProvider.feedUtil ==
                                    StatusUtil.success) {
                                  Helper.snackBar(
                                      successfullySavedStr, context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar()));
                                } else {
                                  Helper.snackBar(failedToSaveStr, context);
                                }
                              }
                            },
                            child: const Text(submitStr)),
                      )),
                      const SizedBox(
                        height: 80,
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

  pickImageFromGalleryForFeed(FeedProvider feedProvider) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) return;

    feedProvider.setImage(image);
  }
}
