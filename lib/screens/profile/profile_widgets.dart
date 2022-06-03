import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/constants/asset_path.dart';

import '../../constants/app_colors.dart';

Padding backButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
              height: 40.h, width: 40.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

Padding divider() {
  return const Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Divider(),
  );
}

Center buildCircleAvatar(String image) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 2, color: AppColors.galleryWhite, spreadRadius: 2)
        ],
      ),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.white,
        child: image != ''
            ? CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(image),
        )
            : const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(
              '${AssetsPath.assetsPNGPath}/default_profile_pic.png'),
        ),
      ),
    ),
  );
}

Padding buildImageWithFilter({required BuildContext context, required String image, int count = 0}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: AppColors.codGray,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: count > 0 ?  ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop) : null,
            image: NetworkImage(
              image,
            ),
          ),
        ),
        child:  count > 0 ?  Center(
          child: Text(
            '$count+',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ) : null,
      ),
    ),
  );
}

Container buildImage(BuildContext context, String image) {
  return Container(
    // decoration: BoxDecoration(border: Border.all(color:Colors.grey)),
    padding: EdgeInsets.only(left: 20, right: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Image.network(
            image,
            width: MediaQuery.of(context).size.width * 0.4,
            height: 110,
            fit: BoxFit.cover,
          )),
    ),
  );
}

Column buildReviewContent() {
  return Column(
    children: [
      Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 2,
                    color: AppColors.galleryWhite,
                    spreadRadius: 2)
              ],
            ),
            child: const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/image1.png'),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Ronald Mcdonald',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'May 6, 2021',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Text(
            'Prosciutto bacon burgdoggen tongue, bresaola frankfurter beef sirloin ball tip. Chuck alcatra shank chislic salami jowl. Hamburger rump pig shoulder sirloin kevin filet mignon short ribs boudin bacon turducken. Drumstick pork loin kevin bacon.'),
      ),
      divider(),
    ],
  );
}
