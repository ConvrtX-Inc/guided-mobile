import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/slideshow.dart';
import 'package:guided/helpers/constant.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_add.dart';

class OutfitterList extends StatefulWidget {
  const OutfitterList({Key? key}) : super(key: key);

  @override
  _OutfitterListState createState() => _OutfitterListState();
}

class _OutfitterListState extends State<OutfitterList> {

  final TextStyle txtStyle = TextStyle(
    color: Colors.black,
    fontFamily: ConstantHelpers.fontGilroy,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  final TextStyle dateStyle = TextStyle(
      color: ConstantHelpers.osloGrey,
      fontFamily: ConstantHelpers.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12
  );

  final TextStyle descrStyle = TextStyle(
      color: Colors.black,
      fontFamily: ConstantHelpers.fontGilroy,
      fontSize: 14,
      height: 2
  );

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => OutfitterAdd(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SlideShow(),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ConstantHelpers.travelVest,
                        style: txtStyle,
                      ),
                      Text(
                        '\$45',
                        style: txtStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                        color: ConstantHelpers.osloGrey,
                      ),
                      SizedBox(width: 5,),
                      Text(
                          ConstantHelpers.constDate1,
                          style: dateStyle
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    ConstantHelpers.loremIpsum,
                    style: descrStyle,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ConstantHelpers.lightRed),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                      color: Colors.red)))),
                      child: Text(
                        ConstantHelpers.visitShop,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(ConstantHelpers.assetSample2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ConstantHelpers.hikingShoes,
                        style: txtStyle,
                      ),
                      Text(
                        '\$63',
                        style: txtStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                        color: ConstantHelpers.osloGrey,
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        ConstantHelpers.constDate1,
                        style: dateStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    ConstantHelpers.loremIpsum,
                    style: descrStyle,
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
