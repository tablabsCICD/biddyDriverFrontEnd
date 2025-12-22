import 'package:biddy_driver/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressDailog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BaseProvider("Ideal"),
      builder: (context, child) => _buildPage(context),
    );
  }
  _buildPage(BuildContext context) {
    return Consumer<BaseProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        body: provider.appState.compareTo("Ideal")==0? Container(): Center(child: CircularProgressIndicator(),),
      );
    });

  }

}