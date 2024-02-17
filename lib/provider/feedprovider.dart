import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/feed.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class FeedProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  SignUpProvider signUpProvider = SignUpProvider();
  PetCareProvider petCareProvider = PetCareProvider();

  List<Feed> feedList = [];

  String? errorMessage;

  XFile? image;

  String? userName;
  String? profile;
  String? contains;
  String? imageUrl;
  String? id;

  StatusUtil _feedUtil = StatusUtil.idle;
  StatusUtil _uploadImageUtil = StatusUtil.idle;
  StatusUtil _getFeedUtil = StatusUtil.idle;

  StatusUtil get feedUtil => _feedUtil;
  StatusUtil get uploadImageUtil => _feedUtil;
  StatusUtil get getFeedUtil => _getFeedUtil;

  setFeedUtil(StatusUtil statusUtil) {
    _feedUtil = statusUtil;
    notifyListeners();
  }

  setGetFeedUtil(StatusUtil statusUtil) {
    _getFeedUtil = statusUtil;
    notifyListeners();
  }

  setUploadImageUtil(StatusUtil statusUtil) {
    _uploadImageUtil = statusUtil;
    notifyListeners();
  }

  setImage(XFile? image) {
    this.image = image;
    notifyListeners();
  }

  setImageUrl(String? imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  setProfile(String? profile) {
    this.profile = profile;
    notifyListeners();
  }
  
  setUserName(String? userName){
    this.userName = userName;
    notifyListeners();
  }

   void handleDoubleTap(int index){
    if(index >= 0 && index < feedList.length){
      Feed feed = feedList[index];
      feed.isDoubleTapped = !feed.isDoubleTapped;
      notifyListeners();
    }
  }

  Future<void> uploadFeedImageInFireBase() async {
    if (_uploadImageUtil != StatusUtil.loading) {
      setUploadImageUtil(StatusUtil.loading);
    }
    if (image != null) {
      final adoptImageUploadRef = FirebaseStorage.instance.ref();
      var adoptImageRef = adoptImageUploadRef.child("${image!.name}");
      try {
        await adoptImageRef.putFile(File(image!.path));
        final downlaodAdoptImageUrl = await adoptImageRef.getDownloadURL();
        imageUrl = downlaodAdoptImageUrl;
        setUploadImageUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setUploadImageUtil(StatusUtil.error);
      }
    }
  }

  Future<void> saveFeedToFireBase() async {
    if (_feedUtil != StatusUtil.loading) {
      setFeedUtil(StatusUtil.loading);
    }
    await uploadFeedImageInFireBase();
    Feed feed = Feed(
      id: id,
      name: userName,
      profile: profile,
      contains: contains,
      image: imageUrl,
    );
    FireResponse response = await petCareService.saveFeedValue(feed);

    try {
      if (response.statusUtil == StatusUtil.success) {
        setFeedUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setFeedUtil(
          StatusUtil.error,
        );
      }
    } catch (e) {
      errorMessage = "$e";
      setFeedUtil(StatusUtil.error);
    }
  }

  Future<void> getFeedValueFromFireBase() async {
    if (_getFeedUtil != StatusUtil.loading) {
      setGetFeedUtil(StatusUtil.loading);
    }

    try {
      var response = await petCareService.getFeedValue();
      feedList = response.data;
      if (response.statusUtil == StatusUtil.success) {
        setGetFeedUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetFeedUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetFeedUtil(StatusUtil.error);
    }
  }
}
