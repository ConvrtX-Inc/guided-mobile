// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/map_widgets.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/screens/packages/new_pages_create_package/widgets/confirm_meeting_point_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Create Package Screen
class WhereShouldTravellersMeetYouScreen extends StatefulWidget {
  /// Constructor
  const WhereShouldTravellersMeetYouScreen({Key? key}) : super(key: key);

  @override
  _WhereShouldTravellersMeetYouScreenState createState() =>
      _WhereShouldTravellersMeetYouScreenState();
}

class _WhereShouldTravellersMeetYouScreenState
    extends State<WhereShouldTravellersMeetYouScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapLayout(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SafeArea(
                  child: CustomPackageCreationAppBar(page: 9),
                  bottom: false,
                ),
                HeaderText.headerTextLight('Where should Travellers meet you?'),
                SizedBox(height: 10.h),
                AppTextField(
                  name: 'address',
                  hintText: 'Enter address',
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: _openModalSelection,
                  child: Text('Enter Address Manually'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openModalSelection() async {
    final result = await showCustomModalBottomSheet(
      context: context,
      builder: (context) => ConfirmMeetingPointModal(),
      containerWidget: (_, animation, child) => FloatingModal(
        child: child,
      ),
      expand: false,
    );

    if (result is Map) {
      Navigator.pushNamed(context, AppRoutes.WHAT_S_INCLUDED_IN_YOUR_ADVENTURE, arguments: result);
    }
  }
}
