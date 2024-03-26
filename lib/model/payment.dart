class Payment {
  int? id;
  String? productName;
  String? price;
  String? userName;
  String? email;

  Payment({this.productName, this.price, this.userName, this.email});

  Payment.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    userName = json['userName'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
  static List<Payment> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Payment.fromJson(json)).toList();
  }
}