import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';

class Popular_medicalService extends StatefulWidget {
  const Popular_medicalService({super.key});

  @override
  State<Popular_medicalService> createState() => _Popular_medicalServiceState();
}

class _Popular_medicalServiceState extends State<Popular_medicalService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: ColorUtil.BackGroundColorColor,

      body: Column(
        children: [
          Text("Popular")
        ],
      ),
    );
  }
}