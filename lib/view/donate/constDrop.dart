import 'package:flutter/material.dart';

class AppDropdownInput extends StatelessWidget {
  final String hintText;
  final List options;
  final  value;
  final String? labelText;
  final String? getLabel;
 final void Function(Object?)? onChanged;



  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.labelText,
   required this.getLabel,
   required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (context) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(getLabel??(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}