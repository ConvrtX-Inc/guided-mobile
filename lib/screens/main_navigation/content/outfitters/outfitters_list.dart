// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, no_default_cases
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/outfitter_model.dart';
import 'package:guided/screens/main_navigation/content/outfitters/outfitters_add.dart';
import 'package:guided/screens/main_navigation/content/outfitters/widget/outfitter_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Outfitter List Screen
class OutfitterList extends StatefulWidget {
  /// Constructor
  const OutfitterList({Key? key}) : super(key: key);

  @override
  _OutfitterListState createState() => _OutfitterListState();
}

class _OutfitterListState extends State<OutfitterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            FutureBuilder<OutfitterModelData>(
              future: APIServices().getOutfitterData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget _displayWidget;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    _displayWidget = Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.h,
                        ),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                    break;
                  default:
                    if (snapshot.hasError) {
                      _displayWidget = Center(
                          child: APIMessageDisplay(
                        message: 'Result: ${snapshot.error}',
                      ));
                    } else {
                      _displayWidget = buildOutfitterResult(snapshot.data!);
                    }
                }
                return _displayWidget;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.chateauGreen,
        onPressed: _settingModalBottomSheet,
        child: const Icon(Icons.add),
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

  Widget buildOutfitterInfo(OutfitterDetailsModel details) => OutfitterFeature(
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
      );

  void _settingModalBottomSheet() {
    showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const OutfitterAdd(),
    );
  }
}
