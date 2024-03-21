import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OurServiceProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  SignUpProvider signUpProvider = SignUpProvider();
  PetCareProvider petCareProvider = PetCareProvider();
  String token = "";
  int? id;

  String? errorMessage;
  String? service;
  String? medical, shop, trainer;
  String? shopLocation, shopName;
  String? loaction;
  String? cpimageUrl, ppimageUrl, profilePictureUrl;
  String? profession, phone, email, description;
  String? chosenProfession;
  XFile? cpimage, ppimage, profilePicture;
  String? picture;
  String? userName;

  List<OurService> dashServiceList = [];
  List<OurService> dashApiServiceList = [];
  List<OurService> professionDataList = [];
  List<OurServiceDto> ourServiceDtoList = [];

  List<OurService> _filteredProfessionData = [];
  List<OurService> get filteredProfessionData => _filteredProfessionData;

  // List<OurService> filterByProfession(String chosenProfession) {
  //   return professionDataList
  //       .where((data) => data.profession == chosenProfession)
  //       .toList();
  // }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController serviceController = TextEditingController();

  Future<void> getTokenFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }

  StatusUtil _dashServiceUtil = StatusUtil.idle;
  StatusUtil _ourServiceDtoUtil = StatusUtil.idle;
  StatusUtil _getDashServiceUtil = StatusUtil.idle;
  StatusUtil _profilePictureUtil = StatusUtil.idle;
  StatusUtil _professionUtil = StatusUtil.idle;
  StatusUtil _getProfessionUtil = StatusUtil.idle;
  StatusUtil _verificationUtil = StatusUtil.idle;
  StatusUtil _getOurServiceDtoUtil = StatusUtil.idle;
  StatusUtil _deleteOurServiceUtil = StatusUtil.idle;

  StatusUtil get dashServiceUtil => _dashServiceUtil;
  StatusUtil get ourServiceDtoUtil => _ourServiceDtoUtil;
  StatusUtil get getDashServiceUtil => _getDashServiceUtil;
  StatusUtil get profilePictureUtil => _profilePictureUtil;
  StatusUtil get professionUtil => _professionUtil;
  StatusUtil get getProfessionUtil => _getProfessionUtil;
  StatusUtil get verificationUtil => _verificationUtil;
  StatusUtil get getOurServiceUtil => _getOurServiceDtoUtil;
  StatusUtil get deleteOurServiceUtil => _deleteOurServiceUtil;

  setFilteredProfessionData(List<OurService> filteredData) {
    _filteredProfessionData = filteredData;
    notifyListeners();
  }

  setPicture(value) {
    picture = value;
    notifyListeners();
  }

  setChosenProfession(String profession) {
    chosenProfession = profession;
    notifyListeners();
  }

  setDashServiceUtil(StatusUtil statusUtil) {
    _dashServiceUtil = statusUtil;
    notifyListeners();
  }

  setOurServiceDto(StatusUtil statusUtil) {
    _ourServiceDtoUtil = statusUtil;
    notifyListeners();
  }

  setProfilePictureUtil(StatusUtil statusUtil) {
    _profilePictureUtil = statusUtil;
    notifyListeners();
  }

  setProfessionUtil(StatusUtil statusUtil) {
    _professionUtil = statusUtil;
    notifyListeners();
  }

  setGetProfessionUtil(StatusUtil statusUtil) {
    _getProfessionUtil = statusUtil;
    notifyListeners();
  }

  setGetOurServiceDtoUtil(StatusUtil statusUtil) {
    _getOurServiceDtoUtil = statusUtil;
    notifyListeners();
  }

  setDeleteOurService(StatusUtil statusUtil) {
    _deleteOurServiceUtil = statusUtil;
    notifyListeners();
  }

  setGetDashServiceUtil(StatusUtil statusUtil) {
    _getDashServiceUtil = statusUtil;
    notifyListeners();
  }
  //   Future<void> getProfilePicture() async {
  //   if (_verificationUtil != StatusUtil.loading) {
  //     setUserImageUtil(StatusUtil.loading);
  //   }
  //   try {
  //     var response = await petCareService.getUserByEmail();
  //     if (response.statusUtil == StatusUtil.success) {
  //       signUp = response.data;
  //       if (signUp?.userImage != null) {
  //         profilePicture = signUp!.userImage ?? "";
  //       }

  //       setUserImageUtil(StatusUtil.success);
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       print("Error fetching shop items: $errorMessage");
  //       setUserImageUtil(StatusUtil.error);
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     print("Exception while fetching shop items: $errorMessage");
  //     setUserImageUtil(StatusUtil.error);
  //   }
  // }
  // Future<void> saveDashServiceDetails(OurService ourService) async {
  //   if (_dashServiceUtil != StatusUtil.loading) {
  //     setDashServiceUtil(StatusUtil.loading);
  //   }
  //   try {
  //     ApiResponse response =
  //         await petCareService.saveDashOurService(ourService, token);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setDashServiceUtil(StatusUtil.success);
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       setDashServiceUtil(StatusUtil.error);
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     setDashServiceUtil(StatusUtil.error);
  //   }
  // }
  saveDashOurService() async {
    await uploadImageInFireBaseForDashService();
    await uploadImageInFirebaseForPpImage();
    OurService ourService = OurService(
      cpImage: cpimageUrl,
      ppImage: ppimageUrl,
      service: serviceController.text,
    );
    try {
      ApiResponse response =
          await petCareService.saveDashOurService(ourService, token);
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

  Future<void> saveOurServiceDto() async {
    if (_professionUtil != StatusUtil.loading) {
      setOurServiceDto(StatusUtil.loading);
    }

    try {
      await uploadProfilePictureInFireBase();
      OurServiceDto ourServiceDto = OurServiceDto(
        // profession: profession,
        fullName: userName,
        email: email,
        phone: phone,
        location: loaction,
        image: profilePictureUrl,
        description: description,
      );

      ApiResponse response =
          await petCareService.saveOurServiceDto(ourServiceDto, token);
      if (response.statusUtil == StatusUtil.success) {
        setOurServiceDto(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setOurServiceDto(
          StatusUtil.error,
        );
      }
    } catch (e) {
      errorMessage = "$e";
      setOurServiceDto(StatusUtil.error);
    }
  }

  Future<void> getDashService() async {
    if (_dashServiceUtil != StatusUtil.loading) {
      setGetDashServiceUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getDashService(token);
      if (response.statusUtil == StatusUtil.success) {
        dashApiServiceList = OurService.listFromJson(response.data['data']);
        setGetDashServiceUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setGetDashServiceUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetDashServiceUtil(StatusUtil.error);
    }
  }

  Future<void> getOurServiceDto() async {
    if (_ourServiceDtoUtil != StatusUtil.loading) {
      setGetOurServiceDtoUtil(StatusUtil.loading);
    }
    try {
      ApiResponse response = await petCareService.getOurServiceDto(token);
      if (response.statusUtil == StatusUtil.success) {
        ourServiceDtoList = OurServiceDto.listFromJson(response.data['data']);
        setGetOurServiceDtoUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setGetOurServiceDtoUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setGetOurServiceDtoUtil(StatusUtil.error);
    }
  }

  Future<void> deletOurService(int id) async {
    if (_deleteOurServiceUtil == StatusUtil.loading) {
      setDeleteOurService(StatusUtil.loading);
    }
    try {
      ApiResponse response =
          await petCareService.deleteOurServiceById(id, token);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteOurService(StatusUtil.success);
        getDashService();
      } else
        setDeleteOurService(StatusUtil.error);
    } catch (e) {
      errorMessage = e.toString();
      setDeleteOurService(StatusUtil.error);
    }
  }

  // reset() {
  //   OurService ourService = OurService();
  //   ourService.profilePicture == "";
  //   notifyListeners();
  // }

  // Future<void> saveProfessionData() async {
  //   if (_professionUtil != StatusUtil.loading) {
  //     setProfessionUtil(StatusUtil.loading);
  //   }

  //   try {
  //     await uploadProfilePictureInFireBase();
  //     OurServiceDto ourServiceDto = OurServiceDto(
  //       profession: profession,
  //       fullName: signUpProvider.fullName,
  //       email: signUpProvider.userEmail,
  //       phone: signUpProvider.userPhone,
  //       medical: medical,
  //       shop: shop,
  //       location: loaction,
  //       shopLocation: shopLocation,
  //       shopName: shopName,
  //       trainer: trainer,
  //       profilePicture: picture ?? profilePictureUrl,
  //       description: description,
  //     );

  //     FireResponse response =
  //         await petCareService.saveProfessionData(ourServiceDto);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setProfessionUtil(StatusUtil.success);
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       setProfessionUtil(
  //         StatusUtil.error,
  //       );
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     setProfessionUtil(StatusUtil.error);
  //   }
  // }

  Future<void> getProfessionData() async {
    if (_getProfessionUtil != StatusUtil.loading) {
      setGetProfessionUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.getProfessionDetails();
      if (response.statusUtil == StatusUtil.success) {
        professionDataList = response.data;
        setGetProfessionUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setGetProfessionUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setGetProfessionUtil(StatusUtil.error);
    }
  }

  //firebase
  // Future<void> saveDashServiceDetails(DashService dashService) async {
  //   if (_dashServiceUtil != StatusUtil.loading) {
  //     setDashServiceUtil(StatusUtil.loading);
  //   }
  //   try {
  //     FireResponse response =
  //         await petCareService.saveDashServiceDetails(dashService);
  //     if (response.statusUtil == StatusUtil.success) {
  //       setDashServiceUtil(StatusUtil.success);
  //     } else if (response.statusUtil == StatusUtil.error) {
  //       errorMessage = response.errorMessage;
  //       setDashServiceUtil(StatusUtil.error);
  //     }
  //   } catch (e) {
  //     errorMessage = "$e";
  //     setDashServiceUtil(StatusUtil.error);
  //   }
  // }

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
      // List<String> extension = cpimage!.name.split(".");
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
      // List<String> extension = ppimage!.name.split(".");
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
      // List<String> extension = profilePicture!.name.split(".");
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
}
