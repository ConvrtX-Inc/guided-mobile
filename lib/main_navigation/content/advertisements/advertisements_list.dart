import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/slideshow.dart';
import 'package:guided/helpers/constant.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_view.dart';

class AdvertisementList extends StatefulWidget {
  const AdvertisementList({Key? key}) : super(key: key);

  @override
  _AdvertisementListState createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList> {

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AdvertisementAdd(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AdvertisementView())
                            );
                          },
                          child: Image.asset(
                            ConstantHelpers.assetAds1,
                            fit: BoxFit.fitHeight,
                            height: 200,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ConstantHelpers.sportGloves,
                                style: ConstantHelpers.blackStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Image.asset(
                          ConstantHelpers.assetAds2,
                          fit: BoxFit.fitHeight,
                          height: 200,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ConstantHelpers.lakeCleaning,
                                style: ConstantHelpers.blackStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Image.asset(
                          ConstantHelpers.assetAds3,
                          fit: BoxFit.fitHeight,
                          height: 200,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ConstantHelpers.adventureTime,
                                style: ConstantHelpers.blackStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ConstantHelpers.green,
            onPressed: _settingModalBottomSheet,
            child: const Icon(Icons.add),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
