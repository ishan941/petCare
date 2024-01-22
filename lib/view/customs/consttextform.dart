import 'package:flutter/material.dart';

class ConstTextForm extends StatelessWidget {
  String? Function(String?)? validator;
  String? labelText, hintText;
  Widget? prefixIcon, suffixIcon;
  void Function(String)? onChanged;

  ConstTextForm({
    super.key,
    this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: (Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 3,
              color: Colors.grey.withOpacity(1),
              offset: Offset(2, 4),
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
                borderRadius: BorderRadius.circular(10)),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      )),
    );
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
          