import 'package:guided/utils/mixins/global_mixin.dart';

/// Card Model
class CardModel {
  ///Constructor
  CardModel(
      {this.id = '',
        this.userId = '',
        this.isDefault=false,
        this.fullName = '',
        this.address = '',
        this.city = '',
        this.cardNo = '',
        this.countryId = '',
        this.postalCode = '',
        this.nameOnCard = '',
        this.cvv,
        this.expiryDate = '',
        this.cardLogoImageUrl = '',
        this.cardType = '',
        this.cardColor =''
      });

  /// initialization for id
  final String id;

  /// initialization for user id
  final String userId;

  /// initialization for isDefault
  bool isDefault;

  /// initialization for address
  final String address;

  /// initialization for city
  final String city;

  ///initialization for fullName
  final String fullName;

  /// initialization for postalCode
  final String postalCode;

  ///initialization for  countryId
  final String countryId;

  ///initialization for cardNo
  final String cardNo;

  ///initialization for nameOnCard
  final String nameOnCard;

  ///initialization for expiryDate
  final String expiryDate;

  ///initialization for cvv
  final int? cvv;

  ///initialization for cardLogoImageUrl
  final String cardLogoImageUrl;

  ///initialization for card type
  final String? cardType;

  ///Initialization for card color
  final String cardColor;

  static CardModel fromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'],
      userId: json['user_id'],
      isDefault: json['is_default'],
      fullName: json['full_name'],
      nameOnCard: json['name_on_card'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postal_code'],
      countryId: json['country_id'],
      cardNo: json['card_no'],
      expiryDate: json['expiry_date'],
      cvv: json['cvv'],
      cardType: json['card_type'],
      cardColor: json['card_color'] ?? GlobalMixin().generateRandomHexColor()
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'isDefault': isDefault,
    'fullName': fullName,
    'nameOnCard': nameOnCard,
    'address': address,
    'city': city,
    'postalCode': postalCode,
    'countryId': countryId,
    'cardNo': cardNo,
    'expiryDate': expiryDate,
    'cvv': cvv,
  };
}
