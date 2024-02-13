import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class MyPetProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  SignUp? signUp = SignUp();

  String? id;
  String? petName;
  String? dateOfBirth;
  String? petType;
  String? petBreed;
  String? petSex;
  String? petColor;
  String? description;
  MyPet? myPet;
  String? errorMessage;
  String? myPetData;
  List<MyPet> myPetList = [];
  List<MyPet> myPetDataList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  StatusUtil _myPetUtil = StatusUtil.idle;
  StatusUtil _getMyPetUtil = StatusUtil.idle;
  StatusUtil _updateMyPetUtil = StatusUtil.idle;

  StatusUtil get myPetUtil => _myPetUtil;
  StatusUtil get getMyPetUtil => _getMyPetUtil;
  StatusUtil get updateMyPetUtil => updateMyPetUtil;

  setBreed(String value) {
    petBreed = value;
  }

  setMyPetUtil(StatusUtil statusUtil) {
    _myPetUtil = statusUtil;
    notifyListeners();
  }

  setGetMyPetUtil(StatusUtil statusUtil) {
    _getMyPetUtil = statusUtil;
    notifyListeners();
  }

  setUpdateMyPetUtil(StatusUtil statusUtil) {
    _updateMyPetUtil = statusUtil;
    notifyListeners();
  }

  Future<void> saveMyPetDetailsToFireBase() async {
    if (_myPetUtil != StatusUtil.loading) {
      setMyPetUtil(StatusUtil.loading);
    }
    MyPet myPet = MyPet(
        id: id,
        petName: nameController.text,
        dateOfBirth: dobController.text,
        petType: typeController.text,
        petBreed: petBreed,
        petColor: colorController.text,
        petSex: petSex,
        description: descriptionController.text);
    FireResponse response = await petCareService.myPetDetails(myPet);
    if (response.statusUtil == StatusUtil.success) {
      setMyPetUtil(StatusUtil.success);
    } else {
      setMyPetUtil(StatusUtil.error);
    }
  }

  Future<void> getMyPetDetailsFromFireBase() async {
    String? myPetTojson;
    if (_getMyPetUtil != StatusUtil.loading) {
      setGetMyPetUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getMyPetDetails();
      if (response.statusUtil == StatusUtil.success) {
        myPetList = response.data;
        if (myPetList.isNotEmpty) {
          myPetTojson = jsonEncode(myPetList.map((e) => e.toJson()).toList());
          signUp?.myPetData = myPetTojson;
        }

       
        var userEmail = await petCareService.getUserByEmail();
        if (userEmail.statusUtil == StatusUtil.success) {
          if (signUp?.myPetData != null) {
            List<dynamic> decodedList = jsonDecode(signUp!.myPetData ?? "");
            myPetDataList = decodedList.map((e) => MyPet.fromJson(e)).toList();
          }
        
      }


        setGetMyPetUtil(StatusUtil.success);
      } else {
        setGetMyPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetMyPetUtil(StatusUtil.error);
    }
  }

  updateMyPetDetailsInFireBase(MyPet myPet) async {
    FireResponse response;
    try {
      if (myPet.id != null) {
        response = await petCareService.updateMyPetDetails(myPet);
      } else {
        response = await petCareService.myPetDetails(myPet);
      }
      if (response.statusUtil == StatusUtil.success) {
        setMyPetUtil(StatusUtil.success);
      } else {
        setMyPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setMyPetUtil(StatusUtil.error);
    }
  }

  // Future<void> updatePetTofireBase(MyPet myPet) async {
  //   FireResponse response;
  //   String? myPetTojson;

  //   myPetList.add(myPet);
  //   myPetTojson = jsonEncode(myPetList.map((e) => e.toJson()).toList());

  //   signUp?.myPetData = myPetTojson;
  //   response = await petCareService.updateCart(signUp!);
  //   if (response.statusUtil == StatusUtil.success) {
  //     await getMyPetDetailsFromFireBase();
  //   }
  // }
}
