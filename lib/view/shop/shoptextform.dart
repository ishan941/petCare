import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';

class ShopTextForm extends StatelessWidget {
  String? labelText, hintText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

   ShopTextForm({super.key,
  this.labelText,
  this.onChanged,
  this.validator,
  this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      
    
    color: ColorUtil.BackGroundColorColor,     
      child: TextFormField(
        onChanged:onChanged ,
        validator: validator,

        decoration: InputDecoration(
    hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
