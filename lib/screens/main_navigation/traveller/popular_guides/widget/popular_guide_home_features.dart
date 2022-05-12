import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/main_navigation/traveller/popular_guides/popular_guides_list.dart';
import 'package:guided/common/widgets/avatar_bottom_sheet.dart' as show_avatar;

/// Widget for home features
class PopularGuideHomeFeatures extends StatefulWidget {
  /// Constructor
  const PopularGuideHomeFeatures({
    String id = '',
    String fullName = '',
    String firebaseProfImg = '',
    Key? key,
  })  : _id = id,
        _fullName = fullName,
        _firebaseProfImg = firebaseProfImg,
        super(key: key);
  final String _id;
  final String _fullName;
  final String _firebaseProfImg;

  @override
  State<PopularGuideHomeFeatures> createState() =>
      _PopularGuideHomeFeaturesState();
}

class _PopularGuideHomeFeaturesState extends State<PopularGuideHomeFeatures>
    with AutomaticKeepAliveClientMixin<PopularGuideHomeFeatures> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: _settingModalBottomSheet,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
        height: 180.h,
        width: 220.w,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 112.h,
              width: 220.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
                image: DecorationImage(
                  image: widget._firebaseProfImg == ''
                      ? Image.network(
                          'https://img.icons8.com/external-coco-line-kalash/344/external-person-human-body-anatomy-coco-line-kalash-4.png',
                          width: 50,
                          height: 50,
                        ).image
                      : ExtendedImage.network(
                          widget._firebaseProfImg,
                        ).image,
                  fit: widget._firebaseProfImg == ''
                      ? BoxFit.fitHeight
                      : BoxFit.cover,
                ),
              ),
              // child: Stack(
              //   children: <Widget>[
              //     Positioned(
              //       bottom: 0,
              //       child: CircleAvatar(
              //         backgroundColor: Colors.transparent,
              //         radius: 30,
              //         backgroundImage:
              //             AssetImage(guides[1].path),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget._fullName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.r),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/png/marker.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  '1 KM',
                  style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 11.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet() {
    show_avatar.showAvatarModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      expand: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => const PopularGuidesList(),
    );
  }
}
