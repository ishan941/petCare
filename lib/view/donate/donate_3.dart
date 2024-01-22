import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';
import 'package:provider/provider.dart';

class DonateThird extends StatefulWidget {
  const DonateThird({super.key});

  @override
  State<DonateThird> createState() => _DonateThirdState();
}

class _DonateThirdState extends State<DonateThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(File(adoptProvider.image!.path),
                    fit: BoxFit.cover,
                    ),
                  ),
                  Text(adoptProvider.petname?? ""),
                   Text(adoptProvider.petweight?? ""),
                    Text(adoptProvider.petbread?? ""),
                     Text(adoptProvider.phone?? ""),
                      Text(adoptProvider.petage?? ""),
                       Text(adoptProvider.name?? ""),
                        Text(adoptProvider.phone?? ""),
                         Text(adoptProvider.location?? ""),
                  
                  ElevatedButton(
                    onPressed: (){
                    adoptProvider.sendAdoptValueToFireBase(context);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

                  }, child: Text(submitStr))
                ],
              ),
            )
            
          ],
        ),
      ),

    );
  }
}