import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/model/feed.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetCareImpl extends PetCareService {
  @override
  @override
  Future<FireResponse> donateData(Donate donate) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("DonateStore")
            .add(donate.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  //send to firebase
  @override
  Future<FireResponse> userLoginDetails(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("User LoginData")
            .add(signUp.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> isUserLoggedIn(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("User LoginData")
            .where("phone", isEqualTo: signUp.phone)
            .where("password", isEqualTo: signUp.password)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          String? name = (querySnapshot.docs.first.data()
              as Map<String, dynamic>?)?['name'];
          String? email = (querySnapshot.docs.first.data()
              as Map<String, dynamic>?)?['email'];
          String? phone = (querySnapshot.docs.first.data()
              as Map<String, dynamic>?)?['phone'];
          Map<String, dynamic> userData = {
            'name': name,
            'email': email,
            'phone': phone
          };

          return FireResponse(statusUtil: StatusUtil.success, data: userData);
        } else {
          return FireResponse(statusUtil: StatusUtil.success, data: "");
        }
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getPetDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("DonateStore").get();
        final pet = response.docs;
        List<Donate> petList = [];
        if (pet.isNotEmpty) {
          for (var petdetail in pet) {
            petList.add(Donate.fromJson(petdetail.data()));
          }
        }
        return FireResponse(statusUtil: StatusUtil.success, data: petList);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getShopItems() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("ShopDetails").get();
        final items = response.docs;
        List<Shop> shopItemsList = [];
        if (items.isNotEmpty) {
          for (var shopItemDetails in items) {
            Shop shop = Shop.fromJson(shopItemDetails.data());
            shop.id = shopItemDetails.id;
            shopItemsList.add(shop);

            // shopItemsList.add(Shop.fromJson(shopItemDetails.data()));
          }
        }
        return FireResponse(
            statusUtil: StatusUtil.success, data: shopItemsList);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getAdoptDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("AdoptDetails").get();
        final getAdoptdata = response.docs;
        List<Adopt> adoptDetailsList = [];
        if (getAdoptdata.isNotEmpty) {
          for (var adoptDetails in getAdoptdata) {
            Adopt adopt = Adopt.fromJson(adoptDetails.data());
            adopt.id = adoptDetails.id;
            adoptDetailsList.add(adopt);
          }
        }
        return FireResponse(
            statusUtil: StatusUtil.success, data: adoptDetailsList);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getDashServiceDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response = await FirebaseFirestore.instance
            .collection("ourServiceDashBoard")
            .get();
        final getDashService = response.docs;
        List<DashService> dashServiceList = [];
        if (getDashService.isNotEmpty) {
          for (var dashServiceDetails in getDashService) {
            dashServiceList
                .add(DashService.fromJson(dashServiceDetails.data()));
          }
        }
        return FireResponse(
            statusUtil: StatusUtil.success, data: dashServiceList);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

// shopItms Store to database
  @override
  Future<FireResponse> shopItemDetails(Shop shop) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance.collection('ShopDetails').add(shop.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> ourServiceData(OurService ourService) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("serviceDetails")
            .add(ourService.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> saveDashServiceDetails(DashService dashService) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("ourServiceDashBoard")
            .add(dashService.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> saveProfessionData(OurService ourService) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("ProfessionData")
            .add(ourService.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getProfessionDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("ProfessionData").get();
        final user = response.docs;
        List<OurService> professionDataList = [];
        if (user.isNotEmpty) {
          for (var professionData in user) {
            professionDataList.add(OurService.fromJson(professionData.data()));
          }
        }
        return FireResponse(
            statusUtil: StatusUtil.success, data: professionDataList);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> adoptDetails(Adopt adopt) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("AdoptDetails")
            .add(adopt.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> userVerification(
      VerificationTools verificationTools) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("UserVerification")
            .add(verificationTools.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> categoriesDetails(Categories categories) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("CategoriesItems")
            .add(categories.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getCategoriesDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response = await FirebaseFirestore.instance
            .collection("CategoriesItems")
            .get();
        final items = response.docs;
        List<Categories> categoriesList = [];
        if (items.isNotEmpty) {
          for (var categoriesitems in items) {
            categoriesList.add(Categories.fromJson(categoriesitems.data()));
          }
        }
        return FireResponse(
            statusUtil: StatusUtil.success, data: categoriesList);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> deleteAdoptById(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("AdoptDetails")
          .doc(id)
          .delete();

      return FireResponse(statusUtil: StatusUtil.success);
    } catch (e) {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: e.toString());
    }
  }

  @override
  Future<FireResponse> updateAdoptDetails(Adopt adopt) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("AdoptDetails")
            .doc(adopt.id)
            .update(adopt.toJson());

        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
    return FireResponse(
        statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  }

  @override
  Future<FireResponse> saveShopFavourite(Shop shop) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("myFavourites")
            .add(shop.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: successfullySavedStr);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getUserByEmail() async {
    String email = await readEmailFromSharedPreference();
    SignUp? user;
    if (await Helper.checkInterNetConnection()) {
      try {
        var response = await FirebaseFirestore.instance
            .collection("User LoginData")
            .where("email", isEqualTo: email)
            .get();
        final getUserdata = response.docs.first;

        // if (getUserdata) {
        user = SignUp.fromJson(getUserdata.data());
        user.id = getUserdata.id;
        // }
        return FireResponse(statusUtil: StatusUtil.success, data: user);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  readEmailFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail') ?? 'Email';
    return userEmail;
  }

  @override
  Future<FireResponse> updateProfile(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("User LoginData")
            .doc(signUp.id)
            .update(signUp.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> updateFavourite(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("User LoginData")
            .doc(signUp.id)
            .update(signUp.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
    return FireResponse(
        statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  }

  @override
  Future<FireResponse> updateCart(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("User LoginData")
            .doc(signUp.id)
            .update(signUp.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> myPetDetails(MyPet myPet) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("MyPetDetails")
            .add(myPet.toJson());
        return FireResponse(
            statusUtil: StatusUtil.success,
            successMessage: "Successfully saved");
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getMyPetDetails() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("MyPetDetails").get();
        final pet = response.docs;
        List<MyPet> myPetList = [];
        if (pet.isNotEmpty) {
          for (var getMyPet in pet) {
            myPetList.add(MyPet.fromJson(getMyPet.data()));
          }
        }
        return FireResponse(statusUtil: StatusUtil.success, data: myPetList);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> updatePet(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("MyPetDetails")
            .doc(signUp.id)
            .update(signUp.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> updateMyPetDetails(MyPet myPet) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("MyPetDetails")
            .doc(myPet.id)
            .update(myPet.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> saveFeedValue(Feed feed) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("Feed Details")
            .add(feed.toJson());
        return FireResponse(statusUtil: StatusUtil.success);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }

  @override
  Future<FireResponse> getFeedValue() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("Feed Details").get();
        final user = response.docs;
        List<Feed> feedList = [];
        if (user.isNotEmpty) {
          for (var feedData in user) {
            feedList.add(Feed.fromJson(feedData.data()));
          }
        }
        return FireResponse(statusUtil: StatusUtil.success, data: feedList);
      } catch (e) {
        return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return FireResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetStr);
    }
  }
}
