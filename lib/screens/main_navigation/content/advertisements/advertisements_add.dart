// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Adding Advertisement Screen
class AdvertisementAdd extends StatefulWidget {

  /// Constructor
  const AdvertisementAdd({Key? key}) : super(key: key);

  @override
  _AdvertisementAddState createState() => _AdvertisementAddState();
}

class _AdvertisementAddState extends State<AdvertisementAdd> {

  final TextEditingController title = TextEditingController();
  final TextEditingController useCurrentLocation = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Stack _imagePreview() {
      return Stack(
        children: <Widget>[
          Container(
            width: 100.w,
            height: 87.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.gallery,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.gallery,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    AssetsPath.imagePrey,
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 3.w,
            top: 3.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
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

    return
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Transform.scale(
              scale: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColors.harp,
                    borderRadius: BorderRadius.circular(10.r),
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
                  padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HeaderText.headerText(
                          AppTextConstants.advertisement
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        AppTextConstants.uploadImages,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.osloGrey),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _imagePreview(),
                          _imagePreview(),
                          _imagePreview(),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: title,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.title,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: useCurrentLocation,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.pin_drop,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.useCurrentLocation,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.2.w
                          ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: country,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.canada,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: street,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.street,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child:  Text(
                          AppTextConstants.streetHint,
                          style: AppTextStyle.greyStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20.h
                      ),
                      TextField(
                        controller: city,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.city,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 20.h
                      ),
                      TextField(
                        controller: province,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.provinceHint,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 20.h
                      ),
                      TextField(
                        controller: postalCode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.postalCodeHint,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: date,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.date,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: description,
                        maxLines: 10,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.description,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextField(
                        controller: price,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                          hintText: AppTextConstants.price,
                          hintStyle: TextStyle(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.2.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h
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
              height: 60.h,
              child: ElevatedButton(
                onPressed: () async => createAdvertisementData(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.silver,
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  primary: AppColors.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  AppTextConstants.createAdvertisement,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        );
  }

  /// Method for caling the API
  Future<void> createAdvertisementData() async {
    final Map<String, dynamic> outfitterDetails = {
      'user_id': await SecureStorage.readValue(key: SecureStorage.userIdKey),
      'title': title.text,
      'country': country.text,
      'address': street.text + city.text + province.text + postalCode.text,
      'ad_date': date.text,
      'description': description.text,
      'price': int.parse(price.text),
      'is_published': false
    };

    await APIServices().request(AppAPIPath.createAdvertisementUrl, RequestType.POST,
        needAccessToken: true, data: outfitterDetails);

    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const MainContent(initIndex: 3)),
    );
  }
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('title', title));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('useCurrentLocation', useCurrentLocation));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('country', country));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('street', street));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('city', city));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('province', province));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('postalCode', postalCode));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('date', date));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('description', description));
    // ignore: cascade_invocations
    properties.add(DiagnosticsProperty<TextEditingController>('price', price));
  }
}
