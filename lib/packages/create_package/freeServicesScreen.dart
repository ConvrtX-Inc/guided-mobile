// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/packagePhotosScreen.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';

class FreeServicesScreen extends StatefulWidget {
  const FreeServicesScreen({Key? key}) : super(key: key);

  @override
  _FreeServicesScreenState createState() => _FreeServicesScreenState();
}

class _FreeServicesScreenState extends State<FreeServicesScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _chosenServices(String text) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          width: 150,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ConstantHelpers.grey,
                spreadRadius: 0.8,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                  ))
            ],
          ),
        ),
      );
    }

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
                  HeaderText.headerText(
                      'What are the free services do you offer?'),
                  ConstantHelpers.spacing30,
                  SubHeaderText.subHeaderText(
                      'These are just the services guests usually expect, but you can add even more after you publish.'),
                  ConstantHelpers.spacing20,
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      hintText: "Add new free services",
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
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Maximum of 10 keywords can add",
                      style: TextStyle(
                        color: ConstantHelpers.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  Row(
                    children: [
                      _chosenServices("Transport"),
                      _chosenServices("Breakfast"),
                    ],
                  ),
                  ConstantHelpers.spacing20,
                  Row(
                    children: [
                      _chosenServices("Breakfast"),
                      _chosenServices("Water"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PackagePhotosScreen()),
              );
            },
            child: const Text(
              'Next',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      ),
    );
  }
}
