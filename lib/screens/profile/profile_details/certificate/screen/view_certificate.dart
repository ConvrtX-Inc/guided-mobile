import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guided/models/certificate.dart';
import 'package:guided/screens/image_viewers/image_viewer.dart';

///Certificate View Screen
class CertificateView extends StatefulWidget {
  ///Constructor
  const CertificateView({required this.certificate, Key? key})
      : super(key: key);

  final Certificate certificate;

  @override
  _CertificateViewState createState() => _CertificateViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Certificate>('certificate', certificate));
  }
}

class _CertificateViewState extends State<CertificateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29.h, width: 34.w),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.certificate.certificateName!,
            style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: buildCertificateDetailUI());
  }

  Widget buildCertificateDetailUI() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ImageViewerScreen(
                    imageUrl: widget.certificate.certificatePhotoFirebaseUrl!);
              }));
            },
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        widget.certificate.certificatePhotoFirebaseUrl!),
                    fit: BoxFit.contain),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(22.w),
            child: Text(
              widget.certificate.certificateDescription!,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      );
}
