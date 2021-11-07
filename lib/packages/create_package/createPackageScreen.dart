// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/subActivitiesScreen.dart';

class CreatePackageScreen extends StatefulWidget {
  const CreatePackageScreen({Key? key}) : super(key: key);

  @override
  _CreatePackageScreenState createState() => _CreatePackageScreenState();
}

class _CreatePackageScreenState extends State<CreatePackageScreen> {
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  dynamic mainActivity;

  @override
  void initState() {
    super.initState();
  }

  _choicesGridMainActivity() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(ConstantHelpers.badges.length, (index) {
        return SizedBox(
          height: 10,
          width: 100,
          child: _choicesMainActivity(ConstantHelpers.badges[index]),
        );
      }),
    );
  }

  _choicesMainActivity(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 30,
      ),
      title: Text(badges.title),
    );
  }

  _mainActivityDropdown(double width) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showMainActivityChoices = showMainActivityChoices ? false : true;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: ConstantHelpers.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            width: width,
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                mainActivity == null
                    ? const SizedBox(
                        width: 150,
                        height: 100,
                      )
                    : SizedBox(
                        width: 150,
                        height: 100,
                        child: _choicesMainActivity(mainActivity),
                      ),
                const SizedBox(
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          mainActivity = null;
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                      )),
                ),
              ],
            ),
          ),
        ),
        showMainActivityChoices
            ? Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 200,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 20),
                    child: _choicesGridMainActivity(),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
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
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              showMainActivityChoices = false;
              showSubActivityChoices = false;
            });
          },
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
                        'Hi John,\nLets Get Started To Build Your Tour Package'),
                    ConstantHelpers.spacing20,
                    const Text(
                      "Please Select Badget That Best Represent Your Interests",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GilRoy',
                        fontSize: 16,
                      ),
                    ),
                    ConstantHelpers.spacing20,
                    ConstantHelpers.spacing20,
                    _mainActivityDropdown(width),
                    ConstantHelpers.spacing30,
                    Container(
                      color: HexColor("#CCFFD5"),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 30, 20),
                        child: Text(
                          "Discovery Badge will let you discover unique activities hosted by different   local guides and organizations",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "GilRoy",
                            color: ConstantHelpers.primaryGreen,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    ConstantHelpers.spacing30,
                    SizedBox(
                      width: width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Temp set to different screen

                          if (mainActivity != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubActivitiesScreen(
                                        mainActivity: mainActivity,
                                      )),
                            );
                          }
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
      ),
    );
  }
}
