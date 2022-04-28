// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/requests.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/requests.dart';
import 'package:guided/utils/services/rest_api_service.dart';

import '../../../models/booking_request.dart';
import '../../../models/user_model.dart';

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
                          onTap: () {
                            Navigator.pushNamed(context, '/request_filter');
                          },
                          child: const Icon(Icons.tune)),
                      const SizedBox(
                        width: 30,
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<List<BookingRequest>>(
                    future: APIServices().getBookingRequest(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BookingRequest>> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Column(
                                  children: <Widget>[
                                    _requestsListItem(
                                        context, index, snapshot.data![index]),
                                    const Divider(
                                      thickness: 0.5,
                                    )
                                  ],
                                );
                              }),
                        );
                      }
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const Center(
                        child: Text("You Don't Have Any Request Yet"),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: Text(AppTextConstants.noRequest)));
  }

  Future<void> requestView(
      BuildContext context, BookingRequest request, User traveller) async {
    final Map<String, dynamic> details = {
      'bookingRequest': request,
      'traveller': traveller,
    };

    await Navigator.pushNamed(context, '/request_view', arguments: details);
  }

  Widget _requestsListItem(
      BuildContext context, int index, BookingRequest request) {
    return FutureBuilder<User>(
      future: APIServices().getUserDetails(request.fromUserId!),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () {
              requestView(context, request, snapshot.data!);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
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
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(requestsItems[0].imgUrl))),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                              child: Text(
                                snapshot.data!.fullName ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 10.h, 0, 0),
                              child: SizedBox(
                                width: 220.w,
                                child: Text(
                                  '${snapshot.data!.fullName} has requested a new booking for package ${request.numberOfPerson}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                          SizedBox(
                            height: 20.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Container(
                              width: 60.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: AppColors.lightningYellow,
                                  borderRadius: BorderRadius.circular(7.r)),
                              child: Center(
                                child: Text(
                                  request.status!.statusName!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '16 Sc',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const SkeletonText(
            width: 200,
            height: 90,
          );
        }
        return const Center(child: Text("You Don't Have Any Request Yet"));
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        IterableProperty<RequestsScreenModel>('requestsItems', requestsItems));
  }
}
