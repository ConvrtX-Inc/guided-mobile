import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_texts.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/booking_request.dart';
import 'package:guided/models/requests.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/date_time_ago.dart';
import 'package:guided/screens/widgets/reusable_widgets/list_view_skeleton.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/requests.dart';
import 'package:guided/utils/services/rest_api_service.dart';

/// Request Screen
class RequestsScreen extends StatefulWidget {
  /// Constructor
  const RequestsScreen({Key? key, this.filterType = 'All'}) : super(key: key);

  /// Filter type (all/pending/completed/rejected)
  final String filterType;

  @override
  _RequestsScreenState createState() => _RequestsScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('filterType', filterType));
  }
}

class _RequestsScreenState extends State<RequestsScreen> {
  final List<RequestsScreenModel> requestsItems =
      RequestsScreenUtils.getMockedDataRequestsScreen();

  List<BookingRequest> bookingRequests = <BookingRequest>[];
  List<BookingRequest> filteredRequests = <BookingRequest>[];
  String _filterType = '';
  bool isLoadingRequests = true;

  @override
  void initState() {
    super.initState();
    _filterType = widget.filterType.toLowerCase();
    getBookingRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(AppTextConstants.request,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black)),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 14.w),
              child: InkWell(
                  onTap: filterBookingRequests,
                  child: const Icon(Icons.tune, color: Colors.black)))
        ],
      ),
      body: buildBookingRequestList(),
    );
  }

  //BOOKING REQUEST LIST
  Widget buildBookingRequestList() => !isLoadingRequests
      ? filteredRequests.isNotEmpty
          ? ListView.builder(
              itemCount: filteredRequests.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Column(
                  children: <Widget>[
                    _requestsListItem(context, index, filteredRequests[index]),
                    const Divider(
                      thickness: 0.5,
                    )
                  ],
                );
              })
          : SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(child: Text(AppTextConstants.noRequest)))
      : const SkeletonListView(itemCount: 10);

  // BOOKING REQUEST ITEM
  Widget _requestsListItem(
      BuildContext context, int index, BookingRequest request) {
    return InkWell(
      onTap: () {
        final User traveller =
            User(id: request.fromUserId, fullName: request.fromUserFullName);
        requestView(context, request, traveller);
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
                        image: request.fromUserFirebaseProfilePic != ''
                            ? DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    request.fromUserFirebaseProfilePic!))
                            : DecorationImage(
                                fit: BoxFit.fitHeight,
                                image:
                                    AssetImage(AssetsPath.defaultProfilePic))),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                        child: Text(
                          request.fromUserFullName ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 10.h, 0, 10.h),
                        child: SizedBox(
                          width: 220.w,
                          child: Text(
                            '${request.fromUserFullName} has requested a new booking for  ${request.activityPackageName}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Gilroy',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                    buildStatus(request.status!.statusName!)
                  ],
                ),
                Expanded(
                    child: DateTimeAgo(
                  dateString: request.createdDate!,
                  color: Colors.grey,
                  size: 10.sp,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  // STATUS WIDGET
  Widget buildStatus(String statusName) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Container(
        width: 70.w,
        height: 30.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: GlobalMixin().getStatusColor(statusName),
            borderRadius: BorderRadius.circular(7.r)),
        child: Center(
          child: Text(
            statusName,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy',
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // VIEW BOOKING REQUEST
  Future<void> requestView(
      BuildContext context, BookingRequest request, User traveller) async {
    final Map<String, dynamic> details = {
      'bookingRequest': request,
      'traveller': traveller,
    };
    await Navigator.pushNamed(context, '/request_view', arguments: details);
  }

  // FILTER BOOKING REQUEST
  Future<void> filterBookingRequests() async {
    final dynamic filterType = await Navigator.pushNamed(
        context, '/request_filter',
        arguments: _filterType);

    List<BookingRequest> data = [];
    if (filterType != null) {
      if (filterType.toString().toLowerCase() == 'all') {
        data = bookingRequests;
      } else {
        data = bookingRequests
            .where((element) =>
                element.status!.statusName!.toLowerCase() ==
                filterType.toString().toLowerCase())
            .toList();
      }
    } else {
      data = bookingRequests;
    }
    debugPrint('Data ${data.length}');
    setState(() {
      filteredRequests = data;
      _filterType = filterType ?? 'All';
    });
  }

  //GET BOOKING REQUESTS FROM SERVER
  Future<void> getBookingRequestList() async {
    final List<BookingRequest> res = await APIServices().getBookingRequest();

    if (res.isNotEmpty) {
      setState(() {
        bookingRequests = res;
        filteredRequests = _filterType.toLowerCase() == 'all'
            ? res
            : res
                .where((BookingRequest element) =>
                    element.status!.statusName!.toLowerCase() == _filterType)
                .toList();
      });
    }

    setState(() {
      isLoadingRequests = false;
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          IterableProperty<RequestsScreenModel>('requestsItems', requestsItems))
      ..add(
          IterableProperty<BookingRequest>('bookingRequests', bookingRequests))
      ..add(IterableProperty<BookingRequest>(
          'filteredRequests', filteredRequests))
      ..add(DiagnosticsProperty<bool>('isLoadingRequests', isLoadingRequests));
  }
}
