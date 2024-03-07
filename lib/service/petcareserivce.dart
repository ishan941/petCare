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

abstract class PetCareService {

  Future<ApiResponse> isUserLoggedIn(SignUp signUp);
  Future<FireResponse> ourServiceData(OurService ourService);
  Future<FireResponse> donateData(Donate donate);
  Future<ApiResponse> adoptDetails(Adopt adopt);
  Future<ApiResponse> saveSellingPet(Adopt adopt);
  Future<FireResponse> getPetDetails();
  Future<FireResponse> saveShopFavourite(Shop shop);
  // Future<FireResponse> getShopFavourite();
  // Future<FireResponse> removeShopFavourite(String id);
  Future<FireResponse> getAdoptDetails();
  Future<ApiResponse> updateAdoptDetails(Adopt adopt);
  Future<FireResponse> shopItemDetails(Shop shop);
  Future<FireResponse> getShopItems();
  Future<FireResponse> getCategoriesDetails();
  Future<FireResponse> saveDashServiceDetails(DashService dashService);
  Future<FireResponse> categoriesDetails(Categories categories);
  Future<FireResponse> saveProfessionData(OurService ourService);
  Future<FireResponse> getProfessionDetails();
  Future<FireResponse> getDashServiceDetails();
  Future<ApiResponse> userLoginDetails(SignUp signUp);
  Future<FireResponse> userVerification(VerificationTools verificationTools);
  Future<FireResponse> deleteAdoptById(String id);
  Future<FireResponse> getUserByEmail();
  Future<FireResponse> updateFavourite(SignUp signUp);
  Future<FireResponse> updateCart(SignUp signUp);
  Future<FireResponse> updateProfile(SignUp signUp);
  Future<FireResponse> myPetDetails(MyPet myPet);
  Future<FireResponse> getMyPetDetails();
  Future<FireResponse> updateMyPetDetails(MyPet myPet);
  Future<FireResponse> updatePet(SignUp signUp);

  Future<FireResponse> saveFeedValue(Feed feed);
  Future<FireResponse> getFeedValue();

  
}
