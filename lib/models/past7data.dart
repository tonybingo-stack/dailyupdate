class Past7Data {
  final String status;
  final String message;
  final List<dynamic> data;

  const Past7Data({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Past7Data.fromJson(Map<String, dynamic> json) {
    return Past7Data(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class EvalFollow {
  // ignore: non_constant_identifier_names
  final String eval_date;
  // ignore: non_constant_identifier_names
  final String follow_rec;

  const EvalFollow({
    // ignore: non_constant_identifier_names
    required this.eval_date,
    // ignore: non_constant_identifier_names
    required this.follow_rec,
  });

  factory EvalFollow.fromJson(Map<String, dynamic> json) {
    return EvalFollow(
      eval_date: json['eval_date'],
      follow_rec: json['follow_rec'],
    );
  }
}
