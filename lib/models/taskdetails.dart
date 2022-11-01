// ignore_for_file: non_constant_identifier_names

class TaskDetails {
  final String status;
  final String message;
  final TaskDescribe data;

  const TaskDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      status: json['status'],
      message: json['message'],
      data: TaskDescribe.fromJson(json['data']),
    );
  }
}

class TaskDescribe {
  final int yesCount;
  final int noCount;
  final int naCount;
  final bool followUp;
  final bool filledForFollowUp;
  final bool submitWithComment;
  final String recommended_task;

  const TaskDescribe({
    required this.yesCount,
    required this.noCount,
    required this.naCount,
    required this.followUp,
    required this.filledForFollowUp,
    required this.submitWithComment,
    required this.recommended_task,
  });

  factory TaskDescribe.fromJson(Map<String, dynamic> json) {
    return TaskDescribe(
      yesCount: json['yesCount'],
      noCount: json['noCount'],
      naCount: json['naCount'],
      followUp: json['followUp'],
      filledForFollowUp: json['filledForFollowUp'],
      submitWithComment: json['submitWithComment'],
      recommended_task: json['recommended_task'],
    );
  }
}
