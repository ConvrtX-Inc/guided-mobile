// ignore_for_file: non_constant_identifier_names
/// Model for User Terms And Condition
class UsersTermsAndConditionModel {
  /// Constructor
  UsersTermsAndConditionModel(
      {this.id = '',
      this.user_id = '',
      this.is_terms_and_conditions = false,
      this.is_traveler_release_and_waiver_form = false,
      this.is_cancellation_policy = false,
      this.is_payment_and_payout_terms = false,
      this.is_local_laws_and_taxes = false});

  /// initialization for id
  final String id, user_id;

  /// initialization for form condition
  final bool is_terms_and_conditions,
      is_traveler_release_and_waiver_form,
      is_cancellation_policy,
      is_payment_and_payout_terms,
      is_local_laws_and_taxes;

  static UsersTermsAndConditionModel fromJson(Map<String, dynamic> json) =>
      UsersTermsAndConditionModel(
          id: json['id'],
          user_id: json['user_id'],
          is_terms_and_conditions: json['is_terms_and_conditions'] ?? '',
          is_traveler_release_and_waiver_form:
              json['is_traveler_release_and_waiver_form'],
          is_cancellation_policy: json['is_cancellation_policy'],
          is_payment_and_payout_terms: json['is_payment_and_payout_terms'],
          is_local_laws_and_taxes: json['is_local_laws_and_taxes']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': user_id,
        'is_terms_and_conditions': is_terms_and_conditions,
        'is_traveler_release_and_waiver_form':
            is_traveler_release_and_waiver_form,
        'is_cancellation_policy': is_cancellation_policy,
        'is_payment_and_payout_terms': is_payment_and_payout_terms,
        'is_local_laws_and_taxes': is_local_laws_and_taxes
      };
}
