class Tasks {
  final String status;
  final String message;
  final String data;

  const Tasks({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
