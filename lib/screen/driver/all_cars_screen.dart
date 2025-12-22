import 'package:biddy_driver/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import 'car_info_screen.dart';

class AllCarsScreen extends StatelessWidget {
  const AllCarsScreen({Key? key}) : super(key: key);
  static const routeName = '/all-cars-screen';

  static const color = const Color(0xffB8AAA3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Cars'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.direverCar);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            children: [ Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: Image.asset('assets/car.jpg'),
                      title: Text(
                        'Swift',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "MH 09 EG 0909",
                        style: TextStyle(color: color),
                      ),
                      trailing:  IconButton(
                              icon: Icon(Icons.delete),
                              color: color,
                              onPressed: () async {
                                try {
                                  bool confirm = await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      title: Text('Are you sure?'),
                                      content: Text(
                                        'Do you want to delete this car?',
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            Navigator.of(ctx).pop(true);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm) {
                                   // await driver.deleteCar(car.id!);
                                  } else {
                                    return;
                                  }
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        error.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.fromLTRB(
                                        10.0,
                                        5.0,
                                        10.0,
                                        10.0,
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  );
                                }
                              },
                            ),
                    ),
                  ),
        ]
                )

          ),
        ),
      );
  }
}
