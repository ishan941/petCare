import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellingPetProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  PetCareProvider petCareProvider = PetCareProvider();
  List<Adopt> donatePetList = [];
  List<Adopt> approvalDonatePetList = [];
  List<Adopt> searchDonatePetList = [];
  List<Adopt> approvalSellingPetList = [];
  List<Adopt> searchSellingPetList = [];
  List<Adopt> adoptedPetList = [];
  List<Adopt> soldPetList = [];
  List<Adopt> myPetList = [];
  List<Adopt> sellingPetList = [];
  List<Adopt> categoryDogList = [];
  List<Adopt> categoryCatList = [];
  List<Adopt> categoryFishList = [];
  List<Adopt> filteredSearchList = [];
  String? errorMessage;
  XFile? image;
  String token = "";
  String key = "Dog";
  int? id;

  String userName = "";
  String userPhone = "";

  String? petName,
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController petAgeTimeController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController petPriceController = TextEditingController();
  TextEditingController ownerLocationController = TextEditingController();
  TextEditingController ownerPhoneController = TextEditingController();

  // TextEditingController userNController = TextEditingController();
  // TextEditingController petNameController = TextEditingController();

  StatusUtil _uploadImageUtil = StatusUtil.idle;
  StatusUtil _saveSellingPetUtil = StatusUtil.idle;
  StatusUtil _getSellingPetUtil = StatusUtil.idle;
  StatusUtil _approveDonatedPetUtil = StatusUtil.idle;
  StatusUtil _approveSellingPetUtil = StatusUtil.idle;
  StatusUtil _getApproveDonatedPetUtil = StatusUtil.idle;
  StatusUtil _getApproveSellingPetUtil = StatusUtil.idle;
  StatusUtil _makeSoldUtil = StatusUtil.idle;
  StatusUtil _makeAdoptedUtil = StatusUtil.idle;
  StatusUtil _getMyPetUtil = StatusUtil.idle;
  StatusUtil _searchSellingPetUtil = StatusUtil.idle;
  StatusUtil _searchDonatedPetUtil = StatusUtil.idle;

  StatusUtil _deleteDonatedPetUtil = StatusUtil.idle;
  StatusUtil _deleteSellingPetUtil = StatusUtil.idle;

  StatusUtil _saveDonatePetUtil = StatusUtil.idle;
  StatusUtil _getDonatePetUtil = StatusUtil.idle;

  StatusUtil get saveSellingPetutil => _saveSellingPetUtil;
  StatusUtil get getSellingPetUtil => _getSellingPetUtil;
  StatusUtil get uploadImageUtil => _uploadImageUtil;
  StatusUtil get deletedDonatedPetUtil => _deleteDonatedPetUtil;
  StatusUtil get deleteSellingPetUtil => _deleteSellingPetUtil;
  StatusUtil get approveDonatedPetUtil => _approveDonatedPetUtil;
  StatusUtil get approveSellingPetUtil => _approveSellingPetUtil;
  StatusUtil get getApproveDonatedPetUtil => _getApproveDonatedPetUtil;
  StatusUtil get getApproveSellingPetUtil => _getApproveSellingPetUtil;
  StatusUtil get getSearchSellingPetUtil => _searchSellingPetUtil;
  StatusUtil get getSearchDonatedPetUtil => _searchDonatedPetUtil;
  StatusUtil get makeSoldUtil => _makeSoldUtil;
  StatusUtil get makeAdoptedUtil => _makeAdoptedUtil;

  StatusUtil get saveDonatePetUtil => _saveDonatePetUtil;
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

  setMakeSoldUtil(StatusUtil statusUtil) {
    _makeSoldUtil = statusUtil;
    notifyListeners();
  }

  setMakeAdoptedUtil(StatusUtil statusUtil) {
    _makeAdoptedUtil = statusUtil;
    notifyListeners();
  }

  setSearchSellingPet(StatusUtil statusUtil) {
    _searchSellingPetUtil = statusUtil;
    notifyListeners();
  }

  setSearchDonatedPet(StatusUtil statusUtil) {
    _searchDonatedPetUtil = statusUtil;
    notifyListeners();
  }

  setGetMyPetUtil(StatusUtil statusUtil) {
    _getMyPetUtil = statusUtil;
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

  setDeletedDonatedPetUtil(StatusUtil statusUtil) {
    _deleteDonatedPetUtil = statusUtil;
    notifyListeners();
  }

  setApproveDonatedPet(StatusUtil statusUtil) {
    _approveDonatedPetUtil = statusUtil;
    notifyListeners();
  }

  setApproveSellingPet(StatusUtil statusUtil) {
    _approveSellingPetUtil = statusUtil;
    notifyListeners();
  }

  setGetApproveDonatedPet(StatusUtil statusUtil) {
    _getApproveDonatedPetUtil = statusUtil;
    notifyListeners();
  }

  setGetApproveSellingPet(StatusUtil statusUtil) {
    _getApproveSellingPetUtil = statusUtil;
    notifyListeners();
  }

  setDeleteSellingPetUtil(StatusUtil statusUtil) {
    _deleteSellingPetUtil = statusUtil;
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

  setId(int id) {
    this.id = id;
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

  bool isAccepted = false;

  setIsAccepted(bool value) {
    isAccepted = value;
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

  Future<void> getSearchSellingPet(String token) async {
    try {
      ApiResponse response = await petCareService.searchSellingPets(token);
      if (response.statusUtil == StatusUtil.success) {
        sellingPetList = Adopt.listFromJson(response.data['data']);
        setSearchSellingPet(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        setSearchSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setSearchSellingPet(StatusUtil.error);
    }
  }

  Future<void> getSearchDonatePet(String token) async {
    try {
      ApiResponse response = await petCareService.searchDonatedPets(token);
      if (response.statusUtil == StatusUtil.success) {
        donatePetList = Adopt.listFromJson(response.data['data']);
        setSearchDonatedPet(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        setSearchDonatedPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setSearchDonatedPet(StatusUtil.error);
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

  Future<void> sendSellingPet() async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
      id: id != null ? id : 0,
      petName: petNameController.text,
      petAge: petAgeController.text,
      petAgeTime: petAgeTime,
      petWeight: petWeightController.text,
      gender: petGender,
      categories: petCategories,
      ownerName: userName,
      ownerPhone: userPhone,
      petBreed: petBreed,
      imageUrl: imageUrl,
      description: descriptionController.text,
      petPrice: petPriceController.text,
      location: ownerLocationController.text,
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

  setPetGender(String gender) async {
    petGender = gender;
    notifyListeners();
  }

  setCategory(String categories) async {
    petCategories = categories;
    notifyListeners();
  }

  setAgeTime(String petAgeTime) async {
    petAgeTime = petAgeTime;
    notifyListeners();
  }

  setUserPhone(String userPhone) {
    this.userPhone = userPhone;
    notifyListeners();
  }

  setUserName(String userName) {
    this.userName = userName;
    notifyListeners();
  }

  clearData() async {
    petNameController.clear();
    petAgeController.clear();
    petAgeTime = null;
    petAgeTime = null;
    petWeightController.clear();
    descriptionController.clear();
    petGender = null;
    petCategories = null;
    imageUrl = null;
    image = null;
    petPriceController.clear();
    ownerLocationController.clear();
    notifyListeners();
  }

  Future<void> sendDonatePet() async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
      id: id != null ? id : 0,
      petName: petNameController.text,
      petAge: petAgeController.text,
      petAgeTime: petAgeTime,
      petWeight: petWeightController.text,
      description: descriptionController.text,
      gender: petGender,
      categories: petCategories,
      petBreed: petBreed,
      ownerName: userName,
      ownerPhone: userPhone,
      imageUrl: imageUrl,
      location: ownerLocationController.text,
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

  requestSold(int id) async {
    if (_makeSoldUtil != StatusUtil.loading) {
      setMakeSoldUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response = await petCareService.makeSold(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setMakeSoldUtil(StatusUtil.success);

        getSellingPetData();
        notifyListeners();
      } else {
        errorMessage = response.errorMessage;
        setMakeSoldUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setMakeSoldUtil(StatusUtil.error);
    }
  }

  requestAdopted(int id) async {
    if (_makeAdoptedUtil != StatusUtil.loading) {
      setMakeAdoptedUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response = await petCareService.makeAdopted(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setMakeAdoptedUtil(StatusUtil.success);
        getDonatePetData();
        notifyListeners();
      } else {
        errorMessage = response.errorMessage;
        setMakeAdoptedUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setMakeAdoptedUtil(StatusUtil.error);
    }
  }

  approveDonate(int id) async {
    if (_getApproveDonatedPetUtil != StatusUtil.loading) {
      setGetApproveDonatedPet(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.approvelDonated(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setGetApproveDonatedPet(StatusUtil.success);
        getApproveDonationPet();
      } else {
        errorMessage = response.errorMessage;
        setGetApproveDonatedPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetApproveDonatedPet(StatusUtil.error);
    }
  }

  approveSellingPet(int id) async {
    if (_approveSellingPetUtil != StatusUtil.loading) {
      setApproveSellingPet(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.approvelSelling(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setApproveSellingPet(StatusUtil.success);
        getApproveSellingPet();
      } else {
        errorMessage = response.errorMessage;
        setApproveSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setApproveSellingPet(StatusUtil.error);
    }
  }

  declineDonate(int id) async {
    if (_deleteDonatedPetUtil != StatusUtil.loading) {
      setDeletedDonatedPetUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.deleteDonatedPetById(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeletedDonatedPetUtil(StatusUtil.success);
        getApproveDonationPet();
      } else {
        errorMessage = response.errorMessage;
        setDeletedDonatedPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeletedDonatedPetUtil(StatusUtil.error);
    }
  }

  Future<void> declineSellingPet(int id) async {
    if (_deleteSellingPetUtil != StatusUtil.loading) {
      setDeleteSellingPetUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.deleteSellingPetById(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteSellingPetUtil(StatusUtil.success);
        getSellingPetData();
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeleteSellingPetUtil(StatusUtil.error);
    }
  }

  deleteDonatedPet(int id) async {
    if (_deleteDonatedPetUtil != StatusUtil.loading) {
      setDeletedDonatedPetUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.deleteDonatedPetById(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeletedDonatedPetUtil(StatusUtil.success);
        getDonatePetData();
        getMyPet();
      } else {
        errorMessage = response.errorMessage;
        setDeletedDonatedPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeletedDonatedPetUtil(StatusUtil.error);
    }
  }

  deleteSellingPet(int id) async {
    if (_deleteSellingPetUtil != StatusUtil.loading) {
      setDeleteSellingPetUtil(StatusUtil.loading);
    }
    Adopt adopt = Adopt(id: id);
    try {
      ApiResponse response =
          await petCareService.deleteSellingPetById(adopt, id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteSellingPetUtil(StatusUtil.success);
        getDonatePetData();
        getMyPet();
      } else {
        errorMessage = response.errorMessage;
        setDeleteSellingPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeleteSellingPetUtil(StatusUtil.error);
    }
  }

  Future<void> getSellingPetData() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getSellingPet(token);
      if (response.statusUtil == StatusUtil.success) {
        sellingPetList = Adopt.listFromJson(response.data['data']);
        getSellingPetData();
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

  Future<void> getDonatePetData() async {
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

  Future<void> getCategoryDog() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getDogCategory(token);
      if (response.statusUtil == StatusUtil.success) {
        categoryDogList = Adopt.listFromJson(response.data['data']);
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

  Future<void> getCategoryCat() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getCatCategory(token);
      if (response.statusUtil == StatusUtil.success) {
        categoryCatList = Adopt.listFromJson(response.data['data']);
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

  Future<void> getCategoryFish() async {
    if (_getSellingPetUtil != StatusUtil.loading) {
      setGetSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getFishCategory(token);
      if (response.statusUtil == StatusUtil.success) {
        categoryFishList = Adopt.listFromJson(response.data['data']);
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

  Future<void> getApproveDonationPet() async {
    if (_getApproveDonatedPetUtil != StatusUtil.loading) {
      setGetApproveDonatedPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getApprovedDonatedPet(token);
      if (response.statusUtil == StatusUtil.success) {
        approvalDonatePetList = Adopt.listFromJson(response.data['data']);
        setGetApproveDonatedPet(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetApproveDonatedPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetApproveDonatedPet(StatusUtil.error);
    }
  }

  Future<void> getApproveSellingPet() async {
    if (_getApproveSellingPetUtil != StatusUtil.loading) {
      setGetApproveSellingPet(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getApprovedSellingPet(token);
      if (response.statusUtil == StatusUtil.success) {
        approvalSellingPetList = Adopt.listFromJson(response.data['data']);
        setGetApproveSellingPet(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetApproveSellingPet(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetApproveSellingPet(StatusUtil.error);
    }
  }

  Future<void> getMyPet() async {
    if (_getMyPetUtil != StatusUtil.loading) {
      setGetMyPetUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getUserAddedPet(token);
      if (response.statusUtil == StatusUtil.success) {
        myPetList = Adopt.listFromJson(response.data['data']);
        setGetMyPetUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetMyPetUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetMyPetUtil(StatusUtil.error);
    }
  }

  // Future<void> deletedDonatedPet(int id) async {
  //   if (_deleteDonatedPetUtil != StatusUtil.loading) {
  //     setDeletedDonatedPetUtil(StatusUtil.loading);
  //   }
  //   try {
  //     ApiResponse response =
  //         await petCareService.deleteDonatedPetById(id, token);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setDeletedDonatedPetUtil(StatusUtil.success);
  //       getDonatePetData();
  //     }
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     setDeletedDonatedPetUtil(StatusUtil.error);
  //   }
  // }
  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }
}
