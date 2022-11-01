class FailureReason {
  final String task;
  final String reason;

  const FailureReason({
    required this.task,
    required this.reason,
  });
}

class NoAndNaTaskListAndCallback {
  final int index;
  final String task;
  final Function callback;

  const NoAndNaTaskListAndCallback({
    required this.index,
    required this.task,
    required this.callback,
  });
}
