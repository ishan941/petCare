class Ads {
  String? adsImage;
  int? id;

  Ads({this.adsImage,this.id});

  Ads.fromJson(Map<String, dynamic> json) {
    adsImage = json['adsImage'];
    id=json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adsImage'] = this.adsImage;
    data['id']=this.id;
    return data;
  }
  static List<Ads> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Ads.fromJson(json)).toList();
  }
}
