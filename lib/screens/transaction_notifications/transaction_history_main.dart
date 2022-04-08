import 'dart:convert';


import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/models/post_model.dart';
import 'package:guided/screens/transaction_notifications/transaction_cards.dart';
import 'package:guided/screens/transaction_notifications/transaction_customer.dart';
import 'package:guided/screens/transaction_notifications/transaction_post.dart';
import 'package:http/http.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_texts.dart';
import '../../models/api/api_standard_return.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_modelv2.dart';
import '../../models/user_model.dart';
import '../../utils/services/rest_api_service.dart';

///Main screen for transaction history
class TransactionHistoryMain extends StatefulWidget {
  /// Constructor
  const TransactionHistoryMain({Key? key}) : super(key: key);
  @override
  State<TransactionHistoryMain> createState() => _TransactionHistoryMainState();
}


class _TransactionHistoryMainState extends State<TransactionHistoryMain>
    with SingleTickerProviderStateMixin {

  GlobalKey<TransactionCustomerListState> _myKey = GlobalKey();

  GlobalKey<TransactionPostListState> _postKey = GlobalKey();
  late TabController _controller;
  late double screenWidth;
  late double screenHeight;
  List<Transaction> transactions = List.empty(growable: true);
  int _selectedIndex = 0;
  bool isLoading = false;

  Future<void> login() async {
    final Map<String, String> credentials = <String, String>{
      'email': 'touristguide.dummy@gmail.com',
      'password': '123xswcde'
    };
    await APIServices()
        .login(credentials)
        .then((APIStandardReturnFormat response) async {
      print("EMAIL:"+credentials.toString());
      if (response.status == 'error') {
        print("Response:"+response.errorResponse);
        AdvanceSnackBar(
            message: ErrorMessageConstants.loginWrongEmailorPassword)
            .show(context);
        setState(() => isLoading = false);
      }
      else {
        print("Response:"+response.successResponse);

        final UserModel user =
        UserModel.fromJson(json.decode(response.successResponse));
        UserSingleton.instance.user = user;

        if (user.user?.isTraveller != true) {
        } else {
        }
      }
    });
  }
  Future<void> loginTraveller() async {
    final Map<String, String> credentials = <String, String>{
      'email': 'mraraullo_travel.gmail.com',
      'password': 'string'
    };
    await APIServices()
        .login(credentials)
        .then((APIStandardReturnFormat response) async {
      print("EMAIL:"+credentials.toString());
      if (response.status == 'error') {
        print("Response:"+response.errorResponse);
        AdvanceSnackBar(
            message: ErrorMessageConstants.loginWrongEmailorPassword)
            .show(context);
        setState(() => isLoading = false);
      }
      else {
        print("Response:"+response.successResponse);
        final UserModel user =
        UserModel.fromJson(json.decode(response.successResponse));
        UserSingleton.instance.user = user;
        if (user.user?.isTraveller != true) {
        } else {
        }
      }
    });
  }
  Future<void> getTransactions(int filter) async {
    print("Refreshing transactions data");
    setState(() {
      isLoading = true;
    });
    int? status = _myKey.currentState?.getFilter();
    await APIServices()
        .getTransactionsByGuide(filter)
        .then((APIStandardReturnFormat response) async {
      if (response.status == 'error') {
        print("Error:"+response.errorResponse);
      }
      else {
        final List<Transaction2> details = <Transaction2>[];
        print("RESPONSE:"+response.successResponse);
        final List<dynamic> res = jsonDecode(response.successResponse).cast<dynamic>();
        for (final dynamic data in res) {
          final Transaction2 transactionModel =
          Transaction2.fromJson(data);
          details.add(transactionModel);
        }
        _myKey.currentState?.setLoading(false);
        setState(() => this.isLoading = false);
        _myKey.currentState?.setTransactions(details);
      }

    });
  }

  Future<void> getPosts() async {
    print("Refreshing posts data");
    setState(() {
      isLoading = true;
    });

    await APIServices()
        .getPosts()
        .then((APIStandardReturnFormat response) async {
      if (response.status == 'error') {
        print("Error:"+response.errorResponse);
      }
      else {
        final List<Post> posts = <Post>[];
        final List<dynamic> res = jsonDecode(response.successResponse);
        for (final dynamic data in res) {
          final Post post =
            Post.fromJson(data);
            posts.add(post);
        }
        posts.addAll(AppListConstants.posts);
        print("Posts:"+posts.length.toString());
        _postKey.currentState?.setLoading(false);
        setState(() => this.isLoading = false);
        _postKey.currentState?.setPosts(posts);
      }


    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
          if(!_controller.indexIsChanging)
          {
            setState(() {
              _selectedIndex = _controller.index;
            });
            switch(_selectedIndex)
            {
              case 0:
                getTransactions(0);
                break;
              case 1:
                getPosts();
                break;
            }
          }
    });
    login();
    getTransactions(0);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body:RefreshIndicator(
        child: SingleChildScrollView(
            physics: isLoading?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
            child: getMainDisplay()
        ),
        onRefresh: _onReferesh,
      )
    );
  }
  int filter = 0;
  Future<void> _onReferesh() async
  {
    filter = _myKey.currentState!.statusSelectedIndex;
    setState(() => this.isLoading = true);
    switch(_selectedIndex)
    {
      case 0:
        _myKey.currentState?.setLoading(true);
        getTransactions(filter);
        break;
      case 1:
        _postKey.currentState?.setLoading(true);
        getPosts();
        break;
    }
  }


  Widget getMainDisplay(){
    return  Column(
      children: <Widget>[
        getTitleBar(),
        getMainContainer()
      ],
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
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(0),
      constraints: BoxConstraints(
          minHeight: screenHeight*0.80,
          minWidth: double.infinity,
          maxHeight: double.infinity
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tabBorder, width: 1),
        color: AppColors.tabFill
      ),
      child:getDataDisplay()
    );
  }

  Widget getDataDisplay()
  {
    return Column(
      children: [
        getMainTabBar(),
        if (_selectedIndex==0) TransactionCustomerList(_onReferesh,key:_myKey) else TransactionPostList(_onReferesh,key:_postKey),
        Divider(height:16.h,color: Colors.transparent,)
      ],
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
    return _selectedIndex == 0 ?
    TransactionCustomerList(_onReferesh,key:_myKey) :
    TransactionPostList(_onReferesh,key:_postKey);
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
      decoration: BoxDecoration(
        color: AppColors.tabColorSelected,
        borderRadius:const BorderRadius.only(
          topLeft:  Radius.circular(12),
          bottomRight: Radius.circular(12)
        ),
      ),
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
    );
  }
  Widget getTabSelected2(String label)
  {
    return Container(
      height: 45.0.h,
      width: double.infinity ,
      decoration: BoxDecoration(
        color: AppColors.tabColorSelected,
        borderRadius:const BorderRadius.only(
            topRight:  Radius.circular(12),
            bottomLeft: Radius.circular(12)
        ),
      ),
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
    );
  }


//678036c1-9da6-43ae-bb21-253a5e9b54d5
}
