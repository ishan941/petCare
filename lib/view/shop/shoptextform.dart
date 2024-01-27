import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';

class ShopTextForm extends StatelessWidget {
  final String? labelText, hintText;
  final void Function(String)? onChanged;
 final  String? Function(String?)? validator;
 final Widget? prefixIcon;

   ShopTextForm({super.key,
  this.labelText,
  this.onChanged,
  this.validator,
  this.hintText,
  this.prefixIcon
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
    prefixIcon: prefixIcon,
          labelText: labelText,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
