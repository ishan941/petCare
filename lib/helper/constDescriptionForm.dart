import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';

class DescriptionTextForm extends StatelessWidget {
  final String? labelText, hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final double? height;

  DescriptionTextForm({
    Key? key,
    this.labelText,
    this.onChanged,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtil.BackGroundColorColor,
      child: Container(
        height: height,
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            alignLabelWithHint: true, 
            // Aligns label with the hint text when it floats to the top
            contentPadding: EdgeInsets.only(top: 16.0, bottom: 106.0, left: 16.0, right: 16.0), // Adjust the padding as needed
            hintText: hintText,
            prefixIcon: prefixIcon,
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
