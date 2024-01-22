class OurService {
  String? profession;
  String? fullname;
  String? phone;
  String? email;

  OurService({this.profession, this.fullname, this.phone, this.email});

  OurService.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
