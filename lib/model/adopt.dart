class Adopt {
  String? imageUrl;
  String? category;
  String? petName;
  String? ownerName;
  String? petBreed;
  String? gender;
  String? ownerPhone;
  String? location;
  String? petWeight;
  String? petAgeTime;
  String? userImage;
  String? description;
  String? petPrice;
  bool? isDoubleTapped;

  Adopt(
      {this.imageUrl,
      this.category,
      this.petName,
      this.ownerName,
      this.petBreed,
      this.gender,
      this.ownerPhone,
      this.location,
      this.petWeight,
      this.petAgeTime,
      this.userImage,
      this.description,
      this.petPrice,
      this.isDoubleTapped});

  Adopt.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    category = json['category'];
    petName = json['petName'];
    ownerName = json['ownerName'];
    petBreed = json['petBreed'];
    gender = json['gender'];
    ownerPhone = json['ownerPhone'];
    location = json['location'];
    petWeight = json['petWeight'];
    petAgeTime = json['petAgeTime'];
    userImage = json['userImage'];
    description = json['description'];
    petPrice = json['petPrice'];
    isDoubleTapped = json['isDoubleTapped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['category'] = this.category;
    data['petName'] = this.petName;
    data['ownerName'] = this.ownerName;
    data['petBreed'] = this.petBreed;
    data['gender'] = this.gender;
    data['ownerPhone'] = this.ownerPhone;
    data['location'] = this.location;
    data['petWeight'] = this.petWeight;
    data['petAgeTime'] = this.petAgeTime;
    data['userImage'] = this.userImage;
    data['description'] = this.description;
    data['petPrice'] = this.petPrice;
    data['isDoubleTapped'] = this.isDoubleTapped;
    return data;
  }
}
