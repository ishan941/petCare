import 'package:flutter/material.dart';

class FormForShop extends StatefulWidget {
  const FormForShop({super.key});

  @override
  State<FormForShop> createState() => _FormForShopState();
}

class _FormForShopState extends State<FormForShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("FormForShop"),
    );
  }
}