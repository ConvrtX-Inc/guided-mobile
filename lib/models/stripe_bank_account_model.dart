/// Model for stripe bank account
class StripeBankAccountModel {
  ///Constructor
  StripeBankAccountModel(
      {this.id = '',
      this.accountHolderName = '',
      this.accountHolderType = '',
      this.bankName = '',
      this.country = '',
      this.currency = '',
      this.defaultForCurrency = false,
      this.routingNumber = '',
      this.accountNumber = '',
      this.last4 = ''});

  ///Initialization
  String id,
      accountHolderName,
      accountHolderType,
      bankName,
      country,
      currency,
      last4,
      accountNumber,
      routingNumber;

  ///Initialization bool
  bool defaultForCurrency;

  ///Mapping
  static StripeBankAccountModel fromJson(Map<String, dynamic> json) =>
      StripeBankAccountModel(
        id: json['id'],
          country: json['country'],
          accountHolderName: json['account_holder_name'] ?? '',
          accountNumber: json['metadata'] !=null ? json['metadata']['account_number'] ?? '' : '',
          currency: json['currency'],
          last4: json['last4'],
          routingNumber: json['routing_number'],
          defaultForCurrency: json['default_for_currency'],
          bankName: json['metadata'] !=null ? json['metadata']['bank_name'] ?? '' : ''

      );
}
