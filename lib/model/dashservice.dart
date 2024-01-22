class DashService {
  String? cpImage;
  String? ppImage;
  String? service;

  DashService({this.cpImage, this.ppImage, this.service});

  DashService.fromJson(Map<String, dynamic> json) {
    cpImage = json['cpImage'];
    ppImage = json['ppImage'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpImage'] = this.cpImage;
    data['ppImage'] = this.ppImage;
    data['service'] = this.service;
    return data;
  }
}