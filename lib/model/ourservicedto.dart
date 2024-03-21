class OurServiceDto {
  String? service;
  String? fullName;
  String? phone;
  String? email;
  String? location;
  String? description;
  String? image;

  OurServiceDto({
    this.service,
    this.location,
    this.description,
    this.image,
    this.fullName,
    this.phone,
    this.email,
  });

  OurServiceDto.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    fullName = json['fullName'];
    phone = json['phone'];
    email = json['email'];
    image = json['profilePictureUrl'];
    description = json['description'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['service'] = this.service;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profilePictureUrl'] = this.image;
    data['description'] = this.description;
    data['location'] = this.location;
    return data;
  }

  static List<OurServiceDto> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => OurServiceDto.fromJson(json)).toList();
  }
}
