
class SignUp {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? favourite;
  String? id;
  String? shopCart;
  String? myProfile;
  String? userImage;

  SignUp({this.name,this.userImage, this.shopCart,this.myProfile, this.phone, this.email, this.password,this.favourite,this.id});

  SignUp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    favourite=json['favourite'];
    shopCart=json['shopCart'];
    id=json["id"];
    myProfile=json["myProfile"];
    userImage=json["userImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['favourite']=this.favourite;
    data['shopCart']=this.shopCart;
    data['id']=this.id;
    data['myProfile']=this.myProfile;
    data['userImage']=this.userImage;
    return data;
  }
}

