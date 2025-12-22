
import 'package:flutter/material.dart';

class GetDivider extends StatelessWidget {
  const GetDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width/2.4,
            child: Divider(
              thickness: 2,
            ),
          ),
          Text(" or ",style: TextStyle(color: Colors.black26),),
          SizedBox(
            width: size.width/2.4,
            child: Divider(thickness: 2,)
          )
        ],
      ),
    );
  }
}

