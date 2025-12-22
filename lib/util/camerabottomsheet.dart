import 'dart:math';

import 'package:biddy_driver/constant/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraBottomsheet{
 late XFile pickedImage;

 Future<XFile> show(BuildContext context)async{
  await bottomSheet(context);

   return pickedImage;

 }

   bottomSheet(BuildContext context)async {
   await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 30,),
                Text(TextConstant.select_camera_option,style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 20,),
                ListTile(
                  leading: new Icon(Icons.camera_alt_outlined),
                  title: new Text(TextConstant.camera),
                  onTap: () async{
                    pickedImage=await  callCamera();
                    Navigator.pop(context);

                  },
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(TextConstant.gallery),
                  onTap: () async{
                    pickedImage= await callGallery();
                    Navigator.pop(context);
                  },
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  
                ),

                SizedBox(height: 30,),

              ],
            ),
          );
        });
  }

   Future<XFile>  callCamera()async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile!;
  }

   Future<XFile> callGallery()async {
     final ImagePicker _picker = ImagePicker();
     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      return pickedFile!;
   }


}