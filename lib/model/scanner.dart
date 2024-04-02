class Scanner {
  List<String>? symptoms;

  Scanner({this.symptoms});

  Scanner.fromJson(Map<String, dynamic> json) {
    symptoms =
        json['symptoms'] != null ? List<String>.from(json['symptoms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptoms'] = this.symptoms;
    return data;
  }

  static List<Scanner> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Scanner.fromJson(json)).toList();
  }
}
class DiseaseModel {
  String? disease;

  DiseaseModel({this.disease});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease'] = this.disease;
    return data;
  }

  static List<DiseaseModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => DiseaseModel.fromJson(json)).toList();
  }
}
