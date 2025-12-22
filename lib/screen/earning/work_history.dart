import 'package:biddy_driver/provider/work_history_provider.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkHIstory extends StatefulWidget {
  const WorkHIstory({super.key});

  @override
  State<WorkHIstory> createState() => _WorkHIstoryState();
}

class _WorkHIstoryState extends State<WorkHIstory> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WorkHistoryProvider("Ideal"),
      builder: (context, child) => _buildPage(context),
    );
  }

  _buildPage(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: AppButton(
              buttonTitle: "Continue",
              onClick: () {

              },
              enbale: true),
        ),
        appBar: ApplicationAppBar().commonAppBar(context, "Work History"),
        body: Container(),
      );
  }
}
