import 'dart:convert';

import 'package:equatable/equatable.dart';

class Shop extends Equatable{
  String? id;
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
      this.id,
      this.negotiable});

  Shop.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    condition = json['condition'];
    location = json['location'];
    images = json['images'];
    description = json['description'];
    price = json['price'];
    negotiable = json['negotiable'];
    id = json['id'];
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
    data['id'] = this.id;
    return data;
  }
  
@override
  List<Object?> get props => [product, id,condition,location,images,description,price,negotiable];
 
}