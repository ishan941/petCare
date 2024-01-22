class Donate {
  String? petname;
  String? petweight;
  String? petage;
  String? gender, phone, location;
  String? petbread;
  String? imageUrl;

  Donate(
      {this.petname, this.petweight, this.petage, this.gender, this.petbread, this.imageUrl, this.location, this.phone});

  Donate.fromJson(Map<String, dynamic> json) {
    petname = json['petname'];
    petweight = json['petweight'];
    petage = json['petage'];
    gender = json['gender'];
    petbread = json['petbread'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petname'] = this.petname;
    data['petweight'] = this.petweight;
    data['petage'] = this.petage;
    data['gender'] = this.gender;
    data['petbread'] = this.petbread;
    data['imageUrl'] = this.imageUrl;
    data['phone'] = this.phone;
    data['location'] = this.location;
    
    return data;
  }
}