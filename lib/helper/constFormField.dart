

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:project_petcare/helper/constant.dart';

class ConstPhoneField extends StatelessWidget {
  FocusNode? focusNode;
  void Function(PhoneNumber)? onChanged;
  ConstPhoneField({super.key, this.focusNode, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      child: FlutterPhoneNumberField(
        focusNode: focusNode,
        initialCountryCode: "NP",
        pickerDialogStyle: PickerDialogStyle(
          countryFlagStyle: const TextStyle(fontSize: 17),
        ),
        decoration: InputDecoration(
          hintText: 'Phone Number',
          border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(10)),
        ),
        languageCode: "NP",
        onChanged: onChanged,
        onCountryChanged: (country) {
          if (kDebugMode) {
            print('Country changed to: ${country.name}');
          }
        },
      ),
    );
  }
}
class ConstElevated extends StatelessWidget {
   Widget? child;
   void Function()? onPressed;
   ConstElevated({super.key,
  required this.child,
  required this.onPressed,


   });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width*.9,
        color: ColorUtil.primaryColor,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child
          
        ),
      ),
    );
  }
}
