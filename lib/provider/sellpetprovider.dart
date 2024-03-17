import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellingPetProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  List<Adopt> donatePetList = [];
  List<Adopt> sellingPetList = [];
  String? errorMessage;
  XFile? image;
  String token = "";

  String? id,
      petName,
      petAge,
      petAgeTime,
      petGender,
      imageUrl,
      petCategories,
      userImage,
      petWeight,
      description,
      ownerPhone,
      ownerName,
      ownerLocation,
      petPrice;

  StatusUtil _uploadImageUtil = StatusUtil.idle;
  StatusUtil _saveSellingPetUtil = StatusUtil.idle;
  StatusUtil _getSellingPetUtil = StatusUtil.idle;

  StatusUtil _saveDonatePetUtil = StatusUtil.idle;
  StatusUtil _getDonatePetUtil = StatusUtil.idle;

  StatusUtil get saveSellingPetutil => _saveSellingPetUtil;
  StatusUtil get getSellingPetUtil => _getSellingPetUtil;
  StatusUtil get uploadImageUtil => _uploadImageUtil;

  StatusUtil get saveDonatePet => _saveDonatePetUtil;
  StatusUtil get getDonatePet => _getDonatePetUtil;

  setUploadImageUtil(StatusUtil statusUtil) {
    _uploadImageUtil = statusUtil;
    notifyListeners();
  }

  setSaveSellingPet(StatusUtil statusUtil) {
    _saveSellingPetUtil = statusUtil;
    notifyListeners();
  }

  setGetSellingPet(StatusUtil statusUtil) {
    _getSellingPetUtil = statusUtil;
    notifyListeners();
  }

  setSaveDonatePet(StatusUtil statusUtil) {
    _saveDonatePetUtil = statusUtil;
    notifyListeners();
  }

  setGetDonatePet(StatusUtil statusUtil) {
    _getDonatePetUtil = statusUtil;
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

  String _petCategories = '';
  String _petBreed = '';
  List<String> _breedList = [];

  String get setPetCategories => _petCategories;

  set setPetCategories(String value) {
    _petCategories = value;
    setBreedList(_getBreedList(value));
    notifyListeners();
  }

  String get petBreed => _petBreed;

  set petBreed(String value) {
    _petBreed = value;
    notifyListeners();
  }

  List<String> get breedList => _breedList;

  void setBreedList(List<String> list) {
    _breedList = list;
    // Set the default breed value
    if (list.isNotEmpty) {
      _petBreed = list[0];
    }
    notifyListeners();
  }

  List<String> _getBreedList(String petCategory) {
    switch (petCategory) {
      case "Dog":
        return dogBreedList;
      case "Cat":
        return catBreedList;
      case "Fish":
        return fishBreedList;
      default:
        return [];
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
        setUploadImageUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = "$e";
        setUploadImageUtil(StatusUtil.error);
      }
    }
  }

  sendSellingPet() async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
      petName: petName,
      petAge: petAge,
      petAgeTime: petAgeTime,
      petWeight: petWeight,
      gender: petGender,
      categories: petCategories,
      petBreed: petBreed,
      imageUrl: imageUrl,
      petPrice: petPrice,
      location: ownerLocation,
    );

    try {
      ApiResponse response = await petCareService.saveSellingPet(adopt, token);

      if (response.statusUtil == StatusUtil.success) {
        setSaveSellingPet(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setSaveSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setSaveSellingPet(StatusUtil.error);
    }
  }

  sendDonatePet() async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
     petName: petName,
      petAge: petAge,
      petAgeTime: petAgeTime,
      petWeight: petWeight,
      gender: petGender,
      categories: petCategories,
      petBreed: petBreed,
      imageUrl: imageUrl,
      location: ownerLocation,
    
    );

    try {
      ApiResponse response = await petCareService.saveDonatePet(adopt, token);

      if (response.statusUtil == StatusUtil.success) {
        setSaveDonatePet(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setSaveDonatePet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setSaveDonatePet(StatusUtil.error);
    }
  }

  getSellingPetData() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getSellingPet(token);
      if (response.statusUtil == StatusUtil.success) {
        sellingPetList = Adopt.listFromJson(response.data['data']);
        setGetSellingPet(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetSellingPet(StatusUtil.error);
    }
  }

  getDonatePetData() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getDonatePet(token);
      if (response.statusUtil == StatusUtil.success) {
        donatePetList = Adopt.listFromJson(response.data['data']);
        setGetSellingPet(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetSellingPet(StatusUtil.error);
    }
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
