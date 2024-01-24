import 'package:flutter/material.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => 
        Column(
          children: [
            Text("Form For Shop"),
            ShopTextForm(
              onChanged: (val){
                ourServiceProvider.shop = val;
              },
            )
            
          ],
        ),
      )
    );
  }
}