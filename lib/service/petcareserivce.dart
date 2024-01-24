import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/response/response.dart';

abstract class PetCareService {
  Future<FireResponse> petCareData(PetCare petCare);
  Future<FireResponse> isUserExist(PetCare petCare);
  Future<FireResponse> isUserLoggedIn(SignUp signUp);
  Future<FireResponse> getUserLoginData();
  Future<FireResponse> ourServiceData(OurService ourService);
  Future<FireResponse> donateData(Donate donate);
  Future<FireResponse> adoptDetails(Adopt adopt);
  Future<FireResponse> getPetDetails();
  Future<FireResponse> getUserDetails();
  Future<FireResponse> getAdoptDetails();
  Future<FireResponse> shopItemDetails(Shop shop);
  Future<FireResponse> getShopItems();
  Future<FireResponse> saveDashServiceDetails(DashService dashService);
  Future<FireResponse> saveProfessionData(OurService ourService);
  Future<FireResponse> getDashServiceDetails();
  Future<FireResponse> userLoginDetails(SignUp signUp);
}
