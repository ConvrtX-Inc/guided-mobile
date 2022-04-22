import 'dart:ui';

import 'package:flutter/material.dart';

/// Class for discovery hub
class DiscoveryHub {
  /// Constructor
  DiscoveryHub({
    /// discovery hub models
    this.id = 0,
    this.title = '',
    this.description = '',
    this.date = '',
    this.path = '',
    this.img1 = '',
    this.img2 = '',
    this.img3 = '',
    this.isPremium = false
  });

  /// initialization
  int id;

  /// initialization
  final String title, description, date, path, img1, img2, img3;

  ///Initialization
  final bool isPremium;
}
