class Donate {
  String? image;
  String? category;
  String? petName;
  String? breed;
  int? contact;
  String? location;
  double? petWeight;
  int? petAge;
  String? petGender;
  String? description;
  int? lifeSpan;
  String? domain;
  String? family;
  String? kingdom;
  String? orderrs;
  String? phylum;
  int? price;

  Donate(
      {this.image,
      this.category,
      this.petName,
      this.breed,
      this.contact,
      this.location,
      this.petWeight,
      this.petAge,
      this.petGender,
      this.description,
      this.lifeSpan,
      this.domain,
      this.family,
      this.kingdom,
      this.orderrs,
      this.phylum,
      this.price});

  Donate.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    category = json['category'];
    petName = json['petName'];
    breed = json['breed'];
    contact = json['contact'];
    location = json['location'];
    petWeight = json['petWeight'];
    petAge = json['petAge'];
    petGender = json['petGender'];
    description = json['Description'];
    lifeSpan = json['lifeSpan'];
    domain = json['domain'];
    family = json['family'];
    kingdom = json['kingdom'];
    orderrs = json['orderrs'];
    phylum = json['phylum'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['category'] = this.category;
    data['petName'] = this.petName;
    data['breed'] = this.breed;
    data['contact'] = this.contact;
    data['location'] = this.location;
    data['petWeight'] = this.petWeight;
    data['petAge'] = this.petAge;
    data['petGender'] = this.petGender;
    data['Description'] = this.description;
    data['lifeSpan'] = this.lifeSpan;
    data['domain'] = this.domain;
    data['family'] = this.family;
    data['kingdom'] = this.kingdom;
    data['orderrs'] = this.orderrs;
    data['phylum'] = this.phylum;
    data['price'] = this.price;
    return data;
  }
}
