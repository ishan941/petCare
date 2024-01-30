import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/petcareserivce.dart';

class PetCareImpl extends PetCareService {
  @override
  Future<FireResponse> petCareData(PetCare petCare) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        await FirebaseFirestore.instance
            .collection("petCare")
            .add(petCare.toJson());

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

  @override
  Future<FireResponse> isUserExist(PetCare petCare) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("petCare")
            .where("phone", isEqualTo: petCare.phone)
            .where("password", isEqualTo: petCare.password)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          return FireResponse(statusUtil: StatusUtil.success, data: true);
        } else {
          return FireResponse(statusUtil: StatusUtil.success, data: false);
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
  Future<FireResponse> isUserLoggedIn(SignUp signUp) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("User LoginData")
            .where("phone", isEqualTo: signUp.phone)
            .where("password", isEqualTo: signUp.password)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          return FireResponse(statusUtil: StatusUtil.success, data: true);
        } else {
          return FireResponse(statusUtil: StatusUtil.success, data: false);
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
  Future<FireResponse> getUserLoginData() async {
    if (await Helper.checkInterNetConnection()) {
      try {
        var response =
            await FirebaseFirestore.instance.collection("User LoginData").get();

        return FireResponse(statusUtil: StatusUtil.success, data: response);
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
            shopItemsList.add(Shop.fromJson(shopItemDetails.data()));
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
    }
    return FireResponse(
        statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  }

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
}
