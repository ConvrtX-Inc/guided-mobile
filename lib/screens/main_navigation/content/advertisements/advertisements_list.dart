// ignore_for_file: no_default_cases
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/models/advertisement_model.dart';
import 'package:guided/screens/main_navigation/content/advertisements/advertisements_add.dart';
import 'package:guided/screens/main_navigation/content/advertisements/widget/advertisement_features.dart';
import 'package:guided/screens/widgets/reusable_widgets/api_message_display.dart';
import 'package:guided/screens/widgets/reusable_widgets/main_content_skeleton.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Advertisement List Screen
class AdvertisementList extends StatefulWidget {
  /// Constructor
  const AdvertisementList({Key? key}) : super(key: key);

  @override
  _AdvertisementListState createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList>
    with AutomaticKeepAliveClientMixin<AdvertisementList> {
  @override
  bool get wantKeepAlive => true;
  bool isLoading = false;
  late Future<AdvertisementModelData> _loadingData;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getAdvertisementData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            FutureBuilder<AdvertisementModelData>(
              future: _loadingData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                Widget _displayWidget;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    _displayWidget = const MainContentSkeleton();
                    break;
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
        heroTag: 'btn3',
        backgroundColor: AppColors.chateauGreen,
        onPressed: _settingModalBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getAdvertisementData() async {
    _loadingData = APIServices().getAdvertisementData();
    setState(() {
      isLoading = false;
    });
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
        country: details.country,
        address: details.address,
        activities: details.activities,
        street: details.street,
        city: details.city,
        province: details.province,
        zip_code: details.zipCode,
        date:
            '${details.adDate!.month.toString().padLeft(2, '0')}. ${details.adDate!.day.toString().padLeft(2, '0')}. ${details.adDate!.year.toString().padLeft(2, '0')}',
        availability_date:
            '${details.adDate!.year.toString().padLeft(2, '0')}-${details.adDate!.month.toString().padLeft(2, '0')}-${details.adDate!.day.toString().padLeft(2, '0')}',
        price: details.price,
        description: details.description,
        isPublished: details.isPublished,
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
