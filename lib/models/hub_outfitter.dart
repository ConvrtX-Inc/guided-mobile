import 'dart:ui';

import 'package:flutter/material.dart';

/// Class for hub outfitter
class HubOutfitter {
  /// Constructor
  HubOutfitter({
    /// discovery hub models
    this.id = 0,
    this.title = '',
    this.description = '',
    this.date = '',
    this.price = '',
    this.img1 = '',
    this.img2 = '',
    this.img3 = '',
  });

  /// initialization
  int id;

  /// initialization
  final String title, description, date, price, img1, img2, img3;
}
