import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/advertisement.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/advertisements/widget/advertisement_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/utils/advertisement.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Advertisement List Screen
class AdvertisementList extends StatefulWidget {
  /// Constructor
  const AdvertisementList({Key? key}) : super(key: key);

  @override
  _AdvertisementListState createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            FutureBuilder<AdvertisementModelData>(
              future: APIServices().getAdvertisementData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget _displayWidget;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    _displayWidget = const Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  // ignore: no_default_cases
                  default:
                    if (snapshot.hasError) {
                      _displayWidget = Center(
                          child: APIMessageDisplay(
                        message: 'Result: ${snapshot.error}',
                      ));
                    } else {
                      _displayWidget = buildAdvertisementResult(snapshot.data!);
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

  Widget buildAdvertisementResult(AdvertisementModelData advertisementData) =>
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (advertisementData.advertisementDetails.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 3) - 40),
                child: APIMessageDisplay(
                  message: AppTextConstants.noResultFound,
                ),
              )
            else
              for (AdvertisementDetailsModel detail
                  in advertisementData.advertisementDetails)
                buildAdvertisementInfo(detail)
          ],
        ),
      );

  Widget buildAdvertisementInfo(AdvertisementDetailsModel details) =>
      AdvertisementFeature(
        id: details.id,
        title: details.title,
        imageUrl: AssetsPath.ads1,
        country: details.country,
        address: details.address,
        date:
            '${details.adDate!.month.toString().padLeft(2, '0')}. ${details.adDate!.day.toString().padLeft(2, '0')}. ${details.adDate!.year.toString().padLeft(2, '0')}',
        price: details.price,
        description: details.description,
      );

  void _settingModalBottomSheet() {
    show_avatar.showAvatarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const AdvertisementAdd(),
    );
  }
}
