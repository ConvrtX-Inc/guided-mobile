import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/constants/app_colors.dart';

class _LocalExample {
  final String text;
  final String example;
  final String img;

  _LocalExample(this.text, this.example, this.img);

  factory _LocalExample.fromJson(Map json) {
    return _LocalExample(json['text'], json['example'], json['img']);
  }
}

final examples = [
  {
    'text':
        'On this trip, you’ll learn everything you need to know to safely and confidently go on your own canoe trips with the help of one of our trained guides.  This ranges from day one, going over each of our packs, understanding why we’re bringing what we’re bringing, and how to travel with it through the wilderness. For first time paddlers, this first day will be an introduction to being on the water: how to paddle, how to steer a canoe, and how to navigate with confidence through unknown territory with nothing but a map and your wits. Once we’re in the backcountry, you’ll have the chance to pick your own site and practice essential skills like setting up your tent, how to assemble a weatherproof tarp system, building a fire pit and, of course, cooking over that open flame. On travel days, we’ll dig into these skills even further, offering the chance for you to put them into practice, while also learning about the local flora, fauna, and cultural history of Algonquin Park. Planning and Permit Booking Check-list and Packing Canoe Travel Basics Navigating Open Water - paddling, reading a map, dealing with emergencies Campsite Set Up - pitching your tent, hanging a tarp, collecting firewood, dealing with furry visitors Campfire Cooking - prep, cooking and cleanup - enjoying gourmet meal over an open flame Setting Off for New Sites. Basic Wilderness Survival Skills & Emergency Preparedness Local Flora and Fauna Identification',
    'example': 'Beginner Backcountry Canoe Trip',
    'img': 'assets/images/pngpackage3.png',
  },
  {
    'text':
        'Located in the North East corner of Algonquin Park, the Petawawa River has long been considered one of Ontario’s classic white water canoe routes. The perfect setting for a short whitewater trip. We will start our trip at Lake Traverse and paddle a section that is approximately 50km over 4 days navigating numerous exciting class 1 and 2 rapids. The Petawawa is one of many tributaries that flow into the Ottawa River, and has been used by many travellers for thousands of years. Some living with the river and the land, others looking for an alternate route to connect the Ottawa River with Lake Huron for trade, recently used as part of the logging industry and to today where 100’s of recreational canoers come to enjoy the fun and splash rapids and camping beneath the pines.\nWhile this trip is excellent for any paddlers, it is also an amazing river to learn on. Our guides will teach you the whitewater skills you need to safely read and run rapids, and continue coaching you on various maneuvers throughout the entire trip. Cap this trip off with a fun 3km long class 1 rapid that is impossible not to love. We acknowledge that the Petawawa River flows through the traditional territories of the  Omàmìwininìwag (Algonquin) and Anishinabek Nations and is recognized under both the Williams (1923) and Robinson-Huron (Treaty 61, 1850) Treaties.  We recognize that we are visitors to this land.',
    'example': 'Whitewater River Canoe Adventure',
    'img': 'assets/images/pngpackage3.png',
  },
].map((e) => _LocalExample.fromJson(e)).toList();

class PackageStoryExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            const ModalTitle(title: 'Example'),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: examples.length,
                itemBuilder: (context, index) {
                  final item = examples[index];
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(item.img),
                            ),
                            Expanded(
                              child: Text(
                                item.example,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Text(
                          item.text,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: width,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.silver),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  primary: AppColors.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Save',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
