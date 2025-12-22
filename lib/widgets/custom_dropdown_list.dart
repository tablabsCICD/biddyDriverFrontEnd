import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/textview.dart';

class CustomDropdownList extends StatelessWidget {
  //final String controller;
  final String hintText;
  String selectedType;
  List<String> items;
  final TextInputType? textInputType;
  final int maxLine;
  final bool isPhoneNumber;
  final bool isValidator;
  final TextCapitalization capitalization;
  final IconData? iconData;
  final bool? obsecure;
  final bool? readOnly;
  final String? validatorMsg;
  Function? onTap;
  Function onChange;

  CustomDropdownList(
      {required this.hintText,
      required this.selectedType,
      required this.items,
      this.textInputType,
      this.maxLine = 1,
      this.validatorMsg,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.capitalization = TextCapitalization.none,
      this.iconData,
      this.obsecure,
      this.readOnly,
      this.onTap,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
          // height: 60,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.black54),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: DropdownButton<String>(
            value: selectedType,
              hint: TextView(
                title: hintText,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              borderRadius: new BorderRadius.circular(10.0),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              isDense: false,
              isExpanded: true,
              underline: Container(),
              style: TextStyle(
                decoration: TextDecoration.none, // Removes underline
              ),
              items: items
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Container(
                            // height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: TextView(
                              title: "$value",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ))
                  .toList(),
              onChanged: (String? value) {
                onChange(value);
              })),
    );
  }
}
