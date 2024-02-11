import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class MyPetProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? petName;
  String? dateOfBirth;
  String? petType;
  String? petBreed;
  String? petSex;
  String? petColor;
  String? description;

  String? errorMessage;
  String? myPetData;
  List<MyPet> myPetList = [];

  StatusUtil _myPetUtil = StatusUtil.idle;
  StatusUtil _getMyPetUtil = StatusUtil.idle;

  StatusUtil get myPetUtil => _myPetUtil;
  StatusUtil get getMyPetUtil => _getMyPetUtil;

  setMyPetUtil(StatusUtil statusUtil) {
    _myPetUtil = statusUtil;
    notifyListeners();
  }

  setGetMyPetUtil(StatusUtil statusUtil) {
    _getMyPetUtil = statusUtil;
    notifyListeners();
  }

  Future<void> saveMyPetDetailsToFireBase() async {
    if (_myPetUtil != StatusUtil.loading) {
      setMyPetUtil(StatusUtil.loading);
    }
    MyPet myPet = MyPet(
        petName: petName,
        dateOfBirth: dateOfBirth,
        petType: petType,
        petBreed: petBreed,
        petColor: petColor,
        petSex: petSex,
        description: description);
    FireResponse response = await petCareService.myPetDetails(myPet);
    if (response.statusUtil == StatusUtil.success) {
      setMyPetUtil(StatusUtil.success);
    } else {
      setMyPetUtil(StatusUtil.error);
    }
  }

  Future<void> getMyPetDetailsFromFireBase() async {
    if (_getMyPetUtil != StatusUtil.loading) {
      setGetMyPetUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getMyPetDetails();
      if (response.statusUtil == StatusUtil.success) {
        myPetList = response.data;
        setGetMyPetUtil(StatusUtil.success);
      } else {
        setGetMyPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetMyPetUtil(StatusUtil.error);
    }
  }
}
