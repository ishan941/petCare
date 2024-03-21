import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/ads.dart';
import 'package:project_petcare/provider/ads_provider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:provider/provider.dart';

class AdsForm extends StatefulWidget {
  final Ads? ads;
   AdsForm({super.key, this.ads});

  @override
  State<AdsForm> createState() => _AdsFormState();
}

class _AdsFormState extends State<AdsForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdsProvider>(
        builder: (context, adsProvider, child) => SafeArea(
          child: Stack(
            children: [formForAds(adsProvider, context),
             loader(adsProvider)],
          ),
        ),
      ),
    );
  }

  Widget loader(AdsProvider adsProvider) {
    adsProvider.saveAdsUtil == StatusUtil.loading
        ? Helper.loadingAnimation(context)
        : SizedBox();
    return SizedBox();
  }

  Widget formForAds(AdsProvider adsProvider, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton.filled(
                  color: Colors.red,
                  onPressed: () {
                    adsProvider.clearImage();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                pickImageFromGallery(adsProvider);
              },
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: ColorUtil.primaryColor,
                  child: Column(
                    children: [
                      adsProvider.image == null
                          ? Center(child: Text("Please double click for add ads"))
                          : Column(
                              children: [
                                Container(
                                  // height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                    File(
                                      adsProvider.image!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                     
                                      Helper.loadingAnimation(context);
                                      adsProvider.sendAdsImage();
                                      if (adsProvider.saveAdsUtil ==
                                          StatusUtil.success) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavBar()),
                                            (route) => false);
                                        Helper.snackBar(
                                            successfullySavedStr, context);
                                             adsProvider.clearImage();
                                        
                                      } else {
                                        Helper.snackBar(failedToSaveStr, context);
                                      }
                                    },
                                    child: Text("Save"))
                              ],
                            ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

//   @override
//   void dispose() {
//     clearFrom();
//     super.dispose();
//   }

//   clearFrom() {
//     var provider = Provider.of<AdsProvider>(context, listen: false);
//     provider.clearImage();
//   }
}

pickImageFromGallery(AdsProvider adsProvider) async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;
  await adsProvider.setImage(image);
}
