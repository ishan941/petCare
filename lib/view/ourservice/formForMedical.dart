import 'package:flutter/material.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';

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
     body: Column(
      children: [
        Text("Medical Form"),
        ShopTextForm(
          onChanged: (val) {
            
            
          },
        )
      ],
     ),
    );
  }
}