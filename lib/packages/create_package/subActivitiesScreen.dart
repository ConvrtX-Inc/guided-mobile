// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/badgesModel.dart';
import 'package:guided/packages/create_package/createPackageScreen.dart';
import 'package:guided/packages/create_package/packageInfoScreen.dart';

class SubActivitiesScreen extends StatefulWidget {
  final BadgesModel mainActivity;

  const SubActivitiesScreen({Key? key, required this.mainActivity})
      : super(key: key);

  @override
  _SubActivitiesScreenState createState() => _SubActivitiesScreenState();
}

class _SubActivitiesScreenState extends State<SubActivitiesScreen> {
  bool showMainActivityChoices = false;
  bool showSubActivityChoices = false;
  dynamic mainActivity;
  dynamic subActivities = [];

  @override
  void initState() {
    super.initState();

    mainActivity = widget.mainActivity;
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
        width: 25,
      ),
      title: Text(
        badges.title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  _chosenMainActivity(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 25,
      ),
      title: Text(
        badges.title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  _choicesGridSubActivity() {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children: List.generate(ConstantHelpers.badges.length, (index) {
        return SizedBox(
          height: 10,
          width: 100,
          child: _choicesSubActivities(ConstantHelpers.badges[index]),
        );
      }),
    );
  }

  _choicesSubActivities(BadgesModel badges) {
    return ListTile(
      onTap: () {
        setState(() {
          mainActivity = badges;
        });
      },
      minLeadingWidth: 20,
      leading: Image.asset(
        badges.imageUrl,
        width: 25,
      ),
      title: Text(badges.title),
    );
  }

  _chosenSubActivities(BadgesModel badges) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            setState(() {
              mainActivity = badges;
            });
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
                color: HexColor("#E3E3E3").withOpacity(0.8),
                border: Border.all(
                  color: HexColor("#E3E3E3").withOpacity(0.8),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Container(
                          width: 70,
                          height: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              badges.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
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
                  Positioned(
                    left: 0,
                    bottom: 2,
                    child: Image.asset(
                      badges.imageUrl,
                      width: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                        child: _chosenMainActivity(mainActivity),
                      ),
                const SizedBox(
                  width: 150,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
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

  _subActivityDropdown(double width) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showSubActivityChoices = showSubActivityChoices ? false : true;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mainActivity == null
                    ? const SizedBox(
                        width: 300,
                        height: 100,
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: width / 1.4,
                          height: 55,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                _chosenSubActivities(mainActivity),
                                _chosenSubActivities(mainActivity),
                                _chosenSubActivities(mainActivity),
                              ]),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(8.0),
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
        showSubActivityChoices
            ? Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 200,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 20),
                    child: _choicesGridSubActivity(),
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
                        'What kind of sub activities should be included'),
                    ConstantHelpers.spacing30,
                    _mainActivityDropdown(width),
                    ConstantHelpers.spacing30,
                    const Text(
                      "Add Multiple Sub Activities",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    ConstantHelpers.spacing15,
                    _subActivityDropdown(width),
                    ConstantHelpers.spacing30,
                    SizedBox(
                      width: width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Temp set to different screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PackageInfoScreen()),
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
      ),
    );
  }
}
