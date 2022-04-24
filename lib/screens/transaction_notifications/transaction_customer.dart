
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/models/transaction_model.dart';
import 'package:guided/screens/transaction_notifications/transaction_cards.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_texts.dart';
import '../../models/transaction_model.dart';

class TransactionCustomerList extends StatefulWidget {
  late VoidCallback refreshData;
  TransactionCustomerList(VoidCallback refreshData,{Key? key}) : super(key: key) {
    this.refreshData = refreshData;
  }
  @override
  State<TransactionCustomerList> createState() {
    return TransactionCustomerListState(refreshData);
  }
}

class TransactionCustomerListState extends State<TransactionCustomerList>
with SingleTickerProviderStateMixin{

  List<Transaction> transactions = List.empty(growable: true);
  List<Transaction> displayed = List.empty(growable: true);
  bool isLoading = false;
  bool _isFirstLoad = true;
  int statusSelectedIndex = 0;
  late TabController _statusController;
  late double screenWidth;
  late double screenHeight;
  late final VoidCallback refreshData;

TransactionCustomerListState(VoidCallback refreshData)
{
  this.refreshData = refreshData;
}

  void setTransactions(List<Transaction> transactions){
    setState(() => this.transactions = transactions);
  }

  int getFilter(){
    return statusSelectedIndex;
  }

  void setLoading(bool isLoading){
    setState(() => this.isLoading = isLoading);
  }

  @override
  void initState() {
    super.initState();

    _statusController = TabController(length: 4, vsync: this);
    _statusController .addListener(() {
      if(!_statusController.indexIsChanging)
      {
        setState(() {
          statusSelectedIndex = _statusController.index;
          print("TRANS STATE:"+statusSelectedIndex.toString());
          setState(() => this.isLoading = true);
          if(refreshData!=null)
            {
              refreshData.call();
            }

        });
      }
    });}

  Widget getProgressBar(){
    return Column(
      children: [
        Divider(height: screenHeight*0.2,color: Colors.transparent),
        CircularProgressIndicator(color:AppColors.completedText)
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
     return Column(
       children: [
         getStatusTabBar(),
         isLoading?getProgressBar():transactions.length>0?showList():noData()
       ],
     );
  }

  Widget showList()
  {
    return Container(
      child: ListView.separated(
        shrinkWrap:true,
            itemCount: transactions.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {return Divider(height: 10.0.h,color: Colors.transparent);},
            itemBuilder: (BuildContext context, int index) {
              return TransactionCustomerCard(transactions[index]);
            }
        ));
  }



  
  
  Widget noData()
  {
    if(_isFirstLoad)
    {
      _isFirstLoad = false;
      return getProgressBar();
    }
    else
      {
        return Column(
          children: [
            Divider(height: screenHeight*0.2,color: Colors.transparent),
            Center(child: Text("Nothing to display"))
          ],
        );

      }

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
      indicatorColor:Transaction.indicatorColor(statusSelectedIndex),
      controller: _statusController,
      tabs: [
        Tab(child:Center(child: Text("All", style: TextStyle(height: 1.5, fontSize: 11.0.sp, fontWeight: FontWeight.w700, fontFamily: AppTextConstants.fontPoppins, color: statusSelectedIndex==0?Transaction.indicatorColor(statusSelectedIndex):Colors.black)))),
        Tab(child: Center(child:Text("Completed", style: TextStyle(height: 1.5, fontSize: 11.0.sp, fontWeight: FontWeight.w700, fontFamily: AppTextConstants.fontPoppins, color: statusSelectedIndex==1?Transaction.indicatorColor(statusSelectedIndex):Colors.black)))),
        Tab(child: Center(child:Text("Pending", style: TextStyle(height: 1.5, fontSize: 11.0.sp, fontWeight: FontWeight.w700, fontFamily: AppTextConstants.fontPoppins, color: statusSelectedIndex==2?Transaction.indicatorColor(statusSelectedIndex):Colors.black)))),
        Tab(child: Center(child:Text("Rejected", style: TextStyle(height: 1.5, fontSize: 11.0.sp, fontWeight: FontWeight.w700, fontFamily: AppTextConstants.fontPoppins, color: statusSelectedIndex==3?Transaction.indicatorColor(statusSelectedIndex):Colors.black)))),
      ],
    );
  }

  String statusId()
  {
    switch(statusSelectedIndex)
    {

      case 1:
        return Transaction.COMPLETED;
      case 2:
        return Transaction.PENDING;
      case 3:
        return Transaction.REJECTED;
    }
    return Transaction.REJECTED;
  }


}
