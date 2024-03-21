import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/model/ads.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/model/feed.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/model/verificationTools.dart';
import 'package:project_petcare/response/response.dart';

abstract class PetCareService {
  Future<ApiResponse> isUserLoggedIn(SignUp signUp, String token);

  Future<FireResponse> ourServiceData(OurService ourService);
  Future<FireResponse> donateData(Donate donate);
  Future<ApiResponse> adoptDetails(Adopt adopt);

  Future<FireResponse> getPetDetails();
  Future<FireResponse> saveShopFavourite(Shop shop);
  // Future<FireResponse> getShopFavourite();
  // Future<FireResponse> removeShopFavourite(String id);
  Future<FireResponse> getAdoptDetails();
  Future<ApiResponse> updateAdoptDetails(Adopt adopt);
  Future<FireResponse> shopItemDetails(Shop shop);
  Future<FireResponse> getShopItems();
  // Future<FireResponse> saveDashServiceDetails(OurService ourService);

  Future<ApiResponse> categoriesDetails(Categories categories, String token);
  Future<FireResponse> saveProfessionData(OurService ourService);
  Future<FireResponse> getProfessionDetails();
  Future<FireResponse> getDashServiceDetails();
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

  Future<ApiResponse> userLogin(SignUp signUp, String token);
  Future<ApiResponse> userLoginDetails(SignUp signUp, String token);
  Future<ApiResponse> saveUserDetails(SignUp signUp, String token);
  Future<ApiResponse> saveSellingPet(Adopt adopt, String token);
  Future<ApiResponse> saveDashOurService(OurService ourService, String token);
  Future<ApiResponse> saveOurServiceDto(
      OurServiceDto ourServiceDto, String token);
  Future<ApiResponse> saveDonatePet(Adopt adopt, String token);
  Future<ApiResponse> saveAdsImage(Ads ads, String token);

  Future<ApiResponse> getUserName(String token);
  Future<ApiResponse> getUserFullName(String token);
  Future<ApiResponse> getUserEmail(String token);
  Future<ApiResponse> getSellingPet(String token);
  Future<ApiResponse> getOurService(String token);
  Future<ApiResponse> getDonatePet(String token);
  Future<ApiResponse> getCategoriesDetails(String token);
  Future<ApiResponse> getAdsImage(String token);
  Future<ApiResponse> getDashService(String token);
  Future<ApiResponse> getOurServiceDto(String token);
   Future<ApiResponse> getUserAddedPet(String token);

  Future<ApiResponse> getCategoriesById(
      Categories categories, int id, String token);
  Future<ApiResponse> getApprovedDonatedPet(String token);
  Future<ApiResponse> getApprovedSellingPet(String token);
 

  Future<ApiResponse> deleteCategoryById(int id, String token);
  Future<ApiResponse> deleteAdsById(int id, String token);
  Future<ApiResponse> deleteOurServiceById(int id, String token);
  Future<ApiResponse> deleteOurServiceDtoById(int id, String token);
  Future<ApiResponse> deleteDonatedPetById(Adopt adopt, int id, String token);
  Future<ApiResponse> deleteSellingPetById(int id, String token);

  Future<ApiResponse> approvelDonated(Adopt adopt, int id, String token);
  Future<ApiResponse> approvelSelling(Adopt adopt, int id, String token);


  Future<ApiResponse> searchSellingPets(String token);
  Future<ApiResponse> searchDonatedPets(String token);
}
