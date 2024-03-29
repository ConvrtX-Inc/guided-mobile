import 'package:flutter/cupertino.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/constants/app_texts.dart';
import 'dart:math';

import 'package:guided/constants/asset_path.dart';

///Global Mixin
class GlobalMixin {
  Random random = Random();

  ///Get Color from hex code
  Color getColorFromColorCode(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  ///Generate Hex Color
  String generateRandomHexColor() {
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while (length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    return hex;
  }

  ///Get Card Logo Url
  getCardLogoUrl(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return '${AssetsPath.assetsPNGPath}/visa_colored.png';
      case 'mastercard':
        return '${AssetsPath.assetsPNGPath}/mastercard.png';
      case 'american express':
        return '${AssetsPath.assetsPNGPath}/amex.png';
      case 'discover':
        return '${AssetsPath.assetsPNGPath}/discover.png';
      case 'jcb':
        return '${AssetsPath.assetsPNGPath}/jcb.png';
      case 'unionpay':
        return '${AssetsPath.assetsPNGPath}/unionpay.png';
      case 'diners club':
        return '${AssetsPath.assetsPNGPath}/diners.png';

      default:
        return '${AssetsPath.assetsPNGPath}/visa_colored.png';
    }
  }

  ///generate transaction number
  String generateTransactionNumber() {
    return random.nextInt(9999).toString() +
        random.nextInt(9999).toString() +
        random.nextInt(9999).toString();
  }

  ///Get Yearly Subscription End Date
  DateTime getEndDate(DateTime date) {
    return DateTime(date.year, date.month + 12, date.day);
  }

  ///Get Formatted Card Number
  String getFormattedCardNumber({required String cardNumber, int startingNumber = 5}){
    return cardNumber.replaceRange(startingNumber, cardNumber.length - 4, '*' * (cardNumber.length - 4 - startingNumber));
  }

  ///Get status Color
  Color getStatusColor(String status){
    Color _statusColor = AppColors.lightningYellow;
    switch(status.toLowerCase()){
      case 'pending':
        _statusColor =  AppColors.lightningYellow;
        break;
      case 'completed':
        _statusColor = AppColors.mediumGreen;
        break;
      case 'rejected':
        _statusColor = AppColors.lightRed;
        break;
    }

    return _statusColor;
  }
}
