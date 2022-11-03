// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:dailyupdate/models/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:dailyupdate/models/successalert.dart';

import './donetaskwithcomment.dart';
import '../success/success.dart';
import '../models/taskdetails.dart';
import '../models/taskcomments.dart';
import '../models/failure.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class SubmitPage extends StatefulWidget {
  const SubmitPage({
    Key? key,
    required this.yesTaskList,
    required this.myTasksList,
    required this.myTaskDetailsList,
    required this.noTaskList,
    required this.naTaskList,
    required this.mySuccessAlert,
    required this.myInfo,
    required this.myTaskStartTime,
    required this.failureReasonList,
    required this.dailyComment,
    required this.isExtraQuestion,
  }) : super(key: key);

  final String title = "Submit with comments";
  final SuccessAlert mySuccessAlert;
  final List<String> myTasksList;
  final List<TaskDetails> myTaskDetailsList;
  final List<String> noTaskList;
  final List<String> yesTaskList;
  final List<String> naTaskList;
  final UserInfo myInfo;
  final List<String> myTaskStartTime;
  final List<FailureReason> failureReasonList;
  final String dailyComment;
  final bool isExtraQuestion;

  @override
  // ignore: library_private_types_in_public_api
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  late List<TaskComment> myTaskCommentList = [];
  bool isSubmitWithComment = false;
  bool isValid = false;
  List<bool> isValidForTaskList = [];

  @override
  void initState() {
    super.initState();
    isValidForTaskList = [];
    isValid = false;
    for (int i = 0; i < widget.myTasksList.length; i++) {
      myTaskCommentList.add(TaskComment(widget.myTasksList[i]));
      isValidForTaskList.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> callSubmitWithCommentsAPI() async {
    String url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/addPatientDailyStatus";

    for (int i = 0; i < widget.myTasksList.length; i++) {
      String startTime = widget.myTaskStartTime[i];
      String endTime = DateFormat("hh-mm-ss").format(DateTime.now());

      var format = DateFormat("hh-mm-ss");
      var one = format.parse(startTime);
      var two = format.parse(endTime);

      String timeDiffer = two.difference(one).toString();

      var body = widget.yesTaskList.contains(widget.myTasksList[i])
          ? json.encode({
              "satisfied_range": myTaskCommentList[i].satisfied_range,
              "how_would_you_describe":
                  myTaskCommentList[i].how_would_you_describe,
              "comment": myTaskCommentList[i].comment,
              "mobile_number": widget.myInfo.mobile_number,
              "eval_date": widget.myInfo.eval_date,
              "start_Time": startTime,
              "end_Time": endTime,
              "time_diff": timeDiffer,
              "submit_with_comments": "Yes",
              "filled_for_followup": widget.isExtraQuestion ? "Yes" : "No",
              "follow_rec": "Yes",
              "recommended_task": widget.myTasksList[i],
              "daily_comment": widget.dailyComment,
              "followup_comment": myTaskCommentList[i].followup_comment,
            })
          : widget.noTaskList.contains(widget.myTasksList[i])
              ? json.encode({
                  "satisfied_range": myTaskCommentList[i].satisfied_range,
                  "how_would_you_describe":
                      myTaskCommentList[i].how_would_you_describe,
                  "comment": myTaskCommentList[i].comment,
                  "mobile_number": widget.myInfo.mobile_number,
                  "eval_date": widget.myInfo.eval_date,
                  "start_Time": startTime,
                  "end_Time": endTime,
                  "time_diff": timeDiffer,
                  "submit_with_comments": "Yes",
                  "filled_for_followup": widget.isExtraQuestion ? "Yes" : "No",
                  "follow_rec": "No",
                  "recommended_task": widget.myTasksList[i],
                  "failure_reason": widget.failureReasonList
                      .firstWhere(
                          (element) => element.task == widget.myTasksList[i])
                      .reason,
                  "daily_comment": widget.dailyComment,
                  "followup_comment": myTaskCommentList[i].followup_comment,
                })
              : json.encode({
                  "satisfied_range": myTaskCommentList[i].satisfied_range,
                  "how_would_you_describe":
                      myTaskCommentList[i].how_would_you_describe,
                  "comment": myTaskCommentList[i].comment,
                  "mobile_number": widget.myInfo.mobile_number,
                  "eval_date": widget.myInfo.eval_date,
                  "start_Time": startTime,
                  "end_Time": endTime,
                  "time_diff": timeDiffer,
                  "submit_with_comments": "Yes",
                  "filled_for_followup": widget.isExtraQuestion ? "Yes" : "No",
                  "follow_rec": "NA",
                  "recommended_task": widget.myTasksList[i],
                  // "failure_reason": widget.failureReasonList
                  //     .firstWhere(
                  //         (element) => element.task == widget.myTasksList[i])
                  //     .reason,
                  "daily_comment": widget.dailyComment,
                  "followup_comment": myTaskCommentList[i].followup_comment,
                });
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode != 200) {
        throw Exception('Error while follow request.');
      }
    }
    // Call API1
    // url =
    //     "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getPatientFollowUpDetails";
    // var body = json.encode({
    //   "mobile_number": widget.myInfo.mobile_number,
    // });
    // var response = await http.post(Uri.parse(url),
    //     headers: {"Content-Type": "application/json"}, body: body);
    // if (response.statusCode != 200) {
    //   throw Exception('Error while API1.');
    // }
    // Call API2
    // url =
    //     "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getSuggByCalSt";
    // body = json.encode({
    //   "mobile_number": widget.myInfo.mobile_number,
    // });
    // response = await http.post(Uri.parse(url),
    //     headers: {"Content-Type": "application/json"}, body: body);
    // if (response.statusCode != 200) {
    //   throw Exception('Error while API2.');
    // }

    return 'success';
  }

  void callbackForComment(
    String task,
    bool checkVal1,
    bool checkVal2,
    bool checkVal3,
    bool checkVal4,
    bool checkVal5,
    bool checkVal6,
    bool checkVal7,
    bool checkVal8,
    bool checkVal9,
    int currentSliderVal,
    int _currentFollowUpCommentValue,
    String comment,
    bool isValidTask,
  ) {
    TaskComment myComment = TaskComment(
        task, currentSliderVal, '', comment, _currentFollowUpCommentValue);
    String howWouldYouDescribe = '';

    bool flag = false;
    if (checkVal1) {
      howWouldYouDescribe = '${howWouldYouDescribe}Fun';
      flag = true;
    }
    if (checkVal2) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Not Good';
      flag = true;
    }
    if (checkVal3) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Easy';
      flag = true;
    }
    if (checkVal4) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Boring';
      flag = true;
    }
    if (checkVal5) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Challenging';
      flag = true;
    }
    if (checkVal6) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Too hard';
      flag = true;
    }
    if (checkVal7) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Effective';
      flag = true;
    }
    if (checkVal8) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = "${howWouldYouDescribe}Doesn't work";
      flag = true;
    }
    if (checkVal9) {
      if (flag) howWouldYouDescribe = '$howWouldYouDescribe|';
      howWouldYouDescribe = '${howWouldYouDescribe}Progressive';
      flag = true;
    }
    myComment.how_would_you_describe = howWouldYouDescribe;

    //Update myTaskList
    int index = widget.myTasksList.indexOf(task);
    myTaskCommentList[index] = myComment;
    isValidForTaskList[index] = isValidTask;

    isValid = !isValidForTaskList.contains(false);
    print(isValid);
    print(isValidForTaskList);
  }

  @override
  Widget build(BuildContext context) {
    //create a CardController
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
      backgroundColor: Constants.BUTTON_COLOR,
    );

    SuccessAlert mySuccessAlert = widget.mySuccessAlert;
    List<TaskListAndCallback> myTaskAndCallback = [];

    for (int i = 0; i < widget.myTasksList.length; i++) {
      myTaskAndCallback.add(TaskListAndCallback(
        task: widget.myTasksList[i],
        callback: callbackForComment,
        isFollowUp: widget.myTaskDetailsList[i].data.followUp,
        isExtraQuestion: widget.isExtraQuestion,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Constants.APPBAR_COLOR,
      ),
      body: isSubmitWithComment
          ? FutureBuilder(
              future: callSubmitWithCommentsAPI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  isSubmitWithComment = false;
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(
                          mySuccessAlert: mySuccessAlert,
                        ),
                      ),
                    );
                  });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: Constants.BODY_TEXT_FONT,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                }
                // By default, show a loading spinner.
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 30),
                      Text("Performing Actions ..."),
                    ],
                  ),
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.all(30),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constants.CHECK_BORDER_COLOR,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      gradient: const LinearGradient(
                        colors: [
                          Constants.SUBMIT_BOX_TOP_COLOR,
                          Constants.SUBMIT_BOX_BOTTOM_COLOR
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Fill Recommended tasks Experience",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...(myTaskAndCallback.map((taskandcallback) {
                    return DoneTaskWithComment(
                      task: taskandcallback.task,
                      callbackForComment: taskandcallback.callback,
                      isFollowUp: taskandcallback.isFollowUp,
                      isExtraQuestion: taskandcallback.isExtraQuestion,
                    );
                  })),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      if (isValid) {
                        setState(() {
                          isSubmitWithComment = true;
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "please complete all field",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor:
                              const Color.fromARGB(255, 143, 141, 141),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}

class TaskListAndCallback {
  final String task;
  final Function callback;
  final bool isFollowUp;
  final bool isExtraQuestion;

  const TaskListAndCallback({
    required this.task,
    required this.callback,
    required this.isFollowUp,
    required this.isExtraQuestion,
  });
}
