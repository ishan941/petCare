import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';
import 'package:project_petcare/view/ourservice/formFinal.dart';
import 'package:project_petcare/view/ourservice/profession.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class FormForMedical extends StatefulWidget {
  const FormForMedical({super.key});

  @override
  State<FormForMedical> createState() => _FormForMedicalState();
}

class _FormForMedicalState extends State<FormForMedical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
     body: Consumer<OurServiceProvider>(
      builder: (context, ourServiceProvider, child) => 
      Column(
        children: [
          Text("Medical Form"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ShopTextForm(
              onChanged: (val) {
                ourServiceProvider.medical = val;
                
              },
            ),
          ),
          ElevatedButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> FormFinalProfession()));
            
          }, child: Text(submitStr))
        ],
       ),
     ),
    );
  }
}