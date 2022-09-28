import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/dividers.dart';
import 'package:guided/constants/app_colors.dart';

import '../modal.dart';

class SubmitMyAdventureModal extends StatefulWidget {
  const SubmitMyAdventureModal({Key? key}) : super(key: key);

  @override
  State<SubmitMyAdventureModal> createState() => _SubmitMyAdventureModalState();
}

class _SubmitMyAdventureModalState extends State<SubmitMyAdventureModal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            const ModalTitle(title: ""),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Finish Line!  Thanks for submitting your Adventure!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      fontFamily: 'Gilroy'),
                  textAlign: TextAlign.center,
                ),
                AppSizedBox(h: 20),
                Center(
                  child: Text(
                    "Give us a little time to go over your Adventure.  We will make sure it meets GuidED's quality standards, and make friendly recommendations if we feel it's needed.  Once it's reviewed and approved, it will go live on GuidED and you will be all set to start booking your Adventure with eager Travellers!",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppSizedBox(h: 25),
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.lime,
                  size: 100,
                ),
                AppSizedBox(h: 25),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitPackage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.silver),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                    child: Text(
                      "Submit my Adventure",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 300, height: 60),
          ],
        ),
      ),
    );
  }

  void submitPackage() {
    Navigator.of(context).pushNamedAndRemoveUntil('/main_navigation', ModalRoute.withName('/main_navigation'));
  }
}
