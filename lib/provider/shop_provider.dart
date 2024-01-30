import 'dart:convert';
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
import 'package:shared_preferences/shared_preferences.dart';

class ShopProvider extends ChangeNotifier {
  PetCareService petCareService = PetCareImpl();

  String? errorMessage, imageUrl;
  String? product, condition, location, price, description, images, negotiable;
  XFile? image;

  List<Shop> shopItemsList = [];
  List<Shop> _cartItemsList = [];
  List<int> _cartIndices = [];

  Set<int> _favouriteIndices = {};
  
  Set<int> get favouriteIndices => _favouriteIndices;
  List<Shop> get cartItemsList => _cartItemsList;
  List<int> get cartIndices => _cartIndices;



  bool isFavourite(int index) {
    return favouriteIndices.contains(index);
  }

  bool isCart(Shop item) {
    return _cartItemsList.contains(item);
  }

  double _per = 0.0;
  double get per => _per;
  void updatePercent(double value) {
    _per = value;
    notifyListeners();
  }

  late SharedPreferences _prefs;

  ShopProvider() {
    _initPreferences();
    _loadCartData();
  }
  

  StatusUtil _shopItems = StatusUtil.idle;
  StatusUtil _uploadImageForShop = StatusUtil.idle;
  StatusUtil _getshopItemsUtil = StatusUtil.idle;

  StatusUtil get shopIetms => _shopItems;
  StatusUtil get uploadImageInFireBase => _uploadImageForShop;
  StatusUtil get getshopIemsUtil => _getshopItemsUtil;

  setShopItemsUtil(StatusUtil statusUtil) {
    _shopItems = statusUtil;
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
  void _loadCartData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cartData = prefs.getString('cartData');

  if (cartData != null) {
    List<Map<String, dynamic>> cartList = List<Map<String, dynamic>>.from(json.decode(cartData));
    _cartItemsList = cartList.map((jsonMap) => Shop.fromJson(jsonMap)).toList();
    _cartIndices = List.generate(_cartItemsList.length, (index) => index);
    notifyListeners();
  }
}
 void _saveCartData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> cartList = _cartItemsList.map((item) => item.toJson()).toList();
  prefs.setString('cartData', json.encode(cartList));
}


  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavouriteFromPrefs();
    
  }

  void _saveFavouriteToPrefs() {
    List<String> favouriteList =
        _favouriteIndices.map((index) => index.toString()).toList();
    _prefs.setStringList("favouriteIndices", favouriteList);
  }

 

  Future<void> _loadFavouriteFromPrefs() async {
    List<String>? savedFavourites = _prefs.getStringList("favouriteIndices");
    if (savedFavourites != null) {
      _favouriteIndices = savedFavourites.map((str) => int.parse(str)).toSet();
    }
    notifyListeners();
  }

  
 void addToCart(Shop shop) {
    if (!_cartIndices.contains(shop)) {
      _cartItemsList.add(shop);
      _cartIndices.add(_cartItemsList.length - 1);
      notifyListeners();
      _saveCartData(); // Save the cart data after modification
    }
  }
   void removeFromCart(Shop shop) {
    
      _cartItemsList.remove(shop);
      
      notifyListeners();
      _saveCartData(); // Save the cart data after modification
    
  }
    

   

  void toggleFavouriteStatus(int index) {
    if (favouriteIndices.contains(index)) {
      favouriteIndices.remove(index);
    } else {
      favouriteIndices.add(index);
    }
    _saveFavouriteToPrefs();
    notifyListeners();
  }

  Future<void> itemDetails() async {
    if (_getshopItemsUtil != StatusUtil.loading) {
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
