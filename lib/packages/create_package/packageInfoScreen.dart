// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';

import 'numberOfTravelersScreen.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({Key? key}) : super(key: key);

  @override
  _PackageInfoScreenState createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.headerText('Package Name & Description'),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Package Name",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "My Package",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Cover Photo",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing15,
                  Container(
                    width: width,
                    height: 87,
                    color: HexColor("#F0F0F0"),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 30, 20),
                      child: Image.asset(
                        "assets/images/imageprev.png",
                        height: 36,
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing30,
                  ConstantHelpers.spacing30,
                  SizedBox(
                    width: width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NumberOfTravelersScreen()),
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: HexColor("#C4C4C4"),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        primary: ConstantHelpers.primaryGreen,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
