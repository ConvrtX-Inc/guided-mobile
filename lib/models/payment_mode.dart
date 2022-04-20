///Payment Mode
class PaymentMode {
  ///Constructor
  PaymentMode(
      {this.mode = '',
      this.isSelected = false,
      this.logo = '',
      this.isEnabled = true});

  ///Initialization for mode
  String mode;

  ///Initialization for is selected
  bool isSelected;

  ///Initialization for logo
  String logo;

  ///Initialization for isEnabled
  bool isEnabled;
}
