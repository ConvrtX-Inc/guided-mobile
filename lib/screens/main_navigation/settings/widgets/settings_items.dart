// ignore_for_file: implementation_imports, unnecessary_statements

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:guided/controller/user_subscription_controller.dart';
import 'package:guided/models/api/api_standard_return.dart';
import 'package:guided/models/card_model.dart';
import 'package:guided/models/preset_form_model.dart';
import 'package:guided/models/user_model.dart';
import 'package:guided/models/user_subscription.dart';
import 'package:guided/routes/route_generator.dart';
import 'package:guided/screens/bookings/screens/my_booking_date.dart';
import 'package:guided/screens/main_navigation/settings/screens/calendar_management/settings_calendar_management.dart';
import 'package:guided/screens/payments/confirm_payment.dart';
import 'package:guided/screens/payments/payment_failed.dart';
import 'package:guided/screens/payments/payment_method.dart';
import 'package:guided/screens/payments/payment_successful.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_bottom_sheet.dart';
import 'package:guided/screens/widgets/reusable_widgets/discovery_payment_details.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
import 'package:guided/utils/services/rest_api_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../common/widgets/avatar_bottom_sheet.dart';

/// Widgets for displaying list of user settings
class SettingsItems extends StatefulWidget {
  /// Constructor
  const SettingsItems(
      {String keyName = '', String imgUrl = '', String name = '', Key? key})
      : _keyName = keyName,
        _imgUrl = imgUrl,
        _name = name,
        super(key: key);
  final String _keyName;
  final String _imgUrl;
  final String _name;

  @override
  State<SettingsItems> createState() => _SettingsItemsState();
}

class _SettingsItemsState extends State<SettingsItems> {
  bool isEnableTile = true;
  String description = '';
  String id = '';
  bool hasPremiumSubscription = false;

  final UserSubscriptionController _userSubscriptionController =
  Get.put(UserSubscriptionController());

