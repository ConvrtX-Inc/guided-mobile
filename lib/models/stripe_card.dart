/// Stripe Card Model
class StripeCardModel {
  ///Constructor
  StripeCardModel(
      {this.id,
      this.object,
      this.brand,
      this.country,
      this.customer,
      this.cvcCheck,
      this.dynamicLast4,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.last4,
      this.nameOnCard,
      this.tokenizationMethod});

  /// id
  String? id;

  /// object type
  String? object;
  String? brand;
  String? country;
  String? customer;
  String? cvcCheck;
  String? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;

  String? nameOnCard;
  Null? tokenizationMethod;

  StripeCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];

    brand = json['brand'];
    country = json['country'];
    customer = json['customer'];
    cvcCheck = json['cvc_check'];
    dynamicLast4 = json['dynamic_last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    funding = json['funding'];
    last4 = json['last4'];

    nameOnCard = json['name'];
    tokenizationMethod = json['tokenization_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['object'] = object;

    data['brand'] = brand;
    data['country'] = country;
    data['customer'] = customer;
    data['cvc_check'] = cvcCheck;
    data['dynamic_last4'] = dynamicLast4;
    data['exp_month'] = expMonth;
    data['exp_year'] = expYear;
    data['fingerprint'] = fingerprint;
    data['funding'] = funding;
    data['last4'] = last4;

    return data;
  }
}
