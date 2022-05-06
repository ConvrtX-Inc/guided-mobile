import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_text_style.dart';
import 'package:guided/models/newsfeed_image_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/skeleton_text.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Widget for home features
class DiscoveryHubFeatures extends StatefulWidget {
  /// Constructor
  const DiscoveryHubFeatures({
    String id = '',
    String title = '',
    String description = '',
    DateTime? date,
    String mainBadgeId = '',
    bool isPremium = false,
    Key? key,
  })  : _id = id,
        _title = title,
        _description = description,
        _date = date,
        _mainBadgeId = mainBadgeId,
        _isPremium = isPremium,
        super(key: key);

  final String _id;
  final String _title;
  final String _description;
  final DateTime? _date;
  final String _mainBadgeId;
  final bool _isPremium;

  @override
  State<DiscoveryHubFeatures> createState() => _DiscoveryHubFeaturesState();
}

class _DiscoveryHubFeaturesState extends State<DiscoveryHubFeatures> {
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
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 15,
                      color: AppColors.osloGrey,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '${widget._date!.day}/ ${widget._date!.month}/ ${widget._date!.year}',
                      style: AppTextStyle.dateStyle,
                    ),
                  ],
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

  Widget buildSlider(BuildContext context) => FutureBuilder<NewsfeedImageModel>(
        future: APIServices().getNewsfeedImageData(widget._id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final NewsfeedImageModel newsfeedImage = snapshot.data;
            final int length = newsfeedImage.newsfeedImageDetails.length;
            imageCount = length;

            for (int i = 0; i < imageCount; i++) {
              imageList.add(
                  newsfeedImage.newsfeedImageDetails[i].firebaseSnapshotImg);
              imageIdList.add(newsfeedImage.newsfeedImageDetails[i].id);
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
                        final NewsfeedImageDetails imgData =
                            newsfeedImage.newsfeedImageDetails[index];

                        return buildImage(imgData, index);
                      }),
                  if (length == 1) Container(),
                  if (length == 0)
                    GestureDetector(
                        onTap: () {
                          navigateDiscoveryHubView(context);
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

  Widget buildImage(NewsfeedImageDetails imgData, int index) => GestureDetector(
        onTap: () {
          navigateDiscoveryHubView(context);
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

  Future<void> navigateDiscoveryHubView(BuildContext context) async {
    final Map<String, dynamic> details = {
      'id': widget._id,
      'title': widget._title,
      'description': widget._description,
      'availability_date':
          '${widget._date!.day}/ ${widget._date!.month}/ ${widget._date!.year}',
      'is_premium': widget._isPremium
    };

    await Navigator.pushNamed(context, '/discovery_hub_view',
        arguments: details);
  }
}
