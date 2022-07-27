import 'package:flutter/material.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/screens/profile/profile_widgets.dart';
import 'package:guided/screens/widgets/reusable_widgets/reviews_count.dart';

// /// Reviews profile screen
// class ReviewsProfileScreen extends StatelessWidget {
//   ///Constructor
//   const ReviewsProfileScreen({Key? key ,required this.profileDetails }) : super(key: key);
//
//   final User profileDetails;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

/// Review Profile Screen
class ReviewsProfileScreen extends StatefulWidget {
  ///Constructor
  const ReviewsProfileScreen({required this.profileDetails, Key? key})
      : super(key: key);

  final User profileDetails;

  @override
  _ReviewsProfileScreenState createState() => _ReviewsProfileScreenState();
}

class _ReviewsProfileScreenState extends State<ReviewsProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  child:  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                        widget.profileDetails.firebaseProfilePicUrl != ''? NetworkImage(widget.profileDetails.firebaseProfilePicUrl!) : AssetImage(AssetsPath.defaultProfilePic) as ImageProvider,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.profileDetails.fullName!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                   ReviewsCount()
                  ],
                )
              ],
            ),


            const SizedBox(
              height: 20,
            ),
            divider(),

           Expanded(child:  Container(
             alignment: Alignment.center,
             child: Text('Nothing To  Display.'),
           ),),
            const SizedBox(
              height: 10,
            ),

           /* Container(
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
            ),*/

            const SizedBox(
              height: 30,
            )
          ],

      )),
    );
  }
}
