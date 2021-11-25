import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/outfitters/outfitters_edit.dart';

class OutfitterView extends StatefulWidget {
  const OutfitterView({Key? key}) : super(key: key);

  @override
  _OutfitterViewState createState() => _OutfitterViewState();
}

class _OutfitterViewState extends State<OutfitterView> {

  final TextStyle txtStyle = TextStyle(
    color: Colors.black,
    fontFamily: ConstantHelpers.fontGilroy,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  final TextStyle greyStyle = TextStyle(
      color: ConstantHelpers.osloGrey,
      fontFamily: ConstantHelpers.fontGilroy,
      fontWeight: FontWeight.w200,
      fontSize: 12
  );

  final TextStyle semiBoldStyle = TextStyle(
      color: Colors.black,
      fontFamily: ConstantHelpers.fontGilroy,
      fontWeight: FontWeight.w600,
      fontSize: 12
  );

  final TextStyle descrStyle = TextStyle(
      color: Colors.grey,
      fontFamily: ConstantHelpers.fontGilroy,
      fontSize: 14,
      height: 1.5
  );

  final TextStyle underlinedLinkStyle = TextStyle(
    color: ConstantHelpers.green,
    fontFamily: ConstantHelpers.fontGilroy,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(180),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Transform.scale(
                scale: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: ConstantHelpers.backarrowgrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Share Icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: ConstantHelpers.backarrowgrey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  /// Edit Icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: ConstantHelpers.backarrowgrey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                                MaterialPageRoute(builder: (context) => OutfitterEdit())
                              );
                          },
                        ),
                      ),
                    ),
                  ),
                  /// Delete icon
                  Transform.scale(
                    scale: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: ConstantHelpers.backarrowgrey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              flexibleSpace: Image(
                image: AssetImage(ConstantHelpers.assetSample1),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          ConstantHelpers.productName,
                          style: txtStyle
                      ),
                      Text(
                        '\$45',
                        style: txtStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ConstantHelpers.companyName,
                        style: semiBoldStyle,
                      ),
                      const SizedBox(width: 15,),
                      Text(
                        ConstantHelpers.visitOurStore,
                        style: underlinedLinkStyle
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
                  child: Text(
                    ConstantHelpers.sampleDescr,
                    style: descrStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          ConstantHelpers.productLink,
                          style: semiBoldStyle
                      ),
                      const SizedBox(width: 30,),
                      Text(
                        ConstantHelpers.link,
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          ConstantHelpers.location,
                          style: semiBoldStyle
                      ),
                      const SizedBox(width: 55),
                      Text(
                        '${ConstantHelpers.country} : ${ConstantHelpers.canada}',
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(''),
                      const SizedBox(width: 110),
                      Text(
                        '${ConstantHelpers.street} : ${ConstantHelpers.modaca}',
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(''),
                      const SizedBox(width: 110),
                      Text(
                        '${ConstantHelpers.city} : ${ConstantHelpers.tonado}',
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ConstantHelpers.province,
                        style: semiBoldStyle,
                      ),
                      const SizedBox(width: 55),
                      Text(
                        ConstantHelpers.west,
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ConstantHelpers.date,
                        style: semiBoldStyle,
                      ),
                      const SizedBox(width: 80),
                      Text(
                        ConstantHelpers.constDate,
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ConstantHelpers.price,
                        style: semiBoldStyle,
                      ),
                      const SizedBox(width: 80),
                      Text(
                        ConstantHelpers.priceTag,
                        style: greyStyle,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ConstantHelpers.buttonNext,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        primary: ConstantHelpers.primaryGreen,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        ConstantHelpers.visitShop,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
