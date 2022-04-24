class Status{

  String? id;
  String? statusName;
  bool? isActive;
  String? createdDate;
  String? updateddDate;
  String? deletedAt;

  Status({
    this.id,
    this.statusName,
    this.isActive,
    this.createdDate,
    this.updateddDate,
    this.deletedAt
  });

  Status.fromJson(Map<String,dynamic> json){
      id = json['id'];
      statusName = json['status_name'];
      isActive = json['is_active'];
      createdDate = json['created_date'];
      updateddDate = json['updated_date'];
      deletedAt = json['deletedAt'];
  }


}