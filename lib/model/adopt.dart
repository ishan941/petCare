class Adopt {
  String? petName;
  String? ownerName;
  String? petWeight;
  String? petAge;
  String? gender;
  String? ownerPhone;
  String? location;
  String? description;
  String? petBreed;
  String? categories;
  String? imageUrl;
  String? id;
  String? petAgeTime;
  String? userImage;
  String? petPrice;
  bool isDoubleTapped;

  Adopt({
    this.petName,
    this.petAgeTime,
    this.petWeight,
    this.id,
    this.petAge,
    this.gender,
    this.petBreed,
    this.imageUrl,
    this.location,
    this.ownerPhone,
    this.ownerName,
    this.userImage,
    this.categories,
    this.description,
    this.petPrice,
    this.isDoubleTapped = false,
  });

  Adopt.fromJson(Map<String, dynamic> json)
      : petName = json['petname'],
        petWeight = json['petweight'],
        petAge = json['petage'],
        gender = json['gender'],
        petBreed = json['petbread'],
        imageUrl = json['imageUrl'],
        ownerPhone = json['phone'],
        location = json['location'],
        ownerName = json['name'],
        id = json['id'],
        categories = json['categories'],
        petAgeTime = json['petAgeTime'],
        description = json['description'],
        petPrice = json['petPrice'],
        isDoubleTapped = false,
        userImage = json['userImage']; // Initialize isDoubleTapped here

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petname'] = this.petName;
    data['petweight'] = this.petWeight;
    data['petage'] = this.petAge;
    data['gender'] = this.gender;
    data['petbread'] = this.petBreed;
    data['imageUrl'] = this.imageUrl;
    data['phone'] = this.ownerPhone;
    data['location'] = this.location;
    data['name'] = this.ownerName;
    data['description'] = this.description;
    data['id'] = this.id;
    data['petAgeTime'] = this.petAgeTime;
    data['petPrice'] = this.petPrice;
    data['categories'] = this.categories;
    data['userImage'] = this.userImage;

    return data;
  }
}
