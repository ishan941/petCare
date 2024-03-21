class OurService {
  int? id;
  String? cpImage;
  String? ppImage;
  String? service;

  OurService({
    this.cpImage,
    this.ppImage,
    this.service,
    this.id,
  });

  OurService.fromJson(Map<String, dynamic> json) {
    cpImage = json['cpImage'];
    ppImage = json['ppImage'];
    service = json['service'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpImage'] = this.cpImage;
    data['ppImage'] = this.ppImage;
    data['service'] = this.service;
    data['id'] = this.id;
    return data;
  }

  static List<OurService> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => OurService.fromJson(json)).toList();
  }
}
