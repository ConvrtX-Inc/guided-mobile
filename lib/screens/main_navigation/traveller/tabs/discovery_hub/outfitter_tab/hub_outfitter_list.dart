// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, no_default_cases
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/screens/main_navigation/traveller/tabs/discovery_hub/outfitter_tab/widget/hub_outfitter_features.dart';
import 'package:guided/screens/main_navigation/traveller/traveller_tabbar.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Outfitter List Screen
class TabDiscoveryHubOutfitter extends StatefulWidget {
  /// Constructor
  const TabDiscoveryHubOutfitter({Key? key}) : super(key: key);

  @override
  _TabDiscoveryHubOutfitterState createState() =>
      _TabDiscoveryHubOutfitterState();
}

class _TabDiscoveryHubOutfitterState extends State<TabDiscoveryHubOutfitter>
    with AutomaticKeepAliveClientMixin<TabDiscoveryHubOutfitter> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TravellerTabScreen()));
                      },
                      child: Container(
                        height: 60.h,
                        width: 58.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/png/green_house_outlined.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: EdgeInsets.fromLTRB(0.w, 0.h, 15.w, 0.h),
                  //     child: TextField(
                  //       textAlign: TextAlign.left,
                  //       keyboardType: TextInputType.text,
                  //       decoration: InputDecoration(
                  //         hintText: 'Search...',
                  //         hintStyle: TextStyle(fontSize: 16.sp),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(16.r),
                  //           borderSide: const BorderSide(
                  //             width: 0,
                  //             style: BorderStyle.none,
                  //           ),
                  //         ),
                  //         filled: true,
                  //         contentPadding: const EdgeInsets.all(22),
                  //         fillColor: Colors.white,
                  //         prefixIcon: IconButton(
                  //           icon: Image.asset(
                  //             'assets/images/png/search_icon.png',
                  //             width: 20.w,
                  //             height: 20.h,
                  //           ),
                  //           onPressed: null,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Back To Category',
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 30.h),
                child: Text(
                  'My Outfitters',
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FutureBuilder<OutfitterModelData>(
                    future: APIServices().getAllOutfitterData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      Widget _displayWidget;
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          _displayWidget = const Center(
                            child: CircularProgressIndicator(),
                          );
                          break;
                        default:
                          if (snapshot.hasError) {
                            _displayWidget = Center(
                                child: APIMessageDisplay(
                              message: 'Result: ${snapshot.error}',
                            ));
                          } else {
                            _displayWidget =
                                buildOutfitterResult(snapshot.data!);
                          }
                      }
                      return _displayWidget;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOutfitterResult(OutfitterModelData outfitterData) =>
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (outfitterData.outfitterDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (OutfitterDetailsModel detail
                  in outfitterData.outfitterDetails)
                buildOutfitterInfo(detail)
          ],
        ),
      );

  Widget buildOutfitterInfo(OutfitterDetailsModel details) =>
      DiscoveryHubOutfitterFeatures(
        id: details.id,
        title: details.title,
        price: details.price,
        date:
            '${details.availabilityDate!.day.toString().padLeft(2, '0')}/${details.availabilityDate!.month.toString().padLeft(2, '0')}/${details.availabilityDate!.year}',
        availabilityDate:
            '${details.availabilityDate!.year.toString().padLeft(2, '0')}-${details.availabilityDate!.month.toString().padLeft(2, '0')}-${details.availabilityDate!.day.toString().padLeft(2, '0')}',
        description: details.description,
        productLink: details.productLink,
        country: details.country,
        address: details.address,
        street: details.street,
        city: details.city,
        province: details.province,
        zipCode: details.zipCode,
        isPublished: details.isPublished,
      );
}
