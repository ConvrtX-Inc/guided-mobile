class ActivityBadge {
  String? id;
  String? badgeName;
  String? badgeDescription;
  String? imgIcon;
  bool? isMainActivity;
  bool? isSubActivity;
  Null? deletedAt;
  String? sEntity;

  ActivityBadge(
      {this.id,
      this.badgeName,
      this.badgeDescription,
      this.imgIcon,
      this.isMainActivity,
      this.isSubActivity,
      this.deletedAt,
      this.sEntity});

  ActivityBadge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    badgeName = json['badge_name'];
    badgeDescription = json['badge_description'];
    imgIcon = json['img_icon'];
    isMainActivity = json['is_main_activity'];
    isSubActivity = json['is_sub_activity'];
    deletedAt = json['deletedAt'];
    sEntity = json['__entity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['badge_name'] = this.badgeName;
    data['badge_description'] = this.badgeDescription;
    data['img_icon'] = this.imgIcon;
    data['is_main_activity'] = this.isMainActivity;
    data['is_sub_activity'] = this.isSubActivity;
    data['deletedAt'] = this.deletedAt;
    data['__entity'] = this.sEntity;
    return data;
  }
}
