import 'package:flutter/material.dart';
import 'package:guided/screens/profile/profile_widgets.dart';

import '../../constants/app_colors.dart';

// ignore: public_member_api_docs
class ReviewsProfileScreen extends StatelessWidget {
  const ReviewsProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            backButton(context),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 2,
                          color: AppColors.galleryWhite,
                          spreadRadius: 2)
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/profile-photos-2.png'),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Ethan Hunt',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Color(0xff056028),
                          size: 14,
                        ),
                        Text(
                          '19 Reviews',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Reviews',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Row(
                    children: const <Widget>[
                      Icon(
                        Icons.star,
                        color: Color(0xff056028),
                        size: 14,
                      ),
                      Text(
                        '19 Reviews',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff056028),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            buildReviewContent(),
            buildReviewContent(),
            buildReviewContent(),
            buildReviewContent(),
            buildReviewContent(),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextButton(
                // ignore: sort_child_properties_last
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text('Show All 19 Reviews',
                      style: TextStyle(
                          color: Color(0xff056028),
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ),
                style: TextButton.styleFrom(
                  primary: const Color(0xff056028),
                  onSurface: const Color(0xff056028),
                  side: const BorderSide(color: Color(0xff056028), width: 2),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
