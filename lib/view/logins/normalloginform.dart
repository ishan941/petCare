import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';

class NormalForm extends StatefulWidget {
  const NormalForm({super.key});

  @override
  State<NormalForm> createState() => _NormalFormState();
}

class _NormalFormState extends State<NormalForm> {
  String? email, password,token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            SizedBox(
              height: 100,
            ),
            Text('Normla Form'),
            SizedBox(
              height: 20,
            ),
            ShopTextForm(
              hintText: "Email",
              onChanged: (value){
                email = value;

              },
            ),
            SizedBox(
              height: 20,
            ),
            ShopTextForm(
              hintText: "password",
              onChanged: (value){
                password = value;

              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              sendValue();

            }, child: Text("Login"))
          ]),
        ),
      ),
    );
  }
  sendValue()async{
  

final dio = Dio();



await getFCMToken().then((value)async {
    var json={
"email":email,
"password":password,
"username":"test",
"role":"user",
"name":"ishan",
"gender":"male",
"fcmToken":value

  };
  print("token $value");
final response = await dio.post('https://2864-2400-1a00-b060-2cf7-14b4-3214-6947-b33d.ngrok-free.app/api/v1/createUser',data: json);
  print(response);

});
  



  }

    Future<String> getFCMToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken ?? "";
  }
}
