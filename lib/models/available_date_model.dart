///Model for available date
class AvailableDateModel {
  /// Constructor
  AvailableDateModel({this.month = 0,this.monthName ='' ,this.availableDates = const <DateTime>[]});

  ///Initialization for month
  int month;

  ///Initialization for monthName
  String monthName;

  ///Initialization for available dates
  List<DateTime> availableDates;
}
