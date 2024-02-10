import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';

class OurService {
  String? profession;
  String? fullname;
  String? phone;
  String? email;
  String? shop;
  String? location;
  String? description;
  String? medical;
  String? trainner;
  String? profilePicture;
  String? shopLocation;
  String? shopName;

  OurService({this.profession, this.location, this.description, this.shopName, this.shopLocation, this.profilePicture, this.fullname, this.phone, this.email, this.medical, this.shop,this.trainner,
  SignUpProvider? signUpProvider,
  PetCareProvider? petCareProvider
  });

  OurService.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
     shop = json['shop'];
      medical = json['medical'];
       trainner = json['trainner'];
       profilePicture = json['profilePictureUrl'];
       shopName = json['shopName'];
       shopLocation = json['shopLocation'];
       description = json['description'];
       location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['shop'] = this.shop;
    data['medical'] = this.medical;
    data['trainner'] = this.trainner;
    data['profilePictureUrl'] = this.profilePicture;
    data['shopLocation'] = this.shopLocation;
    data['shopName'] = this.shopName;
    data['description']= this.description;
    data['location']= this.location;
    return data;
  }
}
