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

abstract class PetCareService {
  Future<FireResponse> petCareData(PetCare petCare);
  Future<FireResponse> isUserLoggedIn(SignUp signUp);
  Future<FireResponse> ourServiceData(OurService ourService);
  Future<FireResponse> donateData(Donate donate);
  Future<FireResponse> adoptDetails(Adopt adopt);
  Future<FireResponse> getPetDetails();
  Future<FireResponse> saveShopFavourite(Shop shop);
  Future<FireResponse> getShopFavourite();
  Future<FireResponse> removeShopFavourite(String id);
  Future<FireResponse> getAdoptDetails();
  Future<FireResponse> updateAdoptDetails(Adopt adopt);
  Future<FireResponse> shopItemDetails(Shop shop);
  Future<FireResponse> getShopItems();
  Future<FireResponse> getCategoriesDetails();
  Future<FireResponse> saveDashServiceDetails(DashService dashService);
  Future<FireResponse> categoriesDetails(Categories categories);
  Future<FireResponse> saveProfessionData(OurService ourService);
  Future<FireResponse> getProfessionDetails();
  Future<FireResponse> getDashServiceDetails();
  Future<FireResponse> userLoginDetails(SignUp signUp);
  Future<FireResponse> userVerification(VerificationTools verificationTools);
  Future<FireResponse> deleteAdoptById(String id);
  Future<FireResponse> getUserByEmail();
  Future<FireResponse> updateFavourite(SignUp signUp);
  
}
