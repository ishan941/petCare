
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
final String? Function(String?)? validator;
final String? labelText, hintText;
final Widget? prefixIcon, suffixIcon;
final void Function(String)? onChanged;
 bool obscureText = false;


   CustomForm({super.key,
  this.validator,
  this.hintText,
  this.labelText,
  this.prefixIcon,
  this.suffixIcon,
  this.onChanged,
  this.obscureText= false
   
   
   });

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(6, 6),
            ),
          ],
        ),
        child: TextFormField(
          
          decoration: InputDecoration(
            
            
            
            labelText: labelText,
            hintText: hintText,
              filled: true,
            fillColor: Colors.white,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)
            ),
            
          ),
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          
        ),
      ),
    );
  }
}
