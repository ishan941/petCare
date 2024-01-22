import 'package:flutter/material.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/shop_provider.dart';

import 'package:project_petcare/view/ourservice/service_form.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => 
        Consumer<ShopProvider>(
          builder: (context, shopProvider, child) => SafeArea(
            child: Column(
              children: [
               IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceForm()));
               }, icon: Icon(Icons.add_home_work_outlined) ),
               Container(
                height: 500,
                color: Colors.red,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: ourServiceProvider.dashServiceList.length,
                    itemBuilder: (context, index)=>
                  Container(
                    color: Colors.white,
                    height: 100,
                    child: Image.network(ourServiceProvider.dashServiceList[index].cpImage?? ""),
                  )
                  ),
                ),
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
