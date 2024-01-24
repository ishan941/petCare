import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class OurServiceProvider extends ChangeNotifier {
  String? errorMessage;
  String? service;
  String? medical, shop, trainner;
  String? cpimageUrl, ppimageUrl, profilePictureUrl;
  String? profession, fullname, phone, email;
  XFile? cpimage, ppimage, profilePicture;
  List<DashService> dashServiceList = [];

  PetCareService petCareService = PetCareImpl();

  StatusUtil _dashServiceUtil = StatusUtil.idle;
  StatusUtil _profilePictureUtil = StatusUtil.idle;
  StatusUtil _professionUtil = StatusUtil.idle;

  StatusUtil get dashServiceUtil => _dashServiceUtil;
  StatusUtil get profilePictureUtil => _profilePictureUtil;
  StatusUtil get professionUtil => _professionUtil;

  setDashServiceUtil(StatusUtil statusUtil) {
    _dashServiceUtil = statusUtil;
    notifyListeners();
  }

  setProfilePictureUtil(StatusUtil statusUtil) {
    _profilePictureUtil = statusUtil;
    notifyListeners();
  }
  setProfessionUtil(StatusUtil statusUtil){
    _professionUtil =statusUtil;
    notifyListeners();
  }

  Future<void> saveProfessionData(OurService ourService)async{
    if(_professionUtil != StatusUtil.loading){
      setProfessionUtil(StatusUtil.loading);
    }
    try{
      FireResponse response = await petCareService.saveProfessionData(ourService);
      if(response.statusUtil == StatusUtil.success){
        setProfessionUtil(StatusUtil.success);
      }else if(response.statusUtil == StatusUtil.error){
        errorMessage = response.errorMessage;
        setProfessionUtil(StatusUtil.error,);
      }

    }catch(e){
      errorMessage = "$e";
      setProfessionUtil(StatusUtil.error);
    }
  }

  Future<void> saveDashServiceDetails(DashService dashService) async {
    if (_dashServiceUtil != StatusUtil.loading) {
      setDashServiceUtil(StatusUtil.loading);
    }
    try {
      FireResponse response =
          await petCareService.saveDashServiceDetails(dashService);
      if (response.statusUtil == StatusUtil.success) {
        setDashServiceUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setDashServiceUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setDashServiceUtil(StatusUtil.error);
    }
  }

  Future<void> uploadProfilePicture(OurService ourService) async {
    if (_profilePictureUtil != StatusUtil.loading) {
      setProfilePictureUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.ourServiceData(ourService);
      if (response.statusUtil == StatusUtil.success) {
        setProfilePictureUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setProfilePictureUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setProfilePictureUtil(StatusUtil.error);
    }
  }

  Future<void> dashServiceDetails() async {
    if (_dashServiceUtil != StatusUtil.loading) {
      setDashServiceUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getDashServiceDetails();
      if (response.statusUtil == StatusUtil.success) {
        dashServiceList = response.data;
        setDashServiceUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setDashServiceUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setDashServiceUtil(StatusUtil.error);
    }
  }

  setImage(XFile? cpimage) {
    this.cpimage = cpimage;
    notifyListeners();
  }

  setProfilPicture(XFile? profilePicture) {
    this.profilePicture = profilePicture;
    notifyListeners();
  }

  setPpImage(XFile? ppimage) {
    this.ppimage = ppimage;
    notifyListeners();
  }

  setImageUrl(String? cpimageUrl) {
    cpimageUrl = cpimageUrl;
    notifyListeners();
  }

  setPpImageUrl(String? ppimageUrl) {
    ppimageUrl = ppimageUrl;
    notifyListeners();
  }

  setProfilePictureUrl(String? profilePictureUrl) {
    profilePictureUrl = profilePictureUrl;
    notifyListeners();
  }

  uploadImageInFireBaseForDashService() async {
    setDashServiceUtil(StatusUtil.loading);
    if (cpimage != null) {
      List<String> extension = cpimage!.name.split(".");
      final storageRef = FirebaseStorage.instance.ref();
      var mountainRef = storageRef.child("${cpimage!.name}");
      try {
        await mountainRef.putFile(File(cpimage!.path));
        final downloadUrl = await mountainRef.getDownloadURL();
        cpimageUrl = downloadUrl;
        setDashServiceUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setDashServiceUtil(StatusUtil.error);
      }
    }
  }

  uploadImageInFirebaseForPpImage() async {
    setDashServiceUtil(StatusUtil.loading);
    if (ppimage != null) {
      List<String> extension = ppimage!.name.split(".");
      final firebaseStorageRef = FirebaseStorage.instance.ref();
      var firebaseMountainRef = firebaseStorageRef.child("${ppimage!.name}");
      try {
        await firebaseMountainRef.putFile(File(ppimage!.path));
        final downloadPpimageUrl = await firebaseMountainRef.getDownloadURL();
        ppimageUrl = downloadPpimageUrl;
        setDashServiceUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setDashServiceUtil(StatusUtil.error);
      }
    }
  }

  uploadProfilePictureInFireBase() async {
    if (_profilePictureUtil != StatusUtil.loading) {
      setProfilePictureUtil(StatusUtil.loading);
    }
    if (profilePicture != null) {
      List<String> extension = profilePicture!.name.split(".");
      final storeProfilePictureImageInFireBaseRef =
          FirebaseStorage.instance.ref();
      var storeProfilePictureImageRef = storeProfilePictureImageInFireBaseRef
          .child("${profilePicture!.name}");
      try {
        await storeProfilePictureImageRef.putFile(File(profilePicture!.path));
        final downloadStoreProfilePictireUrl =
            await storeProfilePictureImageRef.getDownloadURL();
        profilePictureUrl = downloadStoreProfilePictireUrl;
        setProfilePictureUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setProfilePictureUtil(StatusUtil.error);
      }
    }
  }

  sendValueToFirBase(BuildContext context) async {
    await uploadImageInFireBaseForDashService();
    await uploadImageInFirebaseForPpImage();
    DashService dashService =
        DashService(cpImage: cpimageUrl, ppImage: ppimageUrl, service: service);
    await petCareService.saveDashServiceDetails(dashService);
  }
  sendProfessionValueToFireBase(BuildContext context)async{
    await uploadProfilePictureInFireBase();
    OurService ourService = OurService(
      profession: profession,
      fullname: fullname,
      email: email,
      phone: phone,
      medical: medical,

    );
    await petCareService.saveProfessionData(ourService).then((value) {
      if(professionUtil == StatusUtil.success){
        Helper.snackBar(successfullySavedStr, context);
      }else if (professionUtil == StatusUtil.error){
        Helper.snackBar(failedToSaveStr, context);
      }

    });
  }
}
