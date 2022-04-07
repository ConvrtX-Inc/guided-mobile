import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guided/models/bank_account_model.dart';
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
      'bank_account[currency]':params.currency,
      'bank_account[routing_number]':params.bankRoutingNumber
    };

    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $apiKey'
    };

    final http.Response response =
    await http.post(Uri.parse('$stripeApiUrl/tokens'), body: bankAccountDetails, headers: headers);

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    return jsonData;

  }

}
