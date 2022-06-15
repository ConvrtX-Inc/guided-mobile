import 'package:flutter/material.dart';
import 'package:guided/constants/app_texts.dart';

///Review Count Widget
class ReviewsCount extends StatelessWidget {
  ///Constructor
  const ReviewsCount({Key? key, this.count = 0,this.mainAxisAlignment = MainAxisAlignment.center}) : super(key: key);

  final int count;

  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        const Icon(
          Icons.star,
          color: Color(0xff056028),
          size: 14,
        ),
        Text(
          count < 1
              ? AppTextConstants.noReviewsYet
              : '$count ${count > 1
              ? 'Reviews'
              : 'Review'}',
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
