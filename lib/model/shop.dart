class Shop {
  int? id;
  String? product;
  String? condition;
  String? location;
  String? images;
  String? description;
  String? price;
  String? negotiable;
  String? type;
  String? userPhone;
  bool isSold;
  bool isFavourite;
  bool isCart;

  Shop({
    this.id,
    this.product,
    this.condition,
    this.location,
    this.images,
    this.description,
    this.price,
    this.negotiable,
    this.type,
    this.userPhone,
    this.isSold = false, // Initialize isSold here
    this.isFavourite = false,
    this.isCart = false // Initialize isSold here
  });

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product = json['product'],
        condition = json['condition'],
        location = json['location'],
        images = json['images'],
        description = json['description'],
        price = json['price'],
        negotiable = json['negotiable'],
        type = json['type'],
        userPhone = json['userPhone'],
        isSold = json['isSold'] ?? false, // Initialize isSold here
        isFavourite = json['favourite'] ?? false, // Initialize isSold here
        isCart = json['cart'] ?? false; // Initialize isSold here

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product'] = product;
    data['condition'] = condition;
    data['location'] = location;
    data['images'] = images;
    data['description'] = description;
    data['price'] = price;
    data['negotiable'] = negotiable;
    data['userPhone'] = userPhone;
    data['type'] = type;
    data['sold'] = isSold;
    data['cart'] = isCart;
    data['favourite'] = isFavourite;
    return data;
  }

  static List<Shop> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Shop.fromJson(json)).toList();
  }
}
