import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/screens/profile/profile_details/certificate/widget/certificate_card.dart';

import 'package:guided/screens/profile/profile_widgets.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {

  bool isForPlanet = false;
  bool isFirstAidCertified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(context),
              const Padding(
                padding: EdgeInsets.only(left: 32,top: 19),
                child: Text(
                  "Certificate",
                  style: TextStyle(
                      fontSize: 24,
                      height: 1.2,
                      fontFamily: 'Gilroy-Light',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 19,left: 16,right: 16),
                child:    Column(
                  children: [
                    ListTile(
                      leading: 
                        Image.asset(
                          AssetsPath.forThePlanet,
                          height: 37,
                          width: 87,
                        ),
                      trailing: CupertinoSwitch(
                        activeColor: Colors.green,
                        value:isForPlanet, onChanged: (bool value) {
                          setState(() {
                            isForPlanet = value;
                          });

                          },
                        
                      ),
                    ),
                    ListTile(
                      leading:
                      Text(
                        "First Aid Certified",
                        style: TextStyle(
                          color: AppColors.firstAidTag,
                            fontSize: 14,
                            height: 1.2,
                            fontFamily: 'Gilroy-Light',
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: Colors.green,
                        value:isFirstAidCertified, onChanged: (bool value) {
                       setState(() {
                        isFirstAidCertified = value;
                        });

                      },

                      ),
                    ),
                    showCertificateList()
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget showCertificateList()
  {
    return Container(
      padding: EdgeInsets.only(top: 19,left: 16,right: 16),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder:  (BuildContext context, int index) {
            return CertificateCard();
          },
          separatorBuilder: (BuildContext context, int index) {return Divider(height: 10.0.h,color: Colors.transparent);},
          itemCount: 3
      ),
    );
  }



}
