import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/screens/transaction_notifications/transaction_cards.dart';
import 'package:guided/screens/transaction_notifications/transaction_customer.dart';
import 'package:guided/screens/transaction_notifications/transaction_post.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_texts.dart';
import '../../constants/asset_path.dart';

///Main screen for transaction history
class TransactionHistoryMain extends StatefulWidget {
  /// Constructor
  const TransactionHistoryMain({Key? key}) : super(key: key);
  @override
  State<TransactionHistoryMain> createState() => _TransactionHistoryMainState();
}


class _TransactionHistoryMainState extends State<TransactionHistoryMain>
    with TickerProviderStateMixin
{
  int _selectedIndex = 0;
  int _statusSelectedIndex = 0;
  late TabController _controller;
  late TabController _statusController;


  TransactionCustomerList getCustomerList(int stat)
  {
    print("CustomerList:"+stat.toString());
    return TransactionCustomerList(stat);
  }


  @override
  void initState() {
    super.initState();
    print("Init State");
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {


          if(!_controller.indexIsChanging)
          {
            setState(() {
              _selectedIndex = _controller.index;
              print("InDEX:"+_selectedIndex.toString());
            });
          }

    });
    _statusController = TabController(length: 4, vsync: this);
    _statusController .addListener(() {

      if(!_statusController.indexIsChanging)
      {
        setState(() {
          _statusSelectedIndex = _statusController.index;

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getTitleBar(),
            getMainContainer()
          ],
        )
      ),
    );
  }

  AppBar getAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Transform.scale(
        scale: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: AppColors.harp,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
  Widget getTitleBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                TransactionHistoryConstants.transactionHistory,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ))
        ],
      ),
    );
  }


  Widget getMainContainer()
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tabBorder, width: 1),
        color: AppColors.tabFill
      ),
      child:Column(
        children: [
          getMainTabBar(),
          getStatusTabBar(),
          Divider(height: 16.0.h,color: Colors.transparent),
          getDisplay(_statusSelectedIndex),
          Divider(height: 16.0.h,color: Colors.transparent),
        ],
      ),
    );
  }


  Widget getMainTabBar()
  {
    return  TabBar(
      labelPadding: EdgeInsets.zero,
      controller: _controller,
      indicatorColor: Colors.transparent,
      tabs:  [
        Tab(child:_selectedIndex==0?getTabSelected1("Customer"):getTab("Customer")),
        Tab(child:_selectedIndex==1?getTabSelected2("Posts"):getTab("Posts")),
      ],
    );
  }



  Widget getDisplay(int stat)
  {
    // return Center(child: Text("Display"));
    return _selectedIndex == 0 ? getCustomerList(stat):TransactionPostList();
  }
  
  Widget getTab(String label)
  {
    return  Padding(

      padding: EdgeInsets.only(top: 12.0.h,bottom:16.0.h ),
      child: Text(
        label,
        style: TextStyle(
            height: 1.5,
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w600,
            fontFamily: AppTextConstants.fontPoppins,
            color: AppColors.tabTextNotSelected
        ),
      ),
    );
  }

  Widget getTabSelected1(String label)
  {
    return Container(
      
      height: 45.0.h,
      width: double.infinity ,
      child: Padding(
        padding: EdgeInsets.only(top: 12.0.h,bottom:16.0.h ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                height: 1.5,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w600,
                fontFamily: AppTextConstants.fontPoppins,
                color: Colors.white
            ),
          )
        ),
      ) ,
      decoration: BoxDecoration(
        color: AppColors.tabColorSelected,
        borderRadius:BorderRadius.only(
          topLeft:  Radius.circular(12),
          bottomRight: Radius.circular(12)
        ),
      ),
    );
  }
  Widget getTabSelected2(String label)
  {
    return Container(
      height: 45.0.h,
      width: double.infinity ,
      child: Padding(
        padding: EdgeInsets.only(top: 12.0.h,bottom:16.0.h ),
        child: Center(
            child: Text(
              label,
              style: TextStyle(
                  height: 1.5,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppTextConstants.fontPoppins,
                  color: Colors.white
              ),
            )
        ),
      ) ,
      decoration: BoxDecoration(
        color: AppColors.tabColorSelected,
        borderRadius:BorderRadius.only(
            topRight:  Radius.circular(12),
            bottomLeft: Radius.circular(12)
        ),
      ),
    );
  }

  Widget getStatusTabBar()
  {
    return Container(
      child: getStatusTabBarTabs(),
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.only(left: 9,right: 9),
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: AppColors.tabBorder, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
  Widget getStatusTabBarTabs()
  {
    return  TabBar(
      labelPadding:EdgeInsets.zero,
      indicatorWeight: 3,
      indicatorColor:indicatorColor(),
      controller: _statusController,
      tabs: [
        Tab(
          child:
          Center(
            child: Text(
              "All",
              style: TextStyle(
                  height: 1.5,
                  fontSize: 11.0.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppTextConstants.fontPoppins,
                  color: _statusSelectedIndex==0?indicatorColor():AppColors.tabTextNotSelected),
            ),
          ),
        ),
        Tab(
          child: Center(
              child:Text(
                "Completed",
                style: TextStyle(
                    height: 1.5,
                    fontSize: 11.0.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppTextConstants.fontPoppins,
                    color: _statusSelectedIndex==1?indicatorColor():AppColors.tabTextNotSelected),
              )
         ),
          ),
        Tab(  child: Text(
          "Pending",
          style: TextStyle(
              height: 1.5,
              fontSize: 11.0.sp,
              fontWeight: FontWeight.w700,
              fontFamily: AppTextConstants.fontPoppins,
              color: _statusSelectedIndex==2?indicatorColor():AppColors.tabTextNotSelected),
        )
        ),
        Tab(

          child: Text(
          "Rejected",
          style: TextStyle(
              height: 1.5,
              fontSize: 11.0.sp,
              fontWeight: FontWeight.w700,
              fontFamily: AppTextConstants.fontPoppins,
              color: _statusSelectedIndex==3?indicatorColor():AppColors.tabTextNotSelected),
        ),),
      ],
    );
  }

  Color indicatorColor()
  {
    switch(_statusSelectedIndex)
    {
      case 0:
        return Colors.black;
      case 1:
        return AppColors.completedText;
      case 2:
        return AppColors.pendingText;
      case 3:
        return AppColors.rejectedText;
    }
    return Colors.black;
  }


}
