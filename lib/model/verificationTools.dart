class VerificationTools {
  String? userName;
  String? userPhone;
  String? userEmail;
  String? userImage;
  String? userLocation;

  VerificationTools(
      {this.userName,
      this.userPhone,
      this.userEmail,
      this.userImage,
      this.userLocation});

  VerificationTools.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userPhone = json['userPhone'];
    userEmail = json['userEmail'];
    userImage = json['userImage'];
    userLocation = json['userLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userPhone'] = this.userPhone;
    data['userEmail'] = this.userEmail;
    data['userImage'] = this.userImage;
    data['userLocation'] = this.userLocation;
    return data;
  }
}
