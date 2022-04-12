import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';

import '../../../../constants/app_colors.dart';

/// Screen for RequestToBookScreen
class RequestToBookScreen extends StatefulWidget {
  /// Constructor
  const RequestToBookScreen({Key? key}) : super(key: key);

  @override
  State<RequestToBookScreen> createState() => _RequestToBookScreenState();
}

class _RequestToBookScreenState extends State<RequestToBookScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#ECEFF0'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 220.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Request to book',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 100.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/png/activity1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Toronto, Canada',
                                  style: TextStyle(
                                      color: HexColor('#979B9B'),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Text(
                                  'The Basho Wayfarer',
                                  style: TextStyle(
                                      color: HexColor('#181B1B'),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  'Hunt',
                                  style: TextStyle(
                                      color: HexColor('#181B1B'),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: AppColors.deepGreen,
                                    ),
                                    Text(
                                      '16 reviews',
                                      style: TextStyle(
                                          color: HexColor('#979B9B'),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              sectionTwo(),
              sectionThree(),
              sectionFour(),
              sectionFive(),
              sectionSix(),
              sectionSeven(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTwo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Description',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date',
                    style: TextStyle(
                      color: HexColor('#3E4242'),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '8 Jun-12 Jun',
                    style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Spacer(),
              Text(
                'Edit',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Activity',
                  style: TextStyle(
                    color: HexColor('#3E4242'),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Hunting',
                  style: TextStyle(
                    color: HexColor('#696D6D'),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionThree() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 320.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 43.h,
            width: 101.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              image: DecorationImage(
                image: AssetImage(AssetsPath.forThePlanet),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: 47.h,
                width: 236.w,
                decoration: BoxDecoration(
                  color: HexColor('#C5FFCF'),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'A minimum of \$1 payment will be donated to 1% For The Planet',
                    style: TextStyle(
                      color: HexColor('#066028'),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                height: 47.h,
                width: 65.w,
                decoration: BoxDecoration(
                  color: HexColor('#ECEFF0'),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    '\$1',
                    style: TextStyle(
                      color: HexColor('#696D6D'),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                '60 X 6 hours',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$360',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Discount 20%',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '-\$60',
                style: TextStyle(
                  color: HexColor('#066028'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Adventure Fee: ',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$54',
                style: TextStyle(
                  color: HexColor('#696D6D'),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Total',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '\$354',
                style: TextStyle(
                  color: HexColor('#3E4242'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionFour() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 210.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pay with',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: <Widget>[
              Text(
                'Payment method',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: HexColor('#007749'),
                ),
                onPressed: () {},
                child: const Text('Add'),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 36.h,
                width: 84.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/card1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                height: 36.h,
                width: 84.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/card2.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                height: 36.h,
                width: 84.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/card3.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Enter a coupon',
            style: TextStyle(
              color: HexColor('#181B1B'),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          )
        ],
      ),
    );
  }

  Widget sectionFive() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 255.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Required for your trip',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Message the guide',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: HexColor('#3E4242'),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Located northwest if Montreal in Quebec’s the Laurentian Mountains',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: HexColor('#696D6D'),
                ),
              ),
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                primary: HexColor('#181B1B'),
                onSurface: Colors.yellow,
                side: BorderSide(color: HexColor('#696D6D'), width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text('Add',
                    style: TextStyle(
                        color: HexColor('#181B1B'),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Phone Number',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: HexColor('#3E4242'),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Located northwest if Montreal in Quebec’s the Laurentian Mountains',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: HexColor('#696D6D'),
                ),
              ),
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                primary: HexColor('#181B1B'),
                onSurface: Colors.yellow,
                side: BorderSide(color: HexColor('#696D6D'), width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text('Add',
                    style: TextStyle(
                        color: HexColor('#181B1B'),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget sectionSix() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cancellation policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Located northwest if Montreal in Quebec’s the Laurentian Mountains, Mont-Tremblant is best known for its skiing, specifically Mont.  ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
                TextSpan(
                  text: 'Learn more!',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Make sure this guide cancellaion policy works for you.',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
                TextSpan(
                  text:
                      'Mont-Tremblant is best known for its skiing, specifically Mont.  ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
                TextSpan(
                  text: 'Learn more!',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget sectionSeven() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(top: 10.h),
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Your booking won’t be confirmed until the host accepts yourrequest (within 24 hours?) ',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#181B1B'),
                  ),
                ),
                TextSpan(
                  text: 'You won’t be charged until then.',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    color: HexColor('#696D6D'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 60.h,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextButton(
              style: TextButton.styleFrom(
                primary: HexColor('#979B9B'),
                backgroundColor: HexColor('#ECEFF0'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/goToPaymentMethod');
              },
              child: Text(
                'Request to book',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: HexColor('#979B9B'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}