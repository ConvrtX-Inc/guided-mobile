import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/main_navigation/content/advertisements/advertisements_edit.dart';

class AdvertisementView extends StatefulWidget {
  const AdvertisementView({Key? key}) : super(key: key);

  @override
  _AdvertisementViewState createState() => _AdvertisementViewState();
}

class _AdvertisementViewState extends State<AdvertisementView> {

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
                                MaterialPageRoute(builder: (context) => AdvertisementEdit())
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
                image: AssetImage(ConstantHelpers.assetAds1),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          ConstantHelpers.sportGloves,
                          style: ConstantHelpers.txtStyle
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 15, right: 25),
                  child: Text(
                    ConstantHelpers.sampleDescr,
                    style: ConstantHelpers.descrStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                            ConstantHelpers.activities,
                            style: ConstantHelpers.semiBoldStyle
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ConstantHelpers.harp,
                          border: Border.all(
                            color: ConstantHelpers.harp),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            ConstantHelpers.camping,
                            style: TextStyle(color: ConstantHelpers.nobel)
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: ConstantHelpers.harp,
                            border: Border.all(
                                color: ConstantHelpers.harp),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              ConstantHelpers.hiking,
                              style: TextStyle(color: ConstantHelpers.nobel)
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: ConstantHelpers.harp,
                            border: Border.all(
                                color: ConstantHelpers.harp),
                            borderRadius: BorderRadius.all(const Radius.circular(5))
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              ConstantHelpers.hunt,
                              style: TextStyle(color: ConstantHelpers.nobel)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          ConstantHelpers.location,
                          style: ConstantHelpers.semiBoldStyle
                      ),
                      const SizedBox(width: 55),
                      Text(
                        '${ConstantHelpers.country} : ${ConstantHelpers.canada}',
                        style: ConstantHelpers.greyStyle,
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
                      const SizedBox(width: 105),
                      Text(
                        '${ConstantHelpers.street} : ${ConstantHelpers.modaca}',
                        style: ConstantHelpers.greyStyle,
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
                      const SizedBox(width: 105),
                      Text(
                        '${ConstantHelpers.city} : ${ConstantHelpers.tonado}',
                        style: ConstantHelpers.greyStyle,
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
                        style: ConstantHelpers.semiBoldStyle,
                      ),
                      const SizedBox(width: 55),
                      Text(
                        ConstantHelpers.west,
                        style: ConstantHelpers.greyStyle,
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
                        style: ConstantHelpers.semiBoldStyle,
                      ),
                      const SizedBox(width: 75),
                      Text(
                        ConstantHelpers.constDate,
                        style: ConstantHelpers.greyStyle,
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
                        style: ConstantHelpers.semiBoldStyle,
                      ),
                      const SizedBox(width: 75),
                      Text(
                        ConstantHelpers.priceTag,
                        style: ConstantHelpers.greyStyle,
                      )
                    ],
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
