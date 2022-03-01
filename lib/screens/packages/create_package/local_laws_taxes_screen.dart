// ignore_for_file: file_names, cast_nullable_to_non_nullable
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/screens/packages/create_package/waiver_screen.dart';

/// Local laws taxes screen
class LocalLawsTaxesScreen extends StatefulWidget {
  /// Constructor
  const LocalLawsTaxesScreen({Key? key}) : super(key: key);

  @override
  _LocalLawsTaxesScreenState createState() => _LocalLawsTaxesScreenState();
}

class _LocalLawsTaxesScreenState extends State<LocalLawsTaxesScreen> {
  bool isChecked = false;
  bool _isEnabledEdit = false;

  TextEditingController _localLawsTaxes = TextEditingController();
  final FocusNode _localLawsTaxesFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _localLawsTaxes = TextEditingController(text: AppTextConstants.loremIpsum);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Map<String, dynamic> screenArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
                  HeaderText.headerText(AppTextConstants.headerLocalLaws),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_isEnabledEdit == false) {
                                  _isEnabledEdit = true;
                                } else {
                                  _isEnabledEdit = false;
                                }
                              });
                            },
                            child: Text(
                              _isEnabledEdit
                                  ? AppTextConstants.done
                                  : AppTextConstants.edit,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryGreen,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextField(
                            maxLines: null,
                            enabled: _isEnabledEdit,
                            controller: _localLawsTaxes,
                            focusNode: _localLawsTaxesFocus,
                            decoration: InputDecoration(
                              hintText: AppTextConstants.loremIpsum,
                              hintStyle: TextStyle(
                                color: Colors.grey.shade800,
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: <Widget>[
                      CustomCheckBox(
                        value: isChecked,
                        shouldShowBorder: true,
                        borderColor: AppColors.grey,
                        checkedFillColor: AppColors.primaryGreen,
                        borderRadius: 8.r,
                        borderWidth: 1.w,
                        checkBoxSize: 22,
                        onChanged: (bool val) {
                          setState(() {
                            isChecked = val;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          AppTextConstants.agreeLocalLaws,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
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
            onPressed: () {
              if (isChecked == true) {
                navigateWaiverScreen(context, screenArguments);
              }
            },
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
              AppTextConstants.next,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateWaiverScreen(
      BuildContext context, Map<String, dynamic> data) async {
    final Map<String, dynamic> details = Map<String, dynamic>.from(data);

    /// Local Laws and taxes Textfield *insert here
    await Navigator.pushNamed(context, '/waiver', arguments: details);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isChecked', isChecked));
  }
}
