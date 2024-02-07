
class SignUp {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? favourite;
  String? id;

  SignUp({this.name, this.phone, this.email, this.password,this.favourite,this.id});

  SignUp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    favourite=json['favourite'];
    id=json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['favourite']=this.favourite;
    data['id']=this.id;
    return data;
  }
}

