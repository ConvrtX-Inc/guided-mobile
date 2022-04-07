import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/utils/mixins/global_mixin.dart';

///Credit card widget
class CreditCard extends StatelessWidget {
  ///Constructor
  const CreditCard({
    required this.cardDetails,
    this.removeCallback,
    Key? key,
    this.showRemoveBtn = true,
    this.cardColors = const <Color>[Color(0xFF1B1A60), Color(0xFF5E1A86)],
  }) : super(key: key);

  ///Card details
  // final StripeCardModel cardDetails;
  final CardModel cardDetails;

  ///Card colors
  final List<Color> cardColors;

  ///Remove callback
  final VoidCallback? removeCallback;

  ///show remove button
  final bool showRemoveBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 305.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: cardDetails.cardColor != ''
                ? GlobalMixin().getColorFromColorCode(cardDetails.cardColor)
                : Color(0xFF1B1A60)),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SvgPicture.asset(
                      '${AssetsPath.assetsSVGPath}/path_card.svg',
                      height: 198.h,
                      width: 307,
                      color: Colors.black.withOpacity(0.5),
                    ))),
            Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SvgPicture.asset(
                      '${AssetsPath.assetsSVGPath}/path_card.svg',
                      height: 160.h,
                      width: 317,
                      color: Colors.black.withOpacity(0.4),
                    ))),
            Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SvgPicture.asset(
                      '${AssetsPath.assetsSVGPath}/path_card.svg',
                      height: 90.h,
                      width: 317,
                      color: Colors.black.withOpacity(0.2),
                    ))),
            Positioned(
                top: 0,
                left: 0,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15.r)),
                    child: Image.asset(
                      '${AssetsPath.assetsPNGPath}/path_card_rotated.png',
                      height: 169.h,
                    ))),
            Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                        GlobalMixin().getCardLogoUrl(cardDetails.cardType!),
                        height: 30.h),
                    SizedBox(height: 6.h),
                  ],
                )),
            Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  children: <Widget>[
                    Text(
                        '••••${cardDetails.cardNo.substring(cardDetails.cardNo.length - 4)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.25.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 6))
                  ],
                )),
            if(showRemoveBtn)
              Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                      onTap: removeCallback,
                      child: SvgPicture.asset(
                        '${AssetsPath.assetsSVGPath}/remove_card_btn.svg',
                      ))),
          ],
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<CardModel>('cardDetails', cardDetails))
      ..add(IterableProperty<Color>('cardColors', cardColors));
  }
}
