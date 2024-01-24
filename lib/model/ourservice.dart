class OurService {
  String? profession;
  String? fullname;
  String? phone;
  String? email;
  String? shop;
  String? medical;
  String? trainner;

  OurService({this.profession, this.fullname, this.phone, this.email, this.medical, this.shop,this.trainner});

  OurService.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
     shop = json['shop'];
      medical = json['medical'];
       trainner = json['trainner'];
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
    return data;
  }
}
