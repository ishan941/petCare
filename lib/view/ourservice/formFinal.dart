import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';
import 'package:provider/provider.dart';

class FormFinalProfession extends StatefulWidget {
  const FormFinalProfession({super.key});

  @override
  State<FormFinalProfession> createState() => _FormFinalProfessionState();
}

class _FormFinalProfessionState extends State<FormFinalProfession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => 
         Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Image.file(File(ourServiceProvider.profilePicture!.path),
              fit: BoxFit.cover,
              
              ),
            
            ),
            Text(ourServiceProvider.fullname ?? ""),
            Text(ourServiceProvider.profession ?? ""),
            Text(ourServiceProvider.email ?? ""),
            Text(ourServiceProvider.fullname ?? ""),
            ElevatedButton(onPressed: (){
              ourServiceProvider.sendProfessionValueToFireBase(context);
             if(ourServiceProvider.professionUtil == StatusUtil.success){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
             }else{
              Helper.snackBar("Incorrect", context);
             }
            }, child: child)

          ],
          
        ),
      ) ,
    );
  }
}