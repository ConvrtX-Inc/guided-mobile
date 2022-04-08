import 'package:flutter/cupertino.dart';
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


}
