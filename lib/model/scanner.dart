
class Scanner {
  List<String>? symptoms;

  Scanner({this.symptoms});

  Scanner.fromJson(Map<String, dynamic> json) {
    symptoms = json['symptoms'] != null
        ? List<String>.from(json['symptoms'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptoms'] = this.symptoms;
    return data;
  }}