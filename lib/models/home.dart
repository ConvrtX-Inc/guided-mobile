import 'dart:ui';

import 'package:flutter/material.dart';

/// Class for home features
class HomeModel {
  /// Constructor
  HomeModel({
    /// Features models
    this.featureName = '',
    this.featureImageUrl = '',
    this.featureStarRating = 0.0,
    this.featureFee = 0.0,
    this.featureNumberOfTourists = 0,

    /// Customer Requests
    this.cRFirstName = '',
    this.cRLastName = '',
    this.cRMiddleName = '',
    this.cRProfilePic = '',

    /// Earnings
    this.personalBalance = 0,
    this.pendingOrders = 0,
    this.totalEarnings = 0,
  });

  /// feature name
  final String featureName;

  /// feature image name
  final String featureImageUrl;

  /// feature star rating
  final double featureStarRating;

  /// feature fee
  final double featureFee;

  /// feature number of tourists
  final int featureNumberOfTourists;

  /// customer requests first name
  final String cRFirstName;

  /// customer requests middle name
  final String cRMiddleName;

  /// customer requests last name
  final String cRLastName;

  /// customer requests profile picture url
  final String cRProfilePic;

  /// earnings personal balance
  final double personalBalance;

  /// earnings pending orders
  final double pendingOrders;

  /// earnings total earnings
  final double totalEarnings;
}
