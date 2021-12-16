// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/api_path.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/form_helper.dart';
import 'package:guided/models/outfitter.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/screens/main_navigation/content/content_main.dart';
import 'package:guided/utils/secure_storage.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Add Outfitter Screen
class OutfitterAdd extends StatefulWidget {
  /// Constructor
  const OutfitterAdd({Key? key}) : super(key: key);

  @override
  _OutfitterAddState createState() => _OutfitterAddState();
}

class _OutfitterAddState extends State<OutfitterAdd> {
  final SecureStorage secureStorage = SecureStorage();

  String _userId = '';
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _productLink = TextEditingController();
  final TextEditingController _useCurrentLocation = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();

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

    return Scaffold(
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
          decoration: BoxDecoration(
            color: AppColors.osloGrey,
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
                  HeaderText.headerText(AppTextConstants.outfitters),
                  SizedBox(height: 50.h),
                  Text(
                    AppTextConstants.uploadImages,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.osloGrey),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _imagePreview(),
                      _imagePreview(),
                      _imagePreview(),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.title,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _price,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.price,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _productLink,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.productLink,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _useCurrentLocation,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pin_drop,
                        color: Colors.black,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.useCurrentLocation,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _country,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.canada,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _street,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.street,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      AppTextConstants.streetHint,
                      style: AppTextStyle.greyStyle,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _city,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.city,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _province,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.provinceHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _postalCode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.postalCodeHint,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _date,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.date,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(30.w, 20.h, 20.w, 20.h),
                      hintText: AppTextConstants.description,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.2.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
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
            onPressed: () async => createOutfitter(),
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
              AppTextConstants.createOutfitter,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  /// Methode for caling the API
  Future<void> createOutfitter() async {
    final Map<String, dynamic> outfitterDetails = {
      'user_id': await SecureStorage.readValue(key: SecureStorage.userIdKey),
      'title': _title.text,
      'price': int.parse(_price.text),
      'product_link': _productLink.text,
      'country': _country.text,
      'address': _street.text + _city.text + _province.text + _postalCode.text,
      'availability_date': _date.text,
      'description': _description.text
    };

    await APIServices().request(AppAPIPath.createOutfitterUrl, RequestType.POST,
        needAccessToken: true, data: outfitterDetails);

    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const MainContent(initIndex: 2)),
    );
  }
}
