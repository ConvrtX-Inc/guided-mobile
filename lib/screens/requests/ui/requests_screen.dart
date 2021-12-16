// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/requests.dart';
import 'package:guided/utils/requests.dart';

/// Request Screen
class RequestsScreen extends StatefulWidget {

  /// Constructor
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {

  final List<RequestsScreenModel> requestsItems =
      RequestsScreenUtils.getMockedDataRequestsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScaffold(context),
    );
  }

  Widget getScaffold(BuildContext context) {
    return requestsItems.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.w, 40.h, 0.w, 0.h),
                    child: Row(children: <Widget>[
                      Text(
                        AppTextConstants.request,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {},
                          child: const Icon(Icons.tune
                          // child: Container(
                          //   width: 25,
                          //   height: 25,
                          //   decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: AssetImage(
                          //               'assets/images/filter_icon.png'))),
                          )),
                      const SizedBox(
                        width: 30,
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: requestsItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Column(
                            children: <Widget>[
                              _requestsListItem(context, index),
                              const Divider(
                                thickness: 0.5,
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: Text(AppTextConstants.noRequest)));
  }

  Widget _requestsListItem(
    BuildContext context,
    int index,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 10.h, 0.w, 0.h),
                  child: Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AssetsPath.noUser))),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                        child: Text(
                          requestsItems[index].name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 10.h, 0, 0),
                        child: SizedBox(
                          width: 270.w,
                          child: Text(
                            '${requestsItems[index].name} has requested a new booking for package 3',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Container(
                        width: 60.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(4.r)
                        ),
                        child: Center(
                          child: Text(
                            requestsItems[index].status,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<RequestsScreenModel>('requestsItems', requestsItems));
  }
}