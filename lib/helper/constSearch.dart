import 'package:flutter/material.dart';

class ConstSearch extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? labelText, hintText;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  

  ConstSearch({
    super.key,
    this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    
  });

  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        
      ),
    ));
  }
}

//   labelText: labelText,
          //   hintText: hintText,
          //     filled: true,
          //   fillColor: Colors.white,
          //   prefixIcon: prefixIcon,
          //   suffixIcon: suffixIcon,
          //   border: OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //     borderRadius: BorderRadius.circular(10)
          //   ),
            
          // ),
          // validator: validator,
          // onChanged: onChanged,
          