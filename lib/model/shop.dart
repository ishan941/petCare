class Shop {
  String? product;
  String? condition;
  String? location;
  String? images;
  String? description;
  String? price;
  String? negotiable;

  Shop(
      {this.product,
      this.condition,
      this.location,
      this.images,
      this.description,
      this.price,
      this.negotiable});

  Shop.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    condition = json['condition'];
    location = json['location'];
    images = json['images'];
    description = json['description'];
    price = json['price'];
    negotiable = json['negotiable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['condition'] = this.condition;
    data['location'] = this.location;
    data['images'] = this.images;
    data['description'] = this.description;
    data['price'] = this.price;
    data['negotiable'] = this.negotiable;
    return data;
  }
}