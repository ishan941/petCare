import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class AdoptProvider extends ChangeNotifier {
  String? errorMessage, imageUrl;
  XFile? image;

  String? petname, name;

  String? petweight;
  String? petage, petageclc;
  String? gender, phone, location;
  String? petbread;

  double _per = 0.0;
  double get per => _per;
  void updatePercent(double value) {
    _per = value;
    notifyListeners();
  }

  List<Adopt> adoptDetailsList = [];

  PetCareService petCareService = PetCareImpl();

  StatusUtil _adoptUtil = StatusUtil.idle;
  StatusUtil _uploadImageUtil = StatusUtil.idle;
  StatusUtil _getAdoptDetails = StatusUtil.idle;
  StatusUtil _deleteAdoptDetails = StatusUtil.idle;

  StatusUtil get adoptUtil => _adoptUtil;
  StatusUtil get uploadImageUtil => _uploadImageUtil;
  StatusUtil get getAdoptDetails => _getAdoptDetails;
  StatusUtil get deleteAdoptDetails => _deleteAdoptDetails;

  setGetAdoptDetails(StatusUtil statusUtil) {
    _getAdoptDetails = statusUtil;
    notifyListeners();
  }

  setUploadImageUtil(StatusUtil statusUtil) {
    _uploadImageUtil = statusUtil;
    notifyListeners();
  }

  setAdoptUtil(StatusUtil statusUtil) {
    _adoptUtil = statusUtil;
    notifyListeners();
  }

  setDeleteAdoptUtil(StatusUtil statusUtil) {
    _deleteAdoptDetails = statusUtil;
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

  Future<void> deleteAdoptData(String id) async {
    if (_deleteAdoptDetails != StatusUtil.loading) {
      setDeleteAdoptUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.deleteAdoptById(id);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteAdoptUtil(StatusUtil.success);
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeleteAdoptUtil(StatusUtil.error);
    }
  }

  Future<void> uploadAdoptImageInFireBase() async {
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
        setAdoptUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setAdoptUtil(StatusUtil.error);
      }
    }
  }

  Future<void> adoptDetails(Adopt adopt) async {
    if (_adoptUtil != StatusUtil.loading) {
      setAdoptUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.adoptDetails(adopt);
      if (response.statusUtil == StatusUtil.success) {
        setAdoptUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        setAdoptUtil(StatusUtil.error);
        errorMessage = response.errorMessage;
      }
    } catch (e) {
      errorMessage = "$e";

      setAdoptUtil(StatusUtil.error);
    }
  }

  sendAdoptValueToFireBase(BuildContext context) async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
      petname: petname,
      petage: petage,
      imageUrl: imageUrl,
      petbread: petbread,
      petweight: petweight,
      phone: phone,
      name: name,
      location: location,
      gender: gender,
    );
    await petCareService.adoptDetails(adopt).then((value) {
      if (adoptUtil == StatusUtil.success) {
        Helper.snackBar(successfullySavedStr, context);
      } else {
        Helper.snackBar(failedToSaveStr, context);
      }
    });
  }

  Future<void> getAdoptdata() async {
    if (_getAdoptDetails != StatusUtil.loading) {
      setGetAdoptDetails(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getAdoptDetails();
      if (response.statusUtil == StatusUtil.success) {
        adoptDetailsList = response.data;
        setGetAdoptDetails(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setGetAdoptDetails(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetAdoptDetails(StatusUtil.error);
    }
  }
}
