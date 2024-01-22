import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareimpl.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class ShopProvider extends ChangeNotifier {
  


  String? errorMessage, imageUrl;
  String? product, condition, location, price, description, images, negotiable;
  XFile? image;
  PetCareService petCareService = PetCareImpl();
   List<Shop> shopItemsList=[];

   double _per = 0.0;
  double get per => _per;
  void updatePercent(double value){
    _per = value;
    notifyListeners();

  }

  StatusUtil _shopItems = StatusUtil.idle;
  StatusUtil _uploadImageForShop = StatusUtil.idle;
  StatusUtil _shopItemsUtil =StatusUtil.idle;

  StatusUtil get shopIetms => _shopItems;
  StatusUtil get uploadImageInFireBase => _uploadImageForShop;
  StatusUtil get getshopIemsUtil => _shopItemsUtil;

  setShopItemsUtil(StatusUtil statusUtil) {
    _shopItems = statusUtil;
    notifyListeners();
  }

  setUploadImageInFireBaseUtil(StatusUtil statusUtil) {
    _uploadImageForShop = statusUtil;
    notifyListeners();
  }
  
  setgetShopItemsUtil(StatusUtil statusUtil){
    _shopItemsUtil =statusUtil;
    notifyListeners();
  }

  Future<void> shopItemDetails(Shop shop) async {
    if (_shopItems != StatusUtil.loading) {
       setShopItemsUtil(StatusUtil.loading);
    }
    try {
      FireResponse response = await petCareService.shopItemDetails(shop);
      if (response.statusUtil == StatusUtil.success) {
         setShopItemsUtil(StatusUtil.success);
      } else if (response.statusUtil == StatusUtil.error) {
        errorMessage = response.errorMessage;
         setShopItemsUtil(StatusUtil.error);
      }
    } catch (e) {
      errorMessage = "$e";
      setShopItemsUtil(
        StatusUtil.error,
      );
    }
  }
  Future<void> itemDetails()async{
if(_shopItemsUtil != StatusUtil.loading){
  setgetShopItemsUtil(StatusUtil.loading);
}
try{
  FireResponse response = await petCareService.getShopItems();
  if(response.statusUtil == StatusUtil.success){
     shopItemsList=response.data;
    setShopItemsUtil(StatusUtil.success);
   
  }else if (response.statusUtil == StatusUtil.error){
    errorMessage = response.errorMessage;
    setgetShopItemsUtil(StatusUtil.error);
  }

}catch(e){
  errorMessage = "$e";
  setgetShopItemsUtil(StatusUtil.error);
}

  }

  setImage(XFile? image) {
    this.image=image;
    notifyListeners();
  }

  setImageUrl(String? imageUrl) {
    this.imageUrl=imageUrl;
    notifyListeners();
  }

  uploadImageForShop() async {
    setShopItemsUtil(StatusUtil.loading);

    if (image != null) {
      // List<String>extension=image!.name.split(".");
      final storageRef = FirebaseStorage.instance.ref();
      var mountainRef = storageRef.child("${image!.name}");
      try {
        await mountainRef.putFile(File(image!.path));
        final downloadUrl = await mountainRef.getDownloadURL();
        imageUrl = downloadUrl;
        setShopItemsUtil(StatusUtil.success);
      } catch (e) {
        setShopItemsUtil(StatusUtil.error);
      }
    }
    Future<void> shopItemDetails(Shop shop) async {
      if(_uploadImageForShop != StatusUtil.loading){
        setUploadImageInFireBaseUtil(StatusUtil.loading);
      }
      try{ 
        FireResponse response = await petCareService.shopItemDetails(shop);
        if(response.statusUtil == StatusUtil.success){
          setUploadImageInFireBaseUtil(StatusUtil.success);
        }else if(response.statusUtil == StatusUtil.error){
          setUploadImageInFireBaseUtil(StatusUtil.error);
        }

      }catch(e){
        errorMessage= "$e";
        setUploadImageInFireBaseUtil(StatusUtil.error);
      }

    }
  }

  sendValueToFireBase(BuildContext context) async {
   await  uploadImageForShop();
    Shop shop = Shop(
        product: product,
        condition: condition,
        location: location,
        images: imageUrl,
        price: price,
        negotiable: negotiable,
        description: description);
    await petCareService.shopItemDetails(shop).then((value) {
      if (shopIetms == StatusUtil.success) {
        Helper.snackBar(successfullySavedStr, context);
      } else if (shopIetms == StatusUtil.error) {
        Helper.snackBar(failedToSaveStr, context);
      }
    });
  }
}
