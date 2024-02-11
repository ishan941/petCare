class MyPet {
  String? petName;
  String? dateOfBirth;
  String? petType;
  String? petBreed;
  String? petSex;
  String? petColor;
  String? description;

  MyPet(
      {this.petName,
      this.dateOfBirth,
      this.petType,
      this.petBreed,
      this.petSex,
      this.petColor,
      this.description});

  MyPet.fromJson(Map<String, dynamic> json) {
    petName = json['petName'];
    dateOfBirth = json['dateOfBirth'];
    petType = json['petType'];
    petBreed = json['petBreed'];
    petSex = json['petSex'];
    petColor = json['petColor'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petName'] = this.petName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['petType'] = this.petType;
    data['petBreed'] = this.petBreed;
    data['petSex'] = this.petSex;
    data['petColor'] = this.petColor;
    data['description'] = this.description;
    return data;
  }
}
