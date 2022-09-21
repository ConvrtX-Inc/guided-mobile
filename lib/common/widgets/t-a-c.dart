import 'package:flutter/material.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.convrtx.com');

class TacWidget extends StatelessWidget {
  const TacWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 12, color: AppColors.grey,),
        children: <InlineSpan>[
          const TextSpan(text: 'By Tapping'),
          const TextSpan(
            text: ' Login ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: 'or'),
          const TextSpan(
            text: ' Create New Aaccount ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: 'you agree to MyCarhub’s '),
          WidgetSpan(
            child: GestureDetector(
              onTap: () async {
                await launchUrl(_url);
              },
              child: Text(
                'Terms & Conditions',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.primaryGreen,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
