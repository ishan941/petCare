import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/scanner.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  XFile? image, photo;
  String? imageUrl, photoUrl;
  String? errorMessage;
  // List<DiseaseModel> disease = [ ];

  String token = "";

  List<String> _selectedSymptoms = [];
  StatusUtil _scannerUtil = StatusUtil.idle;
  StatusUtil _symptomesUtil = StatusUtil.idle;
  StatusUtil _diseasesUtil = StatusUtil.idle;

  List<String> get selectedSymptoms => _selectedSymptoms;
  StatusUtil get scannerUtil => _scannerUtil;
  StatusUtil get symptomesUtil => _symptomesUtil;
  StatusUtil get diseasesUtil => _diseasesUtil;

  set selectedSymptoms(List<String> symptoms) {
    _selectedSymptoms = symptoms;
    notifyListeners();
  }

  setScannerUtil(StatusUtil statusUtil) {
    _scannerUtil = statusUtil;
    notifyListeners();
  }

  setSymptomesUtil(StatusUtil statusUtil) {
    _symptomesUtil = statusUtil;
    notifyListeners();
  }

  setDiseasesUtil(StatusUtil statusUtil) {
    _diseasesUtil = statusUtil;
    notifyListeners();
  }

  setImage(XFile image) {
    this.image = image;
    notifyListeners();
  }

  setPhoto(XFile photo) {
    this.photo = photo;
    notifyListeners();
  }

  setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  setPhotoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
    notifyListeners();
  }

  void clearImage() {
    this.image = null;
    this.photo = null;
    notifyListeners();
  }

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }

  clearSelectedSymptoms() {
    _selectedSymptoms.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // sendSymptomesToApi() async {
  //   try {
  //     Scanner scanner = Scanner(symptoms: selectedSymptoms);
  //     ApiResponse response = await petCareService.saveSymptomes(scanner, token);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setSymptomesUtil(StatusUtil.success);
  //       return response.data; // Assuming response.data contains the list
  //     } else {
  //       setSymptomesUtil(StatusUtil.error);
  //       return []; // Return an empty list in case of error
  //     }
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     setSymptomesUtil(StatusUtil.error);
  //     return []; // Return an empty list in case of exception
  //   }
  // }
  List<dynamic> disease = [];

  sendSymptomesToApi() async {
    try {
      Scanner scanner = Scanner(symptoms: selectedSymptoms);
      ApiResponse response = await petCareService.saveSymptomes(scanner, token);
      if (response.statusUtil == StatusUtil.success) {
        disease = response.data['data'];

        setSymptomesUtil(StatusUtil.success);

        return {'success': true, 'data': response.data};
      } else {
        setSymptomesUtil(StatusUtil.error);
        return {'success': false, 'error': 'Failed to save symptoms.'};
      }
    } catch (e) {
      errorMessage = e.toString();
      setSymptomesUtil(StatusUtil.error);
      return {'success': false, 'error': errorMessage};
    }
  }

  Future<void> uploadeImageInFireBase() async {
    if (_scannerUtil == StatusUtil.loading) {
      setScannerUtil(StatusUtil.loading);
    }
    try {
      final scannerImageStorageRef = FirebaseStorage.instance.ref();
      var imageStorageRef = scannerImageStorageRef.child("${image!.name}");
      await imageStorageRef.putFile(File(image!.path));
      final downloadeUrl = await imageStorageRef.getDownloadURL();
      imageUrl = downloadeUrl;
    } catch (e) {
      errorMessage = "$e";
      setScannerUtil(StatusUtil.error);
    }
  }

  Future<void> uploadePhotoInFireBase() async {
    if (_scannerUtil == StatusUtil.loading) {
      setScannerUtil(StatusUtil.loading);
    }
    try {
      final scannerPhotoStorageRef = FirebaseStorage.instance.ref();
      var photoStorageRef = scannerPhotoStorageRef.child("${image!.name}");
      await photoStorageRef.putFile(File(image!.path));
      final downloadeUrl = await photoStorageRef.getDownloadURL();
      photoUrl = downloadeUrl;
    } catch (e) {
      errorMessage = "$e";
      setScannerUtil(StatusUtil.error);
    }
  }
}
