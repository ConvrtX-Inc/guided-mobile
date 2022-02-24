// // ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/custom_rounded_button.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/screens/payments/payment_add_card.dart';
import 'package:guided/screens/payments/payment_successful.dart';

/// screen for payment manage card
class PaymentManageCard extends StatefulWidget {
  /// constructor
  const PaymentManageCard({Key? key}) : super(key: key);

  @override
  _PaymentManageCardState createState() => _PaymentManageCardState();
}

class _PaymentManageCardState extends State<PaymentManageCard> {
  final List<String> _cardImage = AppListConstants.cardImage;

  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
          title: Text(
            AppTextConstants.manageCards,
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: 'Gilroy'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const PaymentAddCard()),
                  );
                },
                child: Container(
                  height: 2.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.green),
                  child: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
        body: buildBody(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: CustomRoundedButton(
              title: 'Pay P200.00 USD',
              onpressed: () => paymentSuccessful(context)),
        ));
  }

  Widget buildBody() => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Stack(
            children: <Widget>[
              Expanded(
                child: CarouselSlider.builder(
                    itemCount: _cardImage.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final String cardImage = _cardImage[index];
                      return buildcardImage(cardImage, index);
                    },
                    options: CarouselOptions(height: 200.h)),
              ),
              _cardInfo(context)
            ],
          ),
        ),
      );

  Widget buildcardImage(String cardImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        color: Colors.grey,
      );

  Widget _cardInfo(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 250.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Marjorie Smith',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 5.h,
                width: 5.w,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Ending in 0212',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 5.h,
                width: 5.w,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5.r)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '01/23',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Gilroy'),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            '3818 Lynden Road , Orono , Ontario , Canda , L0B 1M0',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy'),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 2.5.w,
                  decoration: BoxDecoration(
                      color: HexColor('36C5F0'),
                      borderRadius: BorderRadius.circular(24.r)),
                  child: Center(
                    child: Text(
                      AppTextConstants.setAsDefaultPayment,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: _showRemoveDialog,
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 5.w,
                  decoration: BoxDecoration(
                      color: HexColor('F86666'),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      AppTextConstants.remove,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 45.h,
                  width: MediaQuery.of(context).size.width / 5.w,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      AppTextConstants.edit,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _getList('Fianna Wu', '2 hr ago', r'+$600.00', () {}),
          _getList('Jolina Jones', '4 hr ago', r'-$200.00', () {}),
          _getList('Wills Smith', '4 hr ago', r'+$240.00', () {}),
        ],
      );

  Widget _getList(
      String title, String subtitle, String trailing, dynamic ontap) {
    return Column(
      children: <Widget>[
        ListTile(
            onTap: ontap,
            leading: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3.w,
                ),
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const <BoxShadow>[
                  BoxShadow(blurRadius: 3, color: Colors.grey)
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35.r,
                backgroundImage: const NetworkImage(
                    'https://www.vhv.rs/dpng/d/164-1645859_selfie-clipart-groucho-glass-good-profile-hd-png.png'),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  fontFamily: 'Gilroy'),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                  fontFamily: 'Samsung Sharp Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp),
            ),
            trailing: Text(
              trailing,
              style: TextStyle(
                  color: HexColor('29A435'),
                  fontFamily: 'Samsung Sharp Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp),
            )),
      ],
    );
  }

  void _showRemoveDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.r))),
            title: Text(
              AppTextConstants.removeCard,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 65.h,
              child: Column(
                children: <Widget>[
                  Text(
                    AppTextConstants.areYouSureYouWantToRemoveCard,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(AssetsPath.visa),
                      Text(
                        'Ending in 0212',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '01/23',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                          width: 75.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.deepGreen, width: 1.w),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text(
                            AppTextConstants.cancel,
                            style: TextStyle(
                                color: AppColors.deepGreen,
                                fontSize: 12.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                    InkWell(
                      child: Container(
                          width: 75.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text(
                            AppTextConstants.confirm,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                  ]),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        });
  }
}
