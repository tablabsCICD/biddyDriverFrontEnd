import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDwonWidget extends StatefulWidget {

  final List<String>items;



   DropDwonWidget({super.key, required this.items});

  // @override
  // Widget build(BuildContext context) {
  //   return dropDwon();
  // }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DropdwonState();
  }

}
class _DropdwonState extends State<DropDwonWidget>{
   String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return dropDwon();
  }

  dropDwon() {
    return Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [

                  Expanded(
                    child: Text(
                      'widget.hintText',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(

                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                });
              },
              buttonStyleData: ButtonStyleData(
                // height: 50,
                // width: 160,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.white,
                ),
                elevation: 2,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.grey,

              ),
              dropdownStyleData: DropdownStyleData(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                elevation: 8,
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all<double>(6),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
        ));
  }

}