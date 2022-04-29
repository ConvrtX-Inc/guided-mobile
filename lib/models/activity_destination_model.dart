import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

/// Class for activity destination model
class ActivityDestinationModel {
  /// Constructor
  ActivityDestinationModel({
    this.placeName = '',
    this.placeDescription = '',
    this.img1Holder = '',
    this.img2Holder = '',
    this.img3Holder = '',
    this.img1FirebaseHolder = '',
    this.img2FirebaseHolder = '',
    this.img3FirebaseHolder = '',
    this.latitude = '',
    this.longitude = '',
    this.uploadCount = 0,
  });

  /// String inialization
  final String placeName,
      placeDescription,
      img1Holder,
      img2Holder,
      img3Holder,
      img1FirebaseHolder,
      img2FirebaseHolder,
      img3FirebaseHolder,
      latitude,
      longitude;

  final int uploadCount;
}
