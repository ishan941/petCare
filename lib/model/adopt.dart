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
  int? id;
  String? petAgeTime;
  String? userImage;
  String? petPrice;
  bool isDoubleTapped;
  bool isAccepted;

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
    this.isAccepted = false,
  });

  Adopt.fromJson(Map<String, dynamic> json)
      : petName = json['petName'],
        petWeight = json['petWeight'],
        petAge = json['petAge'],
        gender = json['gender'],
        petBreed = json['petBread'],
        imageUrl = json['imageUrl'],
        ownerPhone = json['ownerPhone'],
        location = json['location'],
        ownerName = json['ownerName'],
        id = json['id'],
        categories = json['categories'],
        petAgeTime = json['petAgeTime'],
        description = json['description'],
        petPrice = json['petPrice'],
        isDoubleTapped = false,
        isAccepted = false,
        userImage = json['userImage']; // Initialize isDoubleTapped here

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petName'] = this.petName;
    data['petWeight'] = this.petWeight;
    data['petAge'] = this.petAge;
    data['gender'] = this.gender;
    data['petBread'] = this.petBreed;
    data['imageUrl'] = this.imageUrl;
    data['ownerPhone'] = this.ownerPhone;
    data['location'] = this.location;
    data['ownerName'] = this.ownerName;
    data['description'] = this.description;
    data['id'] = this.id;
    data['petAgeTime'] = this.petAgeTime;
    data['petPrice'] = this.petPrice;
    data['categories'] = this.categories;
    data['userImage'] = this.userImage;

    return data;
  }
   static List<Adopt> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Adopt.fromJson(json)).toList();
  }
}
