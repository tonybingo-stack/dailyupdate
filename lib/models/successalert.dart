// ignore_for_file: non_constant_identifier_names

class SuccessAlert {
  final int id;
  final String? alert_id;
  final String? alert_type;
  final String alert_name;
  final String alert_desc;
  final String img_links;
  final String? created_at;
  final String? updated_at;

  SuccessAlert(
      [this.id = 0,
      this.alert_id = "",
      this.alert_type = "",
      this.alert_name = "",
      this.alert_desc = "",
      this.img_links = "",
      this.created_at = "",
      this.updated_at = ""]);

  factory SuccessAlert.fromJson(Map<String, dynamic> json) {
    // print(json);
    return SuccessAlert(
      json['id'],
      json['alert_id'],
      json['alert_type'],
      json['alert_name'],
      json['alert_desc'],
      json['img_links'],
      json['created_at'],
      json['updated_at'],
    );
  }
}
