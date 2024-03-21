import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/core/baseurl.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/model/ads.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/model/feed.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/service/api.dart';
import 'package:project_petcare/service/petcareserivce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetCareImpl extends PetCareService {
  Dio dio = Dio();
  Api api = Api();
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
  // @override
  // Future<Apiresponse> userLoginDetails(SignUp signUp) async {
  //   if (await Helper.checkInterNetConnection()) {
  //     try {
  //       Response response = await dio.post(
  //         url + "/saveUsers",
  //         data: signUp.toJson(),
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         return Apiresponse(statusUtil: StatusUtil.success);
  //       } else {
  //         return Apiresponse(
  //           statusUtil: StatusUtil.error,
  //           errorMessage:
  //               "Unexpected server response: ${response.statusCode} ${response.statusMessage}",
  //         );
  //       }
  //     } on DioError catch (e) {
  //       if (e.error is SocketException) {
  //         return Apiresponse(
  //           statusUtil: StatusUtil.error,
  //           errorMessage: "No internet connection.",
  //         );
  //       } else if (e.response != null) {
  //         if (e.response!.statusCode == 400) {
  //           return Apiresponse(
  //             statusUtil: StatusUtil.error,
  //             errorMessage: e.response!.statusMessage ?? badRequestStr,
  //           );
  //         } else if (e.response!.statusCode == 404) {
  //           return Apiresponse(
  //             statusUtil: StatusUtil.error,
  //             errorMessage: "Resource not found. Check your request URL.",
  //           );
  //         } else {
  //           return Apiresponse(
  //             statusUtil: StatusUtil.error,
  //             errorMessage:
  //                 "Unexpected server response: ${e.response!.statusCode} ${e.response!.statusMessage}",
  //           );
  //         }
  //       } else {
  //         return Apiresponse(
  //           statusUtil: StatusUtil.error,
  //           errorMessage: "Unexpected error: ${e.toString()}",
  //         );
  //       }
  //     }
  //   }

  //   return Apiresponse(
  //     statusUtil: StatusUtil.error,
  //     errorMessage: noInternetStr,
  //   );
  // }

  // @override
  // Future<Apiresponse> isUserLoggedIn(SignUp signUp) async {
  //   if (await Helper.checkInterNetConnection()) {
  //     try {
  //       // Assuming your API endpoint for login is "/user/login"
  //       Response response = await dio.post(
  //         url + "/login",
  //         data: signUp.toJson(),
  //       );

  //       if (response.statusCode == 200) {
  //         // If the server returns user data, extract it and return a success response
  //         Map<String, dynamic> userData = response.data['data'];
  //         return Apiresponse(statusUtil: StatusUtil.success, data: userData);
  //       } else {
  //         // If the server returns an error, handle it accordingly
  //         return Apiresponse(
  //           statusUtil: StatusUtil.error,
  //           errorMessage:
  //               "Login failed. Server response: ${response.statusCode}",
  //         );
  //       }
  //     } on DioError catch (e) {
  //       // Handle Dio errors (e.g., no internet connection, timeouts, etc.)
  //       return Apiresponse(
  //         statusUtil: StatusUtil.error,
  //         errorMessage: "Dio error: ${e.toString()}",
  //       );
  //     }
  //   } else {
  //     return Apiresponse(
  //         statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  //   }
  // }

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
        Response response = await dio.get(BASEURL + "/getDonationPet");
        if (response.statusCode == 200) {
          dynamic responseData = response.data;

          if (responseData is List) {
            List<Adopt> adoptDetailsList =
                responseData.map((json) => Adopt.fromJson(json)).toList();

            return FireResponse(
              statusUtil: StatusUtil.success,
              data: adoptDetailsList,
            );
          } else {
            // Handle the case when the response data is a map
            // You may need to extract the list from the map based on your API's response structure.
            // For example: List<Adopt> adoptDetailsList = responseData['your_key_for_list'];
            return FireResponse(
              statusUtil: StatusUtil.error,
              errorMessage: "Unexpected response format",
            );
          }
        } else {
          return FireResponse(
            statusUtil: StatusUtil.error,
            errorMessage:
                "Unexpected server response: ${response.statusCode} ${response.statusMessage}",
          );
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          return FireResponse(
            statusUtil: StatusUtil.error,
            errorMessage: "No internet connection.",
          );
        } else if (e.response != null) {
          return FireResponse(
            statusUtil: StatusUtil.error,
            errorMessage:
                "Unexpected server response: ${e.response!.statusCode} ${e.response!.statusMessage}",
          );
        } else {
          return FireResponse(
            statusUtil: StatusUtil.error,
            errorMessage: "Unexpected error: ${e.toString()}",
          );
        }
      }
    } else {
      return FireResponse(
        statusUtil: StatusUtil.error,
        errorMessage: noInternetStr,
      );
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
        List<OurService> dashServiceList = [];
        if (getDashService.isNotEmpty) {
          for (var dashServiceDetails in getDashService) {
            dashServiceList.add(OurService.fromJson(dashServiceDetails.data()));
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
//firebase
  // @override
  // Future<FireResponse> saveDashServiceDetails(OurService ourService) async {
  //   if (await Helper.checkInterNetConnection()) {
  //     try {
  //       FirebaseFirestore.instance
  //           .collection("ourServiceDashBoard")
  //           .add(ourService.toJson());
  //       return FireResponse(
  //           statusUtil: StatusUtil.success,
  //           successMessage: successfullySavedStr);
  //     } catch (e) {
  //       return FireResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
  //     }
  //   } else {
  //     return FireResponse(
  //         statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  //   }
  // }

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
  Future<ApiResponse> adoptDetails(Adopt adopt) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        FirebaseFirestore.instance
            .collection("AdoptDetails")
            .add(adopt.toJson());
        return ApiResponse(
          statusUtil: StatusUtil.success,
        );
      } catch (e) {
        return ApiResponse(statusUtil: StatusUtil.error, errorMessage: "$e");
      }
    } else {
      return ApiResponse(
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
  Future<ApiResponse> updateAdoptDetails(Adopt adopt) async {
    if (await Helper.checkInterNetConnection()) {
      try {
        Response response = await dio.put(
          BASEURL + "/saveDonatedPet",
          data: adopt.toJson(),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Do something with the data if needed

          return ApiResponse(statusUtil: StatusUtil.success);
        } else {
          return ApiResponse(
            statusUtil: StatusUtil.error,
            errorMessage:
                "Unexpected server response: ${response.statusCode} ${response.statusMessage}",
          );
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          return ApiResponse(
            statusUtil: StatusUtil.error,
            errorMessage: "No internet connection.",
          );
        } else if (e.response != null) {
          return ApiResponse(
            statusUtil: StatusUtil.error,
            errorMessage:
                "Unexpected server response: ${e.response!.statusCode} ${e.response!.statusMessage}",
          );
        } else {
          return ApiResponse(
            statusUtil: StatusUtil.error,
            errorMessage: "Unexpected error: ${e.toString()}",
          );
        }
      }
    }

    return ApiResponse(
      statusUtil: StatusUtil.error,
      errorMessage: noInternetStr,
    );
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
        user.email = getUserdata.id;
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
            .doc(signUp.email)
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
            .doc(signUp.email)
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
            .doc(signUp.email)
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
            .doc(signUp.email)
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

  @override
  Future<ApiResponse> isUserLoggedIn(SignUp signUp, String token) async {
    ApiResponse response =
        await api.post(BASEURL + loginUrl, signUp.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> userLoginDetails(SignUp signUp, String token) async {
    ApiResponse response =
        await api.post(BASEURL + saveUserUrl, signUp.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> userLogin(SignUp signUp, String token) async {
    ApiResponse response =
        await api.post(BASEURL + loginUrl, signUp.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveUserDetails(SignUp signUp, String token) async {
    ApiResponse response =
        await api.post(BASEURL + saveUserUrl, signUp.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveSellingPet(Adopt adopt, String token) async {
    ApiResponse response = await api
        .post(BASEURL + saveSellingPetUrl, adopt.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveDonatePet(Adopt adopt, String token) async {
    ApiResponse response = await api
        .post(BASEURL + saveDonatedPetUrl, adopt.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> categoriesDetails(
      Categories categories, String token) async {
    ApiResponse response = await api
        .post(BASEURL + saveCategoryUrl, categories.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveDashOurService(
      OurService ourService, String token) async {
    ApiResponse response = await api
        .post(BASEURL + saveOurServiceUrl, ourService.toJson(), token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveOurServiceDto(
      OurServiceDto ourServiceDto, String token) async {
    ApiResponse response = await api.post(
        BASEURL + saveOurServiceDtoUrl, ourServiceDto.toJson(),
        token: token);
    return response;
  }

  @override
  Future<ApiResponse> saveAdsImage(Ads ads, String token) async {
    ApiResponse response =
        await api.post(BASEURL + saveAdsImageUrl, ads.toJson(), token: token);
    return response;
  }


 @override
  Future<ApiResponse> getApprovedDonatedPet(String token) async{
     ApiResponse response =
        await api.get(BASEURL + getApproveDonationListUrl, token: token);
    return response;
  }
    @override
  Future<ApiResponse> getApprovedSellingPet(String token) async{
     ApiResponse response =
        await api.get(BASEURL + getApproveSellingListUrl, token: token);
    return response;
  }
 

  @override
  Future<ApiResponse> approvelDonated(Adopt adopt,  int id, String token,)async {
    ApiResponse response =
        await api.post(BASEURL + acceptDonatedUrl + id.toString(), adopt.toJson(), token: token );
    return response;
  }
    @override
  Future<ApiResponse> approvelSelling(Adopt adopt, int id, String token) async{
     ApiResponse response =
        await api.post(BASEURL + acceptSellingUrl + id.toString(), adopt.toJson(), token: token );
    return response;
   
  }

   
  
  
  

  @override
  Future<ApiResponse> getUserName(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getUsernameUrl, token: token);
    return response;
  }
  @override
  Future<ApiResponse> getUserFullName(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getUserFullNameUrl, token: token);
    return response;
  }
  @override
  Future<ApiResponse> getUserEmail(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getUserEmailUrl, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getSellingPet(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getSellingPetUrl, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getDonatePet(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getDonationPetUrl, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getCategoriesDetails(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getCategoryUrl, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getOurService(String token) async {
    try {
      ApiResponse response = await api.get(BASEURL + "", token: token);
      final ourService = response.data;
      List<OurService> ourServiceList = [];
      if (ourService.isNotEmpty) {
        for (var ourServiceData in ourService) {
          ourServiceList.add(OurService.fromJson(ourServiceData.data));
        }
      }
      return ApiResponse(statusUtil: StatusUtil.success, data: ourServiceList);
    } catch (e) {
      return ApiResponse(
          statusUtil: StatusUtil.error,
          errorMessage: "Failed to fetch ourServiceData: $e");
    }
  }

  @override
  Future<ApiResponse> getAdsImage(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getAdsImageUrl, token: token);

    return response;
  }

  @override
  Future<ApiResponse> getDashService(String token) async {
    ApiResponse response = await api.get(BASEURL + getServideUrl, token: token);
    return response;
  }

  @override
  Future<ApiResponse> getOurServiceDto(String token) async {
    ApiResponse response =
        await api.get(BASEURL + getOurServiceDtoUrl, token: token);
    return response;
  }
   @override
  Future<ApiResponse> getUserAddedPet(String token) async{
      ApiResponse response =
        await api.get(BASEURL + getUserAddedPetApi, token: token);
    return response;
   
  }
  @override
  Future<ApiResponse> getCategoriesById( Categories categories, int id, String token) async {
    ApiResponse response =
        await api.post(BASEURL + getCategoryByIdUrl,categories.toJson(), token: token, );
    return response;
  }


 

// @override
// Future<ApiResponse> getCategoriesDetails() async {
//   if (await Helper.checkInterNetConnection()) {
//     try {
//       var response =
//           await FirebaseFirestore.instance.collection("CategoriesItems").get();
//       final items = response.docs;
//       List<Categories> categoriesList = [];
//       if (items.isNotEmpty) {
//         for (var categoriesitems in items) {
//           categoriesList.add(Categories.fromJson(categoriesitems.data()));
//         }
//       }
//       return ApiResponse(statusUtil: StatusUtil.success, data: categoriesList);
//     } catch (e) {
//       return ApiResponse(
//           statusUtil: StatusUtil.error, errorMessage: badRequestStr);
//     }
//   } else {
//     return ApiResponse(
//         statusUtil: StatusUtil.error, errorMessage: noInternetStr);
//   }
// }
// @override
//   Future<ApiResponse> d(String id) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("AdoptDetails")
//           .doc(id)
//           .delete();

//       return FireResponse(statusUtil: StatusUtil.success);
//     } catch (e) {
//       return FireResponse(
//           statusUtil: StatusUtil.error, errorMessage: e.toString());
//     }
//   }
 @override
  Future<ApiResponse> searchDonationPets(  String token) async {
    ApiResponse response =
        await api.get(BASEURL + searchDonationPetsApi, token: token);
    return response;
  }
  @override
  Future<ApiResponse> searchSellingPets(  String token) async {
    ApiResponse response =
        await api.get(BASEURL + searchSellingPetsApi, token: token);
    return response;
  }


  @override
  Future<ApiResponse> deleteCategoryById(int id, String token) async {
    ApiResponse response =
        await api.delete(BASEURL + deleteCategoryUrl + id.toString() ,  token: token);
    return response;
  }
   @override
  Future<ApiResponse> deleteAdsById(int id, String token) async{
    ApiResponse response =
        await api.delete(BASEURL + deleteAdsUrl + id.toString() ,  token: token);
    return response;
  }
    @override
  Future<ApiResponse> deleteOurServiceById(int id, String token) async{
    ApiResponse response =
        await api.delete(BASEURL + deleteAdsUrl + id.toString() ,  token: token);
    return response;
  }
  
  @override
  Future<ApiResponse> deleteOurServiceDtoById(int id, String token) async{
   ApiResponse response =
        await api.delete(BASEURL + deleteAdsUrl + id.toString() ,  token: token);
    return response;
  }
  
  @override
  Future<ApiResponse> deleteDonatedPetById(Adopt adopt, int id, String token) async{
    ApiResponse response =
        await api.delete(BASEURL + declineDonatedUrl + id.toString(), token: token);
    return response;
  }
  
  @override
  Future<ApiResponse> deleteSellingPetById(int id, String token) async{
   ApiResponse response =
        await api.delete(BASEURL + deleteSellingPetUrl + id.toString(), token: token);
    return response;
  }
  
 
  
 

  
  

 
}
