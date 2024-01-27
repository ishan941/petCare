class Categories {
  String? categoriesImage;
  String? categoriesName;

  Categories({this.categoriesImage, this.categoriesName});

  Categories.fromJson(Map<String, dynamic> json) {
    categoriesImage = json['categoriesImage'];
    categoriesName = json['categoriesName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoriesImage'] = this.categoriesImage;
    data['categoriesName'] = this.categoriesName;
    return data;
  }
}
