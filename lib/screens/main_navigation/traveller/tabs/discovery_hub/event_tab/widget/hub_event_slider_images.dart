// ignore_for_file: avoid_dynamic_calls, avoid_bool_literals_in_conditional_expressions, always_specify_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/activity_event_destination_image_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Widget for home features
class HubEventSliderImages extends StatefulWidget {
  /// Constructor
  const HubEventSliderImages({
    required String id,
    required String title,
    required double price,
    required String date,
    required String description,
    required String country,
    required String address,
    Key? key,
  })  : _id = id,
        _title = title,
        _date = date,
        _description = description,
        _price = price,
        _country = country,
        _address = address,
        super(key: key);

  final String _id;
  final String _title, _date, _description, _country, _address;
  final double _price;

  @override
  State<HubEventSliderImages> createState() => _HubEventSliderImagesState();
}

class _HubEventSliderImagesState extends State<HubEventSliderImages> {
  late List<String> imageList;
  late List<String> imageIdList;
  int activeIndex = 0;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    imageList = [];
    imageIdList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(1.r))),
                child: buildSlider(context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget._title,
                    style: TextStyle(
                        fontSize: RegExp(r"\w+(\'\w+)?")
                                    .allMatches(widget._title)
                                    .length >
                                5
                            ? 10.sp
                            : 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  widget._price.toString(),
                  style: AppTextStyle.txtStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: AppColors.osloGrey,
                ),
                SizedBox(width: 5.w),
                Text(
                  widget._date,
                  style: AppTextStyle.dateStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget._description,
              style: AppTextStyle.descrStyle,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlider(BuildContext context) =>
      FutureBuilder<EventDestinationImageModel>(
        future: APIServices().getEventDestinationImageData(widget._id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final EventDestinationImageModel eventDestinationImage =
                snapshot.data;
            final int length =
                eventDestinationImage.eventDestinationImageDetails.length;
            imageCount = length;

            for (int i = 0; i < imageCount; i++) {
              imageList.add(eventDestinationImage
                  .eventDestinationImageDetails[i].firebaseSnapshotImg);
              imageIdList.add(
                  eventDestinationImage.eventDestinationImageDetails[i].id);
            }

            return Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  CarouselSlider.builder(
                      itemCount: length,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: 300.h,
                        viewportFraction: 1,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) =>
                                setState(() => activeIndex = index),
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final EventImageDestinationDetails imgData =
                            eventDestinationImage
                                .eventDestinationImageDetails[index];

                        return buildImage(imgData, index);
                      }),
                  if (length == 1) Container(),
                  if (length == 0)
                    GestureDetector(
                        onTap: () {
                          navigateEventDetails(context, '');
                        },
                        child: SizedBox(
                          width: 300.w,
                          height: 300.h,
                          child: const Text(''),
                        ))
                  else
                    Positioned(
                      bottom: 10,
                      child: buildIndicator(length),
                    ),
                ],
              ),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const SkeletonText(
              height: 200,
              width: 900,
              radius: 10,
            );
          }
          return Container();
        },
      );

  Widget buildImage(EventImageDestinationDetails imgData, int index) =>
      GestureDetector(
        onTap: () {
          navigateEventDetails(context, imgData.firebaseSnapshotImg);
        },
        child: ExtendedImage.network(
          imgData.firebaseSnapshotImg,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
      );

  Widget buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: SlideEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.grey.shade800,
            dotHeight: 10.h,
            dotWidth: 10.w),
      );

  /// Navigate to Outfitter View
  Future<void> navigateEventDetails(
      BuildContext context, String snapshotImg) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'title': widget._title,
      'price': widget._price,
      'country': widget._country,
      'description': widget._description,
      'date': widget._date,
      'availability_date': widget._date,
      'address': widget._address,
      'snapshot_img': snapshotImg,
      'image_count': imageCount,
      'image_list': imageList,
      'image_id_list': imageIdList
    };

    await Navigator.pushNamed(context, '/hub_event_view', arguments: details);
  }
}
