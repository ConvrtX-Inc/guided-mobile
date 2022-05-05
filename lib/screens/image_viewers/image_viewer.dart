import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

///Image viewer screen
class ImageViewerScreen extends StatelessWidget {
  ///Image
  const ImageViewerScreen({required this.imageUrl, Key? key}) : super(key: key);

  ///Image url
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: PhotoView(imageProvider: NetworkImage(imageUrl)));
  }
}