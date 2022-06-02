import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/profile_image.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:photo_view/photo_view.dart';

///Profile Photos Viewer Screen
class ProfilePhotosViewer extends StatefulWidget {
  ///Constructor
  const ProfilePhotosViewer(
      {required this.profileImages, this.initialPage = 0, Key? key})
      : super(key: key);

  final UserProfileImage profileImages;

  final int initialPage;

  @override
  _ProfilePhotosViewerState createState() => _ProfilePhotosViewerState();
}

class _ProfilePhotosViewerState extends State<ProfilePhotosViewer> {
  PageController _pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialPage);
    selectedPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: buildProfileImageSlider(),
    );
  }

  Widget buildProfileImageSlider() => Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
            controller: _pageController,
            children: <Widget>[
              // image 1
              if (widget.profileImages.imageUrl1.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl1)),
              // image 2
              if (widget.profileImages.imageUrl2.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl2)),
              // image 3
              if (widget.profileImages.imageUrl3.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl3)),
              // image 4
              if (widget.profileImages.imageUrl4.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl4)),
              // image 5
              if (widget.profileImages.imageUrl5.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl5)),
              // image 6
              if (widget.profileImages.imageUrl6.isNotEmpty)
                PhotoView(
                    imageProvider:
                        NetworkImage(widget.profileImages.imageUrl6)),
            ],
          ),
          Positioned(bottom: 26.h, right: 0, left: 0, child: buildPager())
        ],
      );

  Widget buildPager() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < GlobalMixin().getTotalProfileImages(widget.profileImages); i++)
            GestureDetector(
              onTap: (){
                _pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: Container(
                height: 8.h,
                width: 8.w,
                margin: EdgeInsets.only(right: 2.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPage == i ? Colors.grey : AppColors.gallery),
              ),
            )
        ],
      );

 
}
