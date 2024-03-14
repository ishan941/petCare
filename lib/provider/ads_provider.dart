import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/ads.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdsProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  String? errorMessage;
  String? imageUrl;
  XFile? image;
  String token = "";
 List<Ads> adsImageList = [];

  StatusUtil _saveAdsUtil = StatusUtil.idle;
  StatusUtil _getAdsUtil = StatusUtil.idle;
  StatusUtil _uploadeImageUtil = StatusUtil.idle;

  StatusUtil get saveAdsUtil => _saveAdsUtil;
  StatusUtil get getAdsUtil => _getAdsUtil;
  StatusUtil get uploadeImageUtil => _uploadeImageUtil;

  setSaveAdsUtil(StatusUtil statusUtil) {
    _saveAdsUtil = statusUtil;
    notifyListeners();
  }

  setGetAdsUtil(StatusUtil statusUtil) {
    _getAdsUtil = statusUtil;
    notifyListeners();
  }

  setUploadeImageUtil(StatusUtil statusUtil) {
    _uploadeImageUtil = statusUtil;
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

  Future<void> uploadeImageInFireBase() async {
    if (_uploadeImageUtil == StatusUtil.loading) {
      setUploadeImageUtil(StatusUtil.loading);
    }
    try {
      if (image != null) {
        final adsImageStorageRef = FirebaseStorage.instance.ref();
        var imageStorageRef = adsImageStorageRef.child("${image!.name}");
        await imageStorageRef.putFile(File(image!.path));
        final downloadeUrl = await imageStorageRef.getDownloadURL();
        imageUrl = downloadeUrl;
        setSaveAdsUtil(StatusUtil.success);
      }
    } catch (e) {
      errorMessage = "$e";
      setUploadeImageUtil(StatusUtil.error);
    }
  }

  void clearImage() {
    image = null;
    notifyListeners();
  }

  Future<void> sendAdsImage() async {
    if (saveAdsUtil == StatusUtil.loading) {
      setSaveAdsUtil(StatusUtil.loading);
    }
    await uploadeImageInFireBase();
    Ads ads = Ads(adsImage: imageUrl);
    try {
      ApiResponse response = await petCareService.saveAdsImage(ads, token);
      if (response.statusUtil == StatusUtil.success) {
        setSaveAdsUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setSaveAdsUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setSaveAdsUtil(StatusUtil.error);
    }
  }

  Future<void> getAdsImage() async {
    if (getAdsUtil == StatusUtil.loading) {
      setGetAdsUtil(StatusUtil.loading);
    }
  
      ApiResponse response = await petCareService.getAdsImage(token);
      if (response.statusUtil == StatusUtil.success) {
        adsImageList = Ads.listFromJson(response.data['data']);
        setGetAdsUtil(StatusUtil.success);
      } else if(response.statusUtil == StatusUtil.error){
        errorMessage = response.errorMessage;
        setGetAdsUtil(StatusUtil.error);
      }
   
  }
   Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
