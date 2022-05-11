import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/certificate.dart';

///Certificate card widget
class CertificateCard extends StatefulWidget {
  ///Constructor
  const CertificateCard(
      {required this.certificate, required this.onDeletePressed, required this.onEditPressed, Key? key})
      : super(key: key);

  final Certificate certificate;

  final Function onDeletePressed;

  final Function onEditPressed;

  @override
  State<CertificateCard> createState() => _CertificateCardState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Certificate>('certificate', certificate));
  }
}

class _CertificateCardState extends State<CertificateCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.certificate.certificateName!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: () => widget.onEditPressed(),
                child: Container(
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 2.5)),
                    ], shape: BoxShape.circle),
                    child: SvgPicture.asset(
                        '${AssetsPath.assetsSVGPath}/edit_circle_btn.svg')),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
                onTap: () => widget.onDeletePressed(),
                child:
                Container(
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 2.5)),
                    ], shape: BoxShape.circle),
                    child: SvgPicture.asset(
                        '${AssetsPath.assetsSVGPath}/delete_circle_btn.svg')))
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(widget.certificate.certificateDescription!,
            style: TextStyle(
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w400,
              color: AppColors.firstAidTag,
            )),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13.r)),
                border: Border.all(color: AppColors.gallery),
                image: DecorationImage(
                    image: NetworkImage(
                        widget.certificate.certificatePhotoFirebaseUrl!))),
          ),
        ),
        SizedBox(
          height: 26.h,
        ),
      ],
    );
  }
}
