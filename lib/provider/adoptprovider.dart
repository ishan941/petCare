import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class AdoptProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();
  PetCareProvider petCareProvider = PetCareProvider();
  SignUpProvider signUpProvider = SignUpProvider();


  String? errorMessage, imageUrl;
  XFile? image;
  Dio dio = Dio();

  String? id, petGender, petBreed, petAgeTime,petName,petAge,petWeight,ownerName,ownerPhone,ownerLocation,description;
  String? userImage;
  

 

  double _per = 0.0;
  double get per => _per;
  void updatePercent(double value) {
    _per = value;
    notifyListeners();
  }

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // TextEditingController petnameController = TextEditingController();
  // TextEditingController petAgeController = TextEditingController();
  // TextEditingController petweightController = TextEditingController();
  // // TextEditingController petBreadController = TextEditingController();
  // // TextEditingController petAgeTimeController = TextEditingController();
  // TextEditingController ownerNameController = TextEditingController();
  // TextEditingController ownerPhoneController = TextEditingController();
  // TextEditingController ownerLocationController = TextEditingController();
  // TextEditingController imageUrlConroller = TextEditingController();

  List<Adopt> adoptDetailsList = [];

  

  StatusUtil _adoptUtil = StatusUtil.idle;
  StatusUtil _uploadImageUtil = StatusUtil.idle;
  StatusUtil _getAdoptDetails = StatusUtil.idle;
  StatusUtil _deleteAdoptDetails = StatusUtil.idle;

  StatusUtil get adoptUtil => _adoptUtil;
  StatusUtil get uploadImageUtil => _uploadImageUtil;
  StatusUtil get getAdoptDetails => _getAdoptDetails;
  StatusUtil get deleteAdoptDetails => _deleteAdoptDetails;

  setUserImage(value){
    userImage = value;
    notifyListeners();
  }

  setPetGender(String value) {
    petGender = value;
  }

  setPetBread(String value) {
    petBreed = value;
  }

  setPetAgeTime(String value) {
    petAgeTime = value;
  }

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

  setId(String id) {
    this.id = id;
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
      ApiResponse response = await petCareService.adoptDetails(adopt);
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

  checkAdoptRegistationStatus(Adopt adopt) async {
    late ApiResponse response;
    try {
      if (adopt.id != null) {
        response = await petCareService.updateAdoptDetails(adopt);
      } else {
        response = await petCareService.adoptDetails(adopt);
      }
      if (response.statusUtil == StatusUtil.success) {
        setAdoptUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setAdoptUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setAdoptUtil(StatusUtil.error);
    }
  }

  sendAdoptValueToFireBase(BuildContext context) async {
    await uploadAdoptImageInFireBase();
    Adopt adopt = Adopt(
      id: id,
      petName: petName,
      petAge: petAge,
      petAgeTime: petAgeTime,
      gender: petGender,
      imageUrl: imageUrl,
      petBreed: petBreed,
      userImage: userImage ?? "",
      petWeight: petWeight,
      description: description,
      ownerPhone: ownerPhone,
      ownerName: ownerName,
      location: ownerLocation,
    );

    try {
     late ApiResponse response;
      if (adopt.id != null) {
        response = await petCareService.updateAdoptDetails(adopt);
      } else {
        response = await petCareService.adoptDetails(adopt);
      }
      if (response.statusUtil == StatusUtil.success) {
        setAdoptUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setAdoptUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setAdoptUtil(StatusUtil.error);
    }
  }



Future<void> getAdoptdata() async {
  if (_getAdoptDetails != StatusUtil.loading) {
    setGetAdoptDetails(StatusUtil.loading);
  }

  try {
    Response response = await dio.get("https://78ce-103-90-147-204.ngrok-free.app/getDonationPet");
    
    if (response.statusCode == 200) {
      dynamic responseData = response.data;

      if (responseData is List) {
        List<Adopt> adoptDetails = responseData
            .map((json) => Adopt.fromJson(json))
            .toList();

        adoptDetailsList = adoptDetails;
        setGetAdoptDetails(StatusUtil.success);
      } else {
        // Handle the case when the response data is a map
        // You may need to extract the list from the map based on your API's response structure.
        // For example: adoptDetailsList = responseData['your_key_for_list'];
        setGetAdoptDetails(StatusUtil.error);
      }
    } else {
      setGetAdoptDetails(StatusUtil.error);
    }
  } on DioError catch (e) {
    if (e.error is SocketException) {
      errorMessage = "No internet connection.";
    } else if (e.response != null) {
      errorMessage = "Unexpected server response: ${e.response!.statusCode} ${e.response!.statusMessage}";
    } else {
      errorMessage = "Unexpected error: ${e.toString()}";
    }
    setGetAdoptDetails(StatusUtil.error);
  }

  // Handle any additional logic or UI updates as needed.
}


  void handleDoubleTap(int index){
    if(index >= 0 && index < adoptDetailsList.length){
      Adopt adopt = adoptDetailsList[index];
      adopt.isDoubleTapped = !adopt.isDoubleTapped;
      notifyListeners();
    }
  }
}
