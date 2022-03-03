// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/screens/packages/create_package/create_package_screen.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';

/// Package List Screen
class PackageList extends StatefulWidget {
  /// Constructor
  const PackageList({Key? key}) : super(key: key);

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            // FutureBuilder<PackageModelData>(
            //   future: APIServices().getPackageData(),
            //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //     Widget _displayWidget;
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.waiting:
            //         _displayWidget = const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //         break;
            //       default:
            //         if (snapshot.hasError) {
            //           _displayWidget = Center(
            //               child: APIMessageDisplay(
            //             message: 'Result: ${snapshot.error}',
            //           ));
            //         } else {
            //           _displayWidget = buildAdvertisementResult(snapshot.data!);
            //         }
            //     }
            //     return _displayWidget;
            //   },
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chateauGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const CreatePackageScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
