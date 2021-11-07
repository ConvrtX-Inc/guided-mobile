// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/packages/create_package/waiverScreen.dart';

class PackageSummaryScreen extends StatefulWidget {
  const PackageSummaryScreen({Key? key}) : super(key: key);

  @override
  _PackageSummaryScreenState createState() => _PackageSummaryScreenState();
}

class _PackageSummaryScreenState extends State<PackageSummaryScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    _widgetMainActivity() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Activities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Campaign'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Hiking'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Hunt'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _widgetSubActivity() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Sub Activities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Campaign'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Hunt'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _widgetPackageNameDescription() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Package name & Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Sample name goes here'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Sample description goes here to exlpain about your package desils. Sample description goes here to exlpain about your package desils. '),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _numberOfTraveler() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Number of Traveler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('5 tourists'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _currentLocation() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Current Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Country, Street'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('State, City'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Zip Code'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _locationOfPackage() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'location goes here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Location goes here'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Sample description goes here to exlpain about your package desils. Sample description goes here to exlpain about your package desils. '),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _offeredAmenities() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Offered Amenities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Transport'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Breakfast'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Water'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _attachedPhotos() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Attached Photos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sample",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sample",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sample",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _basePrice() {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Base Price 100',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Base Price 100',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: ConstantHelpers.primaryGreen,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
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
                  HeaderText.headerText('Summary'),
                  ConstantHelpers.spacing30,
                  _widgetMainActivity(),
                  ConstantHelpers.spacing15,
                  _widgetSubActivity(),
                  ConstantHelpers.spacing15,
                  _widgetPackageNameDescription(),
                  ConstantHelpers.spacing15,
                  _numberOfTraveler(),
                  ConstantHelpers.spacing15,
                  _currentLocation(),
                  ConstantHelpers.spacing15,
                  _locationOfPackage(),
                  ConstantHelpers.spacing15,
                  _offeredAmenities(),
                  ConstantHelpers.spacing15,
                  _attachedPhotos(),
                  ConstantHelpers.spacing15,
                  _basePrice(),
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
                MaterialPageRoute(builder: (context) => const WaiverScreen()),
              );
            },
            child: const Text(
              'Submit',
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
