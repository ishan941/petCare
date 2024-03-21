import 'package:flutter/material.dart';
class CustomDropDown extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final List<String> itemlist;
  final void Function(dynamic)? onChanged;
  final String? value;
  final String? Function(String?)? validator;

  CustomDropDown({
    Key? key,
    required this.itemlist,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 100,
      items: itemlist.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      )).toList(),
      
      value: value,
      onChanged: onChanged,
      validator: validator,
      
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
