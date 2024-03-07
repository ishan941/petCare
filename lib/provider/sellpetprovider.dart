import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class SellingPetProvider extends ChangeNotifier{
  PetCareService petCareService = PetCareImpl();
  String? errorMessage;
  String? id, petName,petAge,petAgeTime,petGender,imageUrl,petBreed,
  userImage,petWeight,description,ownerPhone,ownerName,ownerLocation,petPrice;


  StatusUtil _saveSellingPetUtil = StatusUtil.idle;
  StatusUtil get saveSellingPetutil => _saveSellingPetUtil;

  setSaveSellingPet(StatusUtil statusUtil){
    _saveSellingPetUtil = statusUtil;
    notifyListeners();
  }
  sendSellingPet() async {
    // await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
 
      petName: petName,
      petAge: petAge,
      petAgeTime: petAgeTime,
      gender: petGender,
      // imageUrl: imageUrl,
      // petBreed: petBreed,
      // petPrice: petPrice,
      // userImage: userImage ?? "",
      petWeight: petWeight,
      // description: description,
      // ownerPhone: ownerPhone,
      // ownerName: ownerName,
      // location: ownerLocation,
    );

    try {
      ApiResponse response =  await petCareService.saveSellingPet(adopt);
      
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
}