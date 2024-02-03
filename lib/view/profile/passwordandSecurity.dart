import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';

class PasswordAndSecurity extends StatefulWidget {
  const PasswordAndSecurity({super.key});

  @override
  State<PasswordAndSecurity> createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}