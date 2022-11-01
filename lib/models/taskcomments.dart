// ignore_for_file: non_constant_identifier_names

class TaskComment {
  String task;
  int satisfied_range;
  String how_would_you_describe;
  String comment;
  int followup_comment;

  TaskComment([
    this.task = '',
    this.satisfied_range = 0,
    this.how_would_you_describe = '',
    this.comment = '',
    this.followup_comment = 0,
  ]);
}
