import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage;
  int? id;
  String? categoryImage, categoryName;
  String? category;

  XFile? image;
  String token = "";
  String? imageUrl;

  List<Categories> categoriesList = [];

  StatusUtil _categoriesUtil = StatusUtil.idle;
  StatusUtil _getCategoriesUtil = StatusUtil.idle;
  StatusUtil _deleteCategoriesUtil = StatusUtil.idle;
  StatusUtil _editCategoriesUtil = StatusUtil.idle;

  StatusUtil get categoriesUtil => _categoriesUtil;
  StatusUtil get getCategoriesUtil => _getCategoriesUtil;
  StatusUtil get deleteCategoriesUtil => _deleteCategoriesUtil;
  StatusUtil get editCategoriesUtil => _editCategoriesUtil;

  setCategoriesUtil(StatusUtil statusUtil) {
    _categoriesUtil = statusUtil;
    notifyListeners();
  }

  setDeleteCategoryUtil(StatusUtil statusUtil) {
    _deleteCategoriesUtil = statusUtil;
    notifyListeners();
  }

  setEditCategoryUtil(StatusUtil statusUtil) {
    _editCategoriesUtil = statusUtil;
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

  setCategory(String? categoryName) {
    this.categoryName = categoryName;
    notifyListeners();
  }

  setImageUrl(String? imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  setItd(int? id) {
    this.id = id;
    notifyListeners();
  }

  void clearImage() {
    image = null;
    imageUrl = null;
    notifyListeners();
  }

  void clearField() {
    categoriesNameController.clear();
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController categoriesNameController = TextEditingController();

  Future<void> saveCategory() async {
    if (_categoriesUtil != StatusUtil.loading) {
      setCategoriesUtil(StatusUtil.loading);
    }
    await uploadImageInFireBase();

    Categories categories = Categories(
        categoriesImage: imageUrl,
        categoriesName: categoriesNameController.text,
        id: id != null ? id : 0);
    try {
      ApiResponse response =
          await petCareService.categoriesDetails(categories, token);
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
      ApiResponse response = await petCareService.getCategoriesDetails(token);
      if (response.statusUtil == StatusUtil.success) {
        categoriesList = Categories.listFromJson(response.data['data']);
        setGetCategoriesUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetCategoriesUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetCategoriesUtil(StatusUtil.error);
    }
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
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

  // Future<void> getCategoriesById(int id) async {
  //   if (_editCategoriesUtil != StatusUtil.loading) {
  //     setEditCategoryUtil(StatusUtil.loading);
  //   }

  //   Categories categories = Categories(
  //       categoriesImage: imageUrl,
  //       categoriesName: categoriesNameController.text,
  //       id: id != null ? id : 0);
  //   try {
  //     ApiResponse response = await petCareService.getCategoriesById(categories, id, token);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setEditCategoryUtil(StatusUtil.success);
  //     }
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     setEditCategoryUtil(StatusUtil.error);
  //   }
  // }

  Future<void> deleteCategory(int id) async {
    if (_deleteCategoriesUtil != StatusUtil.loading) {
      setDeleteCategoryUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.deleteCategoryById(id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteCategoryUtil(StatusUtil.success);
        getCategoriesData();
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeleteCategoryUtil(StatusUtil.error);
    }
  }
}
