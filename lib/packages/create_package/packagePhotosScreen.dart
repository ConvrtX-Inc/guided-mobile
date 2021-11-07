// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/guideRulesScreen.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';

class PackagePhotosScreen extends StatefulWidget {
  const PackagePhotosScreen({Key? key}) : super(key: key);

  @override
  _PackagePhotosScreenState createState() => _PackagePhotosScreenState();
}

class _PackagePhotosScreenState extends State<PackagePhotosScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _imagePreview() {
      return Stack(
        children: [
          Container(
            width: 100,
            height: 87,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor("#F0F0F0"),
              boxShadow: [
                BoxShadow(
                  color: HexColor("#F0F0F0"),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/imageprev.png",
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
          )
        ],
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
                      'Upload photos of your service package'),
                  ConstantHelpers.spacing30,
                  SubHeaderText.subHeaderText(
                      'Upload at least one photo to publish your package overview. You can always add or edit your photos later.'),
                  ConstantHelpers.spacing20,
                  const Text(
                    "Destination 1",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  ConstantHelpers.spacing20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _imagePreview(),
                      _imagePreview(),
                      _imagePreview(),
                    ],
                  ),
                  ConstantHelpers.spacing20,
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      hintText: "Place Name",
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
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
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
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Add New Destination",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ConstantHelpers.primaryGreen,
                          boxShadow: [
                            BoxShadow(
                              color: ConstantHelpers.primaryGreen,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      ConstantHelpers.spacing20,
                    ],
                  )
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
                    builder: (context) => const GuideRulesScreen()),
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
