class Categories {
  String? categoriesImage;
  String? categoriesName;
  int? id;

  Categories({this.categoriesImage, this.categoriesName, this.id});

  Categories.fromJson(Map<String, dynamic> json) {
    categoriesImage = json['categoriesImage'];
    categoriesName = json['categoriesName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoriesImage'] = this.categoriesImage;
    data['categoriesName'] = this.categoriesName;
    data['id'] = this.id;
    return data;
  }
   static List<Categories> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Categories.fromJson(json)).toList();
}}
