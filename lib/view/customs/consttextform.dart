import 'package:flutter/material.dart';

class ConstTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? labelText, hintText;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  ConstTextForm({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
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
          controller: controller,
        ),
      )
    );
  }
}

