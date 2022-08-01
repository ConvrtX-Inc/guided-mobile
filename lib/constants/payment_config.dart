///Payment Config
class PaymentConfig{
  ///Enable / Disable Payment Feature
  static bool isPaymentEnabled = true;

  ///Payment currency
 static String currencyCode = 'CAD';

 ///Payment Subscription price
 static double premiumSubscriptionPrice = 5.99;

 ///Bank Card Payment Method
 static String bankCard = 'BANK_CARD';

 ///Google Pay
 static String googlePay = 'GOOGLE_PAY';

 /// Apple Pay
 static String applePay = 'APPLE_PAY';
}
