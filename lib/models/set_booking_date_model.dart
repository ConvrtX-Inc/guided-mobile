import 'dart:ui';

import 'package:flutter/material.dart';

/// Class for home features
class SetBookingDateModel {
  /// Constructor
  SetBookingDateModel({
    /// Features models
    this.availabilityHour = '',
    this.slots = 0,
  });

  /// feature name
  final String availabilityHour;

  /// feature number of tourists
  final int slots;
}
