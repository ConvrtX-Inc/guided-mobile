// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_images.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/utils/package.util.dart';

/// Create Package Screen
class SomeQuickPhotoAdviceScreen extends StatefulWidget {
  /// Constructor
  const SomeQuickPhotoAdviceScreen({Key? key}) : super(key: key);

  @override
  _SomeQuickPhotoAdviceScreenState createState() =>
      _SomeQuickPhotoAdviceScreenState();
}

class _SomeQuickPhotoAdviceScreenState
    extends State<SomeQuickPhotoAdviceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Continue',
      onButton: () {
        if (_formKey.currentState?.validate() != true) {
          return;
        }

        navigateTo(context, AppRoutes.ADD_YOUR_PHOTOS_SCREEN,
            _formKey.currentState!.value);
      },
      page: 14,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText.headerTextLight("Some quick photo advice"),
              const AppSizedBox(h: 20),
              _QuickPhotoAdviceWidget(
                title:
                    'Provide a variety of details and angels, including photos of people in action.',
                shouldNot: 'assets/images/png/should-not-01.png',
                should: 'assets/images/png/should-01.png',
              ),
              const AppSizedBox(h: 20),
              _QuickPhotoAdviceWidget(
                title: 'Show real life moments that illustrate your Adventure',
                shouldNot: 'assets/images/png/should-not-02.png',
                should: 'assets/images/png/should-02.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickPhotoAdviceWidget extends StatelessWidget {
  final String title;
  final String should;
  final String shouldNot;

  const _QuickPhotoAdviceWidget({
    Key? key,
    required this.title,
    required this.should,
    required this.shouldNot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.blackStyle,
        ),
        Row(
          children: [
            Column(
              children: [
                PackageImageWidget(assetUrl: should),
                const AppSizedBox(h: 10),
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset('assets/images/complete.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    Text(
                      'Descriptive & Interesting',
                      style: TextStyle(
                        color: AppColors.chateauGreen,
                        fontFamily: AppTextConstants.fontGilroy,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                PackageImageWidget(assetUrl: shouldNot),
                const AppSizedBox(h: 10),
                Text(
                  'Repetitive & Posed',
                  style: TextStyle(
                    color: AppColors.chateauGreen,
                    fontFamily: AppTextConstants.fontGilroy,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
