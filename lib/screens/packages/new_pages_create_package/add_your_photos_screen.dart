// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/buttons.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/common/widgets/package_widgets.dart';
import 'package:guided/constants/app_routes.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/utils/package.util.dart';
import 'package:guided/utils/services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';

final _features = [
  'A variety of details and angles, including photos of people in action',
  'Candid moments that accurately illustrate the experience',
  'Good image quality, no heavy filters, distortions, overlaid text or watermarks',
];

/// Create Package Screen
class AddYourPhotosScreen extends StatefulWidget {
  /// Constructor
  const AddYourPhotosScreen({Key? key}) : super(key: key);

  @override
  _AddYourPhotosScreenState createState() => _AddYourPhotosScreenState();
}

class _AddYourPhotosScreenState extends State<AddYourPhotosScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> _files = <String>[];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return PackageWidgetLayout(
      buttonText: 'Continue',
      onButton: _loading
          ? null
          : () {
              if (_formKey.currentState?.validate() != true) {
                return;
              }

              navigateTo(context, AppRoutes.GROUP_SIZE_SCREEN,
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
              HeaderText.headerTextLight("Add your photos"),
              const AppSizedBox(h: 10),
              Text(
                  "We will have a look at your photos before they go live.  Remember, we are here to help make your Adventures look AWESOME!.....We say AWESOME a lot don't we?"),
              const AppSizedBox(h: 20),
              Text(
                "Upload at least 5 more",
                style: AppTextStyle.defaultStyle,
              ),
              const AppSizedBox(h: 20),
              SimpleButton(
                text: 'Upload',
                onPressed: _upload,
              ),
              const AppSizedBox(h: 20),

              ///
              Wrap(
                children: _files
                    .map(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: SizedBox.fromSize(
                          size: Size.fromWidth(100.w),
                          child: Image.network(e, fit: BoxFit.cover),
                        ),
                      ),
                    )
                    .toList(),
              ),

              ///
              const AppSizedBox(h: 20),
              Text(
                "Your photos must have",
                style: AppTextStyle.defaultStyle,
              ),
              for (final feature in _features)
                ListTile(
                  dense: true,
                  title: Text(feature),
                  leading: Icon(Icons.fiber_manual_record, size: 16),
                  minLeadingWidth: 12,
                ),
              const AppSizedBox(h: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _upload() async {
    setState(() {
      _loading = true;
    });

    final images = await ImagePicker().pickMultiImage();
    if (images == null) {
      setState(() {
        _loading = false;
      });
      return;
    }

    if (images.length + _files.length >= 12) {
      setState(() {
        _loading = false;
      });
      return;
    }

    final result =
        await Future.wait(images.map(FirebaseServices.uploadImageToFirebase2));
    final filtered = result.where((e) => e.isNotEmpty);

    if (mounted) {
      final allFiles = _files..addAll(filtered);
      _formKey.currentState?.fields['photos']?.didChange(allFiles);

      setState(() {
        _files = allFiles;
        _loading = false;
      });
    }
  }
}
