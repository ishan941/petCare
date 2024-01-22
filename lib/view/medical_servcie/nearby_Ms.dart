import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';

class Nearby_MedicalServices extends StatefulWidget {
  const Nearby_MedicalServices({super.key});

  @override
  State<Nearby_MedicalServices> createState() => _Nearby_MedicalServicesState();
}

class _Nearby_MedicalServicesState extends State<Nearby_MedicalServices> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Column(
        children: [
          Center(
            child: Text("Nearby"),
          )
        ],
      ),
    );
  }
}