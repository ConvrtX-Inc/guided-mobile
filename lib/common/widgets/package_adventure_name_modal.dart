import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/modal.dart';

class PackageAdventureNameModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            const ModalTitle(title: 'Examples'),
            SizedBox(height: 10.h),
            Center(
              child: Text("Contain"),
            ),
            SizedBox(
              width: width,
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }

  const PackageAdventureNameModal();
}
