///User Transaction Model
class UserTransaction {
  ///Constructor
  UserTransaction(
      {this.id = '',
      this.userId = '',
      this.numberOfPeople = '',
      this.activityPackageId = '',
      this.total = '',
      this.tourGuideId = '',
      this.bookDate = '',
      this.transactionNumber = '',
      this.statusId = '',
      this.serviceName = '',
      this.createdDate = '',
      this.updatedDate = ''});

  ///Initialization
  String id,
      userId,
      activityPackageId,
      total,
      tourGuideId,
      bookDate,
      numberOfPeople,
      serviceName,
      transactionNumber,
      statusId,
      createdDate,
      updatedDate;

  UserTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        total = json['total'],
        tourGuideId = json['tour_guide_id'],
        bookDate = json['book_date'],
        serviceName = json['service_name'],
        transactionNumber = json['transaction_number'],
        statusId = json['status_id'],
        createdDate = json['created_date'],
        updatedDate = json['updated_date'],
        numberOfPeople = json['number_of_people'].toString(),
        activityPackageId = json['activity_package_id'];
}
