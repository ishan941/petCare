import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class CategoriesProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage;
  String? categoryImage, categoryName;

  XFile? image;
  String? imageUrl;

  List<Categories> categoriesList = [];

  StatusUtil _categoriesUtil = StatusUtil.idle;
  StatusUtil _getCategoriesUtil = StatusUtil.idle;

  StatusUtil get categoriesUtil => _categoriesUtil;
  StatusUtil get getCategoriesUtil => _getCategoriesUtil;

  setCategoriesUtil(StatusUtil statusUtil) {
    _categoriesUtil = statusUtil;
    notifyListeners();
  }

  setGetCategoriesUtil(StatusUtil statusUtil) {
    _getCategoriesUtil = statusUtil;
    notifyListeners();
  }

  setImage(XFile? image) {
    this.image = image;
    notifyListeners();
  }

  setImageUrl(String? imageUrl) {
    this.imageUrl = imageUrl;
  }

  Future<void> saveCategoriesDataToFireBase() async {
    if (_categoriesUtil != StatusUtil.loading) {
      setCategoriesUtil(StatusUtil.loading);
    }
    await uploadImageInFireBase();
    Categories categories =
        Categories(categoriesImage: imageUrl, categoriesName: categoryName);
    try {
      FireResponse response =
          await petCareService.categoriesDetails(categories);
      if (response.statusUtil == StatusUtil.success) {
        setCategoriesUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setCategoriesUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setCategoriesUtil(StatusUtil.error);
    }
  }

  Future<void> getCategoriesData() async {
    if (_getCategoriesUtil != StatusUtil.loading) {
      setGetCategoriesUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getCategoriesDetails();
      if (response.statusUtil == StatusUtil.success) {
        categoriesList = response.data;
        setGetCategoriesUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setCategoriesUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetCategoriesUtil(StatusUtil.error);
    }
  }

  Future<void> uploadImageInFireBase() async {
    if (_categoriesUtil != StatusUtil.loading) {
      setCategoriesUtil(StatusUtil.loading);
    }
    if (image != null) {
      final storageRef = FirebaseStorage.instance.ref();
      var mountainRef = storageRef.child("${image!.name}");
      try {
        await mountainRef.putFile(File(image!.path));
        final downloadUrl = await mountainRef.getDownloadURL();
        imageUrl = downloadUrl;
        setCategoriesUtil(StatusUtil.success);
      } catch (e) {
        errorMessage = e.toString();
        setCategoriesUtil(StatusUtil.error);
      }
    }
  }
}
