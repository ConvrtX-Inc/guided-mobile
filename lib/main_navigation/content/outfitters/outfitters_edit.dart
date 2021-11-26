import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/constant.dart';

class OutfitterEdit extends StatefulWidget {
  const OutfitterEdit({Key? key}) : super(key: key);

  @override
  _OutfitterEditState createState() => _OutfitterEditState();
}

class _OutfitterEditState extends State<OutfitterEdit> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    /// Image List card widget
    Card _widgetImagesList() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                        ConstantHelpers.images,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Text(
                    ConstantHelpers.edit,
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
                    ConstantHelpers.sampleImage,
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
                    ConstantHelpers.sampleImage,
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

    /// Title card widget
    Card _widgetTitle() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text(ConstantHelpers.sportGloves),
                ],
              ),
            ),
          ],
        ),
      );


    /// Price card widget
    Card _widgetPrice() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text('\$50'),
                ],
              ),
            ),
          ],
        ),
      );


    /// Product Link card widget
    Card _widgetProductLink() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                   ConstantHelpers.productLink,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text(ConstantHelpers.link),
                ],
              ),
            ),
          ],
        ),
      );


    /// Description card widget
    Card _widgetDescription() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text(ConstantHelpers.loremIpsum),
                ],
              ),
            ),
          ],
        ),
      );


    /// Location card widget
    Card _widgetLocation() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text('${ConstantHelpers.country} : ${ConstantHelpers.canada}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${ConstantHelpers.state} : ${ConstantHelpers.modaca}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${ConstantHelpers.city} : ${ConstantHelpers.tonado}'),
                ],
              ),
            ),
          ],
        ),
      );

    /// Province card widget
    Card _widgetProvince() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.province,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text(ConstantHelpers.west),
                ],
              ),
            ),
          ],
        ),
      );

    /// Postal Code card widget
    Card _widgetPostalCode() => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ConstantHelpers.postalCode,
                      style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  Text(
                    ConstantHelpers.edit,
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
                  Text(ConstantHelpers.postCode),
                ],
              ),
            ),
          ],
        ),
      );

    /// Date card widget
    Card _widgetDate() => Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    ConstantHelpers.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                Text(
                  ConstantHelpers.edit,
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
                Text(ConstantHelpers.constDate),
              ],
            ),
          ),
        ],
      ),
    );

    return ScreenUtilInit(builder: () =>
        Scaffold(
          appBar: AppBar(
            elevation: 0,
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
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.headerText(ConstantHelpers.editsummaryTitle),
                      ConstantHelpers.spacing30,
                      _widgetImagesList(),
                      _widgetTitle(),
                      _widgetPrice(),
                      _widgetProductLink(),
                      _widgetDescription(),
                      _widgetLocation(),
                      _widgetProvince(),
                      _widgetPostalCode(),
                      _widgetDate(),
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
                  Navigator.pop(context);
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
                  ConstantHelpers.post,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      designSize: const Size(375, 812),
    );
  }
}
