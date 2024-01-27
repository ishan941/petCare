import 'package:flutter/material.dart';

class Test_DropDown extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final List<String> itemlist;
  final void Function(dynamic)? onChanged;
  final String? value;
  final String? Function(String?)? validator;

  Test_DropDown({
    Key? key,
    required this.itemlist,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.value,
    this.validator,
  });

  @override
  State<Test_DropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<Test_DropDown> {
  late List<String> filterdList;
  @override
  void initState() {
    filterdList = widget.itemlist;
    super.initState();
  }

  void _filteredList(String query) {
    setState(() {
      filterdList = widget.itemlist
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: _filteredList,
          decoration: InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        DropdownButtonFormField(
          elevation: 100,
          items: filterdList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          value: widget.value,
          onChanged: widget.onChanged,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
