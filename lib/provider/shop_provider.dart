import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class ShopProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage, imageUrl;
  String? product,
      condition,
      location,
      price,
      description,
      images,
      negotiable,
      id;
  XFile? image;
bool isFromFav=false;
  SignUp? signUp;
  List<Shop> favouriteList=[];

  List<Shop> shopItemsList = [];
  
  // List<Shop> shopFavouriteList = [];

  // Set<int> _favouriteIndices = {};

  // Set<int> get favouriteIndices => _favouriteIndices;
  

  // bool isFavourite(int index) {
  //   return favouriteIndices.contains(index);
  // }

  

  double _per = 0.0;
  double get per => _per;
  void updatePercent(double value) {
    _per = value;
    notifyListeners();
  }



 

  StatusUtil _shopItems = StatusUtil.idle;
  StatusUtil _uploadImageForShop = StatusUtil.idle;
  StatusUtil _getshopItemsUtil = StatusUtil.idle;
  StatusUtil _shopFavouriteUtil = StatusUtil.idle;
  StatusUtil _deleteFavouriteUtil = StatusUtil.idle;
  StatusUtil _getUserStatus = StatusUtil.idle;


  StatusUtil get shopIetms => _shopItems;
  StatusUtil get uploadImageInFireBase => _uploadImageForShop;
  StatusUtil get getshopIemsUtil => _getshopItemsUtil;
  StatusUtil get shopFavouriteUtil => _shopFavouriteUtil;
  StatusUtil get deleteFavouriteUtil => _deleteFavouriteUtil;
  StatusUtil get getUserStatus => _getUserStatus;

  setShopItemsUtil(StatusUtil statusUtil) {
    _shopItems = statusUtil;
    notifyListeners();
  }
   setUserStatus(StatusUtil statusUtil) {
    _getUserStatus = statusUtil;
    notifyListeners();
  }

  setUploadImageInFireBaseUtil(StatusUtil statusUtil) {
    _uploadImageForShop = statusUtil;
    notifyListeners();
  }

  setgetShopItemsUtil(StatusUtil statusUtil) {
    _getshopItemsUtil = statusUtil;
    notifyListeners();
  }

  setShopFavouriteUtil(StatusUtil statusUtil) {
    _shopFavouriteUtil = statusUtil;
    notifyListeners();
  }

  setDeleteFavourite(StatusUtil statusUtil) {
    _deleteFavouriteUtil = statusUtil;
    notifyListeners();
  }

  setFavourite(bool value){
isFromFav=value;
notifyListeners();
  }
  

  setId(String id) {
    this.id = id;
  }

 

  Future<void> getUser()async{
     if (_getUserStatus != StatusUtil.loading) {
      setUserStatus(StatusUtil.loading);
    }
    try {
      var response = await petCareService.getUserByEmail();
      if (response.statusUtil == StatusUtil.success) {
        signUp = response.data;
        if(signUp?.favourite!=null){
          List<dynamic> decodedList =jsonDecode(signUp!.favourite ?? "");
          favouriteList=decodedList.map((e) =>Shop.fromJson(e)).toList();
        }
        setUserStatus(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        print("Error fetching shop items: $errorMessage");
        setUserStatus(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      print("Exception while fetching shop items: $errorMessage");
      setUserStatus(StatusUtil.error);
    }

  }

 

bool  checkFavourite(Shop shop){
 return favouriteList.contains(shop);
}

  Future<void> updateFavouriteList(Shop shop) async{
     FireResponse response;
     String? favoriteToJson;
     print(checkFavourite(shop));
    if(checkFavourite(shop)){
      favouriteList.remove(shop);
      notifyListeners();
     favoriteToJson=jsonEncode(favouriteList.map((e) =>e.toJson()).toList());

    }else{
      favouriteList.add(shop);
      favoriteToJson=jsonEncode(favouriteList.map((e) =>e.toJson()).toList());
    }
      signUp?.favourite=favoriteToJson;

   response = await petCareService.updateFavourite(signUp!);
   if(response.statusUtil==StatusUtil.success){
    setFavourite(true);
   await  itemDetails();

   }
     
  }


  Future<void> deleteFavourite(String id) async {
    if (_deleteFavouriteUtil != StatusUtil.loading) {
      setDeleteFavourite(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.removeShopFavourite(id);
      if (response.statusUtil == StatusUtil.success) {
        setDeleteFavourite(StatusUtil.success);
      }
    } catch (e) {
      errorMessage = e.toString();
      setDeleteFavourite(StatusUtil.error);
    }
  }

  // void toggleFavouriteStatus(int index) async {
  //   String id = shopItemsList[index].id!;

  //   try {
  //     if (favouriteIndices.contains(index)) {
  //       await petCareService.removeShopFavourite(id);
  //     } else {
  //       await petCareService.saveShopFavourite(shopItemsList[index]);
  //     }

  //     favouriteIndices.contains(index)
  //         ? favouriteIndices.remove(index)
  //         : favouriteIndices.add(index);

  //     setShopFavouriteUtil(StatusUtil.success);
  //     setDeleteFavourite(StatusUtil.success);
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     setShopFavouriteUtil(StatusUtil.error);
  //     setDeleteFavourite(StatusUtil.error);
  //   }

  //   notifyListeners();
  // }


  Future<void> getFavoriteItemsFromFirebase() async {
    try {
      FireResponse response = await petCareService.getShopFavourite();
      if (response.statusUtil == StatusUtil.success) {
       favouriteList = response.data;
      } else {
        errorMessage = response.errorMessage;
        setShopFavouriteUtil(StatusUtil.error);
        // or handle the error accordingly
      }
    } catch (e) {
      errorMessage = e.toString();
      setShopFavouriteUtil(StatusUtil.error);

    }
  }




  Future<void> itemDetails() async {
    if (_getshopItemsUtil != StatusUtil.loading && !isFromFav) {
      print("Fetching shop items - Setting loading status");
      setgetShopItemsUtil(StatusUtil.loading);
    }
    try {
      var response = await petCareService.getShopItems();
      if (response.statusUtil == StatusUtil.success) {
        shopItemsList = response.data;
        print("Shop items fetched successfully");
        setgetShopItemsUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
        print("Error fetching shop items: $errorMessage");
        setgetShopItemsUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      print("Exception while fetching shop items: $errorMessage");
      setgetShopItemsUtil(StatusUtil.error);
    }
  }

  setImage(XFile? image) {
    this.image = image;
    notifyListeners();
  }

  setImageUrl(String? imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  uploadImageForShop() async {
    if (image != null) {
      // List<String>extension=image!.name.split(".");
      final storageRef = FirebaseStorage.instance.ref();
      var mountainRef = storageRef.child("${image!.name}");
      try {
        await mountainRef.putFile(File(image!.path));
        final downloadUrl = await mountainRef.getDownloadURL();
        imageUrl = downloadUrl;
        setUploadImageInFireBaseUtil(StatusUtil.success);
      } catch (e) {
        setUploadImageInFireBaseUtil(StatusUtil.error);
      }
    }
  }

  Future<void> sendValueToFireBase() async {
    await uploadImageForShop();
    Shop shop = Shop(
      id: id,
      product: product,
      condition: condition,
      location: location,
      images: imageUrl,
      price: price,
      negotiable: negotiable,
      description: description,
    );

    try {
      FireResponse response = await petCareService.shopItemDetails(shop);
      if (response.statusUtil == StatusUtil.success) {
        setShopItemsUtil(StatusUtil.success);
      } else {
        errorMessage = response.errorMessage;
        setShopItemsUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setShopItemsUtil(StatusUtil.error);
    }
  }
}
