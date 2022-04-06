///Bank account Model
class BankAccountModel {
  ///Constructor
  BankAccountModel(
      {this.id = '',
      this.accountNumber = '',
      this.accountName = '',
      this.bankName = '',
      this.bankRoutingNumber = '',
      this.userId = '',
      this.countryId = '',
      this.countryCode = '',
      this.currency = ''});

  ///Initialization for id
  final String id;

  ///initialization for account name
  final String accountName;

  ///Initialization for bank name
  final String bankName;

  ///Initialization for account number
  final String accountNumber;

  ///Initialization for bank routing number
  final String bankRoutingNumber;

  ///Initialization for countryId
  final String countryId;

  ///Initialization for user id
  final String userId;

  ///Initialization for country code
  final String countryCode;

  ///Initialization for currency
  final String currency;

  ///Mapping
  static BankAccountModel fromJson(Map<String, dynamic> json) =>
      BankAccountModel(
          id: json['id'],
          accountName: json['account_name'],
          accountNumber: json['account_no'],
          bankName: json['account_no'],
          userId: json['user_id'],
          countryId: json['country_id'],
          bankRoutingNumber: json['bank_routing_number']);
}
