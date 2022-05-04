import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guided/models/bank_account_model.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/stripe_bank_account_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:http/http.dart' as http;

/// App Stripe services
class StripeServices {
  ///Stripe api url
  String stripeApiUrl = 'https://api.stripe.com/v1';

  ///Stripe api key
  String apiKey =
      'sk_test_51K6QgjKn5tIlJ89hpKNuYDHqBxmc6l2BRG2REm11slivu6QzrRdyYB8DbGa3ObMTo2dyskjQ83GClkk5DVWrRRuO00RKZQAYm1';

  ///Create Bank Account Token - It will validate the Bank Account
  Future<dynamic> createBankAccountToken(BankAccountModel params) async {
    Map<String, String> bankAccountDetails = {
      'bank_account[country]': params.countryCode,
      'bank_account[account_number]': params.accountNumber,
      'bank_account[account_holder_name]': params.accountName,
      'bank_account[currency]': params.currency,
      'bank_account[routing_number]': params.bankRoutingNumber
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $apiKey'
    };

    final http.Response response = await http.post(
        Uri.parse('$stripeApiUrl/tokens'),
        body: bankAccountDetails,
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    return jsonData;
  }

  ///Create Card Token - It will validate the card
  Future<dynamic> createCardToken(
      CardModel card, List<String> expiryDetails) async {
    final String expMonth = expiryDetails[0];
    final String expYear = expiryDetails[2];
    Map<String, String> cardDetails = {
      'card[number]': card.cardNo,
      'card[exp_month]': expMonth,
      'card[exp_year]': expYear,
      'card[name]': card.nameOnCard,
      'card[cvc]': card.cvv.toString()
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $apiKey'
    };

    final http.Response response = await http.post(
        Uri.parse('$stripeApiUrl/tokens'),
        body: cardDetails,
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    return jsonData;
  }

  /// API service for Stripe Payment method
  Future<String> createPaymentMethod(CardModel card) async {
    List<String> expiryDetails = card.expiryDate.split("-");

    final String expYear = expiryDetails[0];
    final String expMonth = expiryDetails[1];
    debugPrint('$expMonth $expYear EXPIRY');
    Map<String, String> cardDetails = {
      'type': 'card',
      'card[number]': card.cardNo,
      'card[exp_month]': expMonth,
      'card[exp_year]': expYear,
      'card[cvc]': card.cvv.toString()
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${apiKey}'
    };

    final http.Response response = await http.post(
        Uri.parse('$stripeApiUrl/payment_methods'),
        body: cardDetails,
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint('Stripe Payment Method ID ${jsonData}');

    return jsonData['id'];
  }

  /// API service for Stripe Payment method  from token
  Future<String> createPaymentMethodFromToken(String token) async {
    Map<String, String> cardDetails = {
      'type': 'card',
      'card[token]': token,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${apiKey}'
    };

    final http.Response response = await http.post(
        Uri.parse('$stripeApiUrl/payment_methods'),
        body: cardDetails,
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint('Stripe Payment Method ID ${jsonData}');

    return jsonData['id'];
  }

  ///Get list of bank accounts
  Future<List<StripeBankAccountModel>> getBankAccounts() async {
    final String? stripeAccountId =
        UserSingleton.instance.user.user?.stripeAccountId;

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${apiKey}'
    };

    final http.Response response = await http.get(
        Uri.parse(
            '$stripeApiUrl/accounts/$stripeAccountId/external_accounts?object=bank_account'),
        headers: headers);

    final dynamic jsonData = jsonDecode(response.body);
    final List<StripeBankAccountModel> bankAccounts =
        <StripeBankAccountModel>[];
    for (final dynamic res in jsonData['data']) {
      final StripeBankAccountModel bankAccount =
          StripeBankAccountModel.fromJson(res);
      bankAccounts.add(bankAccount);
    }
    debugPrint('BANK ACCOUNT ${bankAccounts[0].accountHolderName}');
    return bankAccounts;
  }

  /// API service for Bank account update metadata
  Future<StripeBankAccountModel> updateAccount(StripeBankAccountModel params) async {
    final String? stripeAccountId =
        UserSingleton.instance.user.user?.stripeAccountId;

    Map<String, String> bankDetails = {
      'metadata[bank_name]': params.bankName,
      'metadata[account_number]': params.accountNumber
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${apiKey}'
    };

    final http.Response response = await http.post(
        Uri.parse('$stripeApiUrl/accounts/$stripeAccountId/external_accounts/${params.id}'),
        body: bankDetails,
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    debugPrint('Stripe Bank ID ${jsonData}');
    final StripeBankAccountModel updatedData = StripeBankAccountModel.fromJson(jsonData);

    return updatedData;
  }

  ///Remove bank account
  Future<http.Response> removeBankAccount(String id) async {
    final String? stripeAccountId =
        UserSingleton.instance.user.user?.stripeAccountId;

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${apiKey}'
    };

    final http.Response response = await http.delete(
        Uri.parse('$stripeApiUrl/accounts/$stripeAccountId/external_accounts/${id}'),
        headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return response;
  }
}
