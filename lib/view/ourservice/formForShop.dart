import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/ourservice/formFinal.dart';
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
     
      body: Consumer<OurServiceProvider>(
      builder: (context, ourServiceProvider, child) => 
      Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new)),
                Text(ourServiceProvider.profession!, style: subTitleText,),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ShopTextForm(
              hintText: "Your Shop Name",
              onChanged: (val) {
                ourServiceProvider.shopName = val;
                
              },
            ),
            
          ),SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ShopTextForm(
              hintText: "Your Shop Location",
              onChanged: (val) {
                ourServiceProvider.shopLocation = val;
                
              },
            ),
            
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> FormFinalProfession()));
            
          }, child: Text(submitStr)),
         
        ],
       ),
     ),
    );
  }
}