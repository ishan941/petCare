import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class DonateProvider extends ChangeNotifier {
  String? imageUrl, errorMessage;
  XFile? image;
  PetCareService petCareService = PetCareImpl();
  List<Donate> donatePetList = [];

  StatusUtil _donageUtil = StatusUtil.idle,
      _petDetailsStatus = StatusUtil.idle,
      _donatePetImageUtil = StatusUtil.idle;

  StatusUtil get donatePetImageUtil => _donatePetImageUtil;
  StatusUtil get donageUtil => _donageUtil;
  StatusUtil get petDetailsStatus => _petDetailsStatus;

  setDonatePetImageUtil(StatusUtil statusUtil) {
    _donatePetImageUtil = statusUtil;
    notifyListeners();
  }

  setPetDetailsStatus(StatusUtil statusUtil) {
    _petDetailsStatus = statusUtil;
    notifyListeners();
  }

  setDonateUtil(StatusUtil statusUtil) {
    _donageUtil = statusUtil;
    notifyListeners();
  }
// Future<void> adoptData(Donate donate) async{
//   if(_donatePetImageUtil != StatusUtil.loading){
//     setDonatePetImageUtil(StatusUtil.loading);
//   }
//   try{
// FireResponse response = await petCareService.adoptData(donate);
// if(response.statusUtil == StatusUtil.success){
//   setDonatePetImageUtil(StatusUtil.success);
// }
//   }catch(e){

//     setDonatePetImageUtil(StatusUtil.error);
//   }
// }
  Future<void> donateData(Donate donate) async {
    if (_donageUtil != StatusUtil.loading) {
      setDonateUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.donateData(donate);
      if (response.statusUtil == StatusUtil.success) {
        setDonateUtil(StatusUtil.success);
        image = null;
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setDonateUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = unExpectedErroeStr;
      setDonateUtil(StatusUtil.error);
    }
  }

  StatusUtil _uploadImageStatus = StatusUtil.idle;
  StatusUtil get uploadImageStatus => _uploadImageStatus;

  setUploadImageStatus(StatusUtil statusUtil) {
    _uploadImageStatus = statusUtil;
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

  Future<void> uploadImageInFireBase() async {
    setUploadImageStatus(StatusUtil.loading);

    if (image != null) {
      // List<String> extension = image!.name.split(".");
      final storageRef = FirebaseStorage.instance.ref();
      var mountainRef = storageRef.child("${image!.name}");
      try {
        await mountainRef.putFile(File(image!.path));
        final downloadUrl = await mountainRef.getDownloadURL();
        imageUrl = downloadUrl;
        setUploadImageStatus(StatusUtil.success);
      } catch (e) {
        setUploadImageStatus(StatusUtil.error);
      }
    }

    Future<void> donateData(Donate donate) async {
      if (_uploadImageStatus != StatusUtil.loading) {
        setUploadImageStatus(StatusUtil.loading);
      }

      try {
        FireResponse response = await petCareService.donateData(donate);
        if (response.statusUtil == StatusUtil.success) {
          setDonateUtil(StatusUtil.success);
        } else if (response.statusUtil == StatusUtil.error) {
          errorMessage = response.errorMessage;
          setDonateUtil(StatusUtil.error);
        }
      } catch (e) {
        errorMessage = unExpectedErroeStr;
        setDonateUtil(StatusUtil.error);
      }
    }
  }

  Future<void> petDetails() async {
    if (petDetailsStatus != StatusUtil.loading) {
      setPetDetailsStatus(StatusUtil.loading);
    }
    FireResponse response = await petCareService.getPetDetails();
    if (response.statusUtil == StatusUtil.success) {
      donatePetList = response.data;
      setPetDetailsStatus(StatusUtil.success);
    } else if (response.statusUtil == StatusUtil.error) {
      errorMessage = response.errorMessage;
      setPetDetailsStatus(StatusUtil.error);
    }
  }
}
