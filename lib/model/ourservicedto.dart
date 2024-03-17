

class OurServiceDto {
  String? cpImage;
  String? ppImage;
  String? service;
  String? profession;
  String? fullName;
  String? phone;
  String? email;
  String? location;
  String? description;
  String? profilePicture;
  String? shopLocation;
  String? shopName;

  OurServiceDto(
      {this.cpImage,
      this.ppImage,
      this.service,
      this.profession,
      this.location,
      this.description,
      this.shopName,
      this.shopLocation,
      this.profilePicture,
      this.fullName,
      this.phone,
      this.email,});

  OurServiceDto.fromJson(Map<String, dynamic> json) {
    cpImage = json['cpImage'];
    ppImage = json['ppImage'];
    service = json['service'];
    profession = json['profession'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    profilePicture = json['profilePictureUrl'];
    shopName = json['shopName'];
    shopLocation = json['shopLocation'];
    description = json['description'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpImage'] = this.cpImage;
    data['ppImage'] = this.ppImage;
    data['service'] = this.service;
    data['profession'] = this.profession;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profilePictureUrl'] = this.profilePicture;
    data['shopLocation'] = this.shopLocation;
    data['shopName'] = this.shopName;
    data['description'] = this.description;
    data['location'] = this.location;
    return data;
  }
   static List<OurServiceDto> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => OurServiceDto.fromJson(json)).toList();
  }
}