  UserSubscription userSubscriptionDetails = UserSubscription();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (widget._keyName) {
          case 'schedule':
            showAvatarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) =>
              const SettingsCalendarManagement(),
            );
            break;
          case 'transaction_history':
            Navigator.pushNamed(context, '/transaction_history');
            break;
          case 'contact_us':
            Navigator.pushNamed(context, '/contact_us');
            break;
          case 'faq':
            Navigator.pushNamed(context, '/faq');
            break;
          case 'terms_of_service':
            isEnableTile ? getTermsAndCondition(context) : false;
            break;
          case 'traveler_release_waiver_form':
            isEnableTile ? getTravelerAndWaiverForm(context) : false;
            break;
          case 'cancellation_policy':
            isEnableTile ? getCancellationPolicy(context) : false;
            break;
          case 'guided_payment_payout_terms':
            isEnableTile ? getGuidedPaymentPayout(context) : false;
            break;
          case 'local_laws_taxes':
            isEnableTile ? getLocalLaws(context) : false;
            break;
          case 'bank_account':
            Navigator.pushNamed(context, '/add_bank_account');
            break;
          case 'payment':
            Navigator.pushNamed(context, '/payment');
            break;
          case 'switch_user_type':
            Navigator.pushNamed(context, '/switch_user_type');
            break;
          case 'switch_to_guide':
            Navigator.pushNamed(context, '/switch_user_type');
            break;
          case 'availability':
            Navigator.pushNamed(context, '/availability');
            break;
          case 'manage_payment':
            Navigator.pushNamed(context, '/manage_payment');
            break;
          case 'become_a_guide':
            Navigator.pushNamed(context, '/become_a_guide');
            break;
          case 'manage_cards':
            Navigator.pushNamed(context, '/manage_cards');
            break;
          case 'notification_traveler':
            Navigator.pushNamed(context, '/notification_traveler');
            break;
          case 'premium_subscription':
          ///For traveler role only
            hasPremiumSubscription =
            UserSingleton.instance.user.user!.hasPremiumSubscription!;
            if (hasPremiumSubscription) {
              Navigator.pushNamed(context, '/subscription_details');
            } else {
              /// show payment screens
              _showDiscoveryBottomSheet('');
            }
            break;
          case 'my_booking':
            selectBookingDates(context: context);
            break;
            // Navigator.pushNamed(context, '/booking_history');
        }
      },
      leading: widget._imgUrl.contains('.png')
          ? Image.asset(
        widget._imgUrl,
        height: 45,
        width: 45,
      )
          : SvgPicture.asset(widget._imgUrl),
      title: Text(
        widget._name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        size: 36,
        color: Colors.black,
      ),
    );
  }

  Future<void> getTermsAndCondition(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });
    final List<PresetFormModel> resForm =
    await APIServices().getTermsAndCondition('terms_and_condition');
    description = resForm[0].description;
    id = resForm[0].id;

    final Map<String, dynamic> details = {
      'id': id,
      'terms_and_condition': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/terms_and_condition',
        arguments: details);
  }

  Future<void> getTravelerAndWaiverForm(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
    await APIServices().getTermsAndCondition('traveler_waiver_form');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'traveler_waiver_form': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/waiver_form', arguments: details);
  }

  Future<void> getCancellationPolicy(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
    await APIServices().getTermsAndCondition('cancellation_policy');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'cancellation_policy': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/cancellation_policy',
        arguments: details);
  }

  Future<void> getGuidedPaymentPayout(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
    await APIServices().getTermsAndCondition('guided_payment_payout');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {
      'id': id,
      'guided_payment_payout': description
    };

    setState(() {
      isEnableTile = true;
    });
    await Navigator.pushNamed(context, '/guide_payment_payout_terms',
        arguments: details);
  }

  Future<void> getLocalLaws(BuildContext context) async {
    setState(() {
      isEnableTile = false;
    });

    final List<PresetFormModel> resForm =
    await APIServices().getTermsAndCondition('local_laws');
    description = resForm[0].description;
    id = resForm[0].id;
    final Map<String, dynamic> details = {'id': id, 'local_laws': description};

    setState(() {
      isEnableTile = true;
    });

    await Navigator.pushNamed(context, '/local_laws_taxes_form',
        arguments: details);
  }

  void _showDiscoveryBottomSheet(String backgroundImage) {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        barrierColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext ctx) => DiscoveryBottomSheet(
          title: 'Premium Discovery',
          backgroundImage: backgroundImage,
          showSkipButton: false,
          showDiscoveryText: false,
          useDefaultBackground: true,
          onSubscribeBtnPressed: () {
            const double price = 5.99;
            Navigator.of(ctx).pop();

            paymentMethod(
                context: context,
                onCreditCardSelected: (CardModel card) {
                  debugPrint('Payment Method:: ${card.cardNo}');
                },
                onContinueBtnPressed: (dynamic data) {
                  String mode = '';
                  if (data is CardModel) {
                    mode = 'Credit Card';
                  } else {
                    mode = Platform.isAndroid ? 'Google Pay' : 'Apple Pay';
                  }

                  if (mode == 'Apple Pay') {
                    debugPrint('Data $data');
                    saveSubscription(data, 'Premium Subscription',
                        price.toString(), mode);
                    paymentSuccessful(
                        context: context,
                        paymentDetails: DiscoveryPaymentDetails(
                            transactionNumber: data),
                        paymentMethod: mode);

                    /// Add Saving of Subscription here
                  } else {
                    final String transactionNumber =
                    GlobalMixin().generateTransactionNumber();
                    confirmPaymentModal(
                        context: context,
                        serviceName: 'Premium Subscription',
                        paymentMethod: data,
                        paymentMode: mode,
                        price: price,
                        onPaymentSuccessful: () {
                          Navigator.of(context).pop();
                          saveSubscription(
                              transactionNumber,
                              'Premium Subscription',
                              price.toString(),
                              mode);
                          //Save Subscription
                          paymentSuccessful(
                              context: context,
                              paymentDetails: DiscoveryPaymentDetails(
                                  transactionNumber: transactionNumber),
                              onBtnPressed: (){
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 2;
                                });
                                Navigator.of(context).pushNamed('/subscription_details');
                              },
                              btnText: 'View Subscription',
                              paymentMethod: mode);
                        },
                        onPaymentFailed: () {
                          paymentFailed(
                              context: context,
                              paymentDetails: DiscoveryPaymentDetails(
                                  transactionNumber: transactionNumber),
                              paymentMethod: mode);
                        },
                        paymentDetails: DiscoveryPaymentDetails(
                            transactionNumber: transactionNumber));
                  }
                },
                price: price);
          },
          onSkipBtnPressed: () {
            Navigator.of(context).pop();
          },
          onCloseBtnPressed: () {
            Navigator.of(context).pop();
          },
          onBackBtnPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }

  Future<void> saveSubscription(String transactionNumber,
      String subscriptionName, String price, String paymentMethod) async {
    String actionType = 'add';
    final DateTime startDate = DateTime.now();

    final DateTime endDate = GlobalMixin().getEndDate(startDate);

    UserSubscription subscriptionParams = UserSubscription(
        paymentReferenceNo: transactionNumber,
        name: subscriptionName,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        price: price);

    if(_userSubscriptionController.userSubscription.id.isNotEmpty){
      subscriptionParams.id = _userSubscriptionController.userSubscription.id;
      actionType ='update';
    }


    final APIStandardReturnFormat result = await APIServices()
        .addUserSubscription(subscriptionParams, paymentMethod,actionType);

    final jsonData = jsonDecode(result.successResponse);
    _userSubscriptionController.setSubscription(UserSubscription.fromJson(jsonData));

    UserSingleton.instance.user.user?.hasPremiumSubscription = true;
    setState(() {
      hasPremiumSubscription = true;
    });
  }
}
