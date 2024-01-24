import 'package:flutter/material.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class FormForTrainner extends StatefulWidget {
  const FormForTrainner({super.key});

  @override
  State<FormForTrainner> createState() => _FormForTrainnerState();
}

class _FormForTrainnerState extends State<FormForTrainner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => 
        Column(
          children: [
            Text("Form For Trainner"),
            ShopTextForm(
              onChanged: (val){
                ourServiceProvider.trainner = val;
              },
            )
            
          ],
        ),
      )
    );
  }
}