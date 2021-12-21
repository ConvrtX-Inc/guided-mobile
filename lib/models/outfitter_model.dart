/// Model of Outfitter
class OutfitterModelClass {
  /// Constructor
  OutfitterModelClass({
    required this.user_id,
    this.title = '',
    this.price = '',
    this.product_link = '',
    this.country = '',
    this.address = '',
    this.street = '',
    this.city = '',
    this.province = '',
    this.currentLocation = '',
    this.postalCode = '',
    this.availability_date = '',
    this.description = '',
  });

  /// Instantiation for user type id
  final String user_id;

  /// Instantiation for title
  final String title;

  /// Instantiation for price
  final String price;

  /// Instantiation for productLink
  final String product_link;

  /// Instantiation for address
  final String address;

  /// Instantiation for currentLocation
  final String currentLocation;

  /// Instantiation for country
  final String country;

  /// Instantiation for street
  final String street;

  /// Instantiation for city
  final String city;

  /// Instantiation for province
  final String province;

  /// Instantiation for postalCode
  final String postalCode;

  /// Instantiation for date
  final String availability_date;

  /// Instantiation for description
  final String description;
}
