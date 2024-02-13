class Adopt {
  String? petname;
  String? name;
  String? petweight;
  String? petage;
  String? gender, phone, location;
  String? petbread;
  String? imageUrl;
  String? id;
  String? petAgeTime;
  bool isDoubleTapped;

  Adopt({
    this.petname,
    this.petAgeTime,
    this.petweight,
    this.id,
    this.petage,
    this.gender,
    this.petbread,
    this.imageUrl,
    this.location,
    this.phone,
    this.name,
    this.isDoubleTapped = false,
  });

  Adopt.fromJson(Map<String, dynamic> json)
      : petname = json['petname'],
        petweight = json['petweight'],
        petage = json['petage'],
        gender = json['gender'],
        petbread = json['petbread'],
        imageUrl = json['imageUrl'],
        phone = json['phone'],
        location = json['location'],
        name = json['name'],
        id = json['id'],
        petAgeTime = json['petAgeTime'],
        isDoubleTapped = false; // Initialize isDoubleTapped here

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
    data['name'] = this.name;
    data['id'] = this.id;
    data['petAgeTime'] = this.petAgeTime;

    return data;
  }
}
