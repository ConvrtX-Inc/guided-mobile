// ignore_for_file: file_names
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/packages/create_package/packagePriceScreen.dart';
import 'package:guided/packages/create_package/packageSummaryScreen.dart';

class WaiverScreen extends StatefulWidget {
  const WaiverScreen({Key? key}) : super(key: key);

  @override
  _WaiverScreenState createState() => _WaiverScreenState();
}

class _WaiverScreenState extends State<WaiverScreen> {
  bool isChecked = false;

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
                  HeaderText.headerText('Waiver screen'),
                  ConstantHelpers.spacing30,
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                          ConstantHelpers.spacing15,
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed venenatis volutpat risus vitae iaculis. Duis laoreet molestie efficitur. Aenean arcu velit, vestibulum a libero vel, sollicitudin posuere dui. ',
                            style: TextStyle(
                              fontSize: 16,
                              color: HexColor("979B9B"),
                            ),
                          ),
                          ConstantHelpers.spacing20,
                        ],
                      ),
                    ),
                  ),
                  ConstantHelpers.spacing20,
                  Row(
                    children: [
                      CustomCheckBox(
                        value: isChecked,
                        shouldShowBorder: true,
                        borderColor: ConstantHelpers.grey,
                        checkedFillColor: ConstantHelpers.primaryGreen,
                        borderRadius: 8,
                        borderWidth: 1,
                        checkBoxSize: 22,
                        onChanged: (val) {
                          //do your stuff here
                          setState(() {
                            isChecked = val;
                            print(isChecked);
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I agree with local laws and taxes terms',
                          style: TextStyle(
                            color: ConstantHelpers.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
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
                    builder: (context) => const PackageSummaryScreen()),
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
