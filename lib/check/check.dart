import 'package:dailyupdate/models/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

import './comments.dart';
// Load models
import '../models/successalert.dart';
import '../models/taskdetails.dart';
import '../models/failure.dart';

import '../success/success.dart';
import '../submitwith/submit.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class CheckPage extends StatefulWidget {
  const CheckPage({
    Key? key,
    required this.noTaskList,
    required this.yesTaskList,
    required this.naTaskList,
    required this.myTasksList,
    required this.myTaskDetailsList,
    required this.mySuccessAlert,
    required this.myInfo,
    required this.myTaskStartTime,
  }) : super(key: key);

  final String title = "Check";
  final SuccessAlert mySuccessAlert;
  final List<String> myTasksList;
  final List<TaskDetails> myTaskDetailsList;
  final List<String> noTaskList;
  final List<String> yesTaskList;
  final List<String> naTaskList;
  final List<String> myTaskStartTime;
  final UserInfo myInfo;

  @override
  // ignore: library_private_types_in_public_api
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  bool isSubmitWithNoComments = false;
  bool submitWithComment = false;
  bool submitWithNoComment = true;
  bool isExtraQuestion = false;
  final commentController = TextEditingController();
  List<NoAndNaTaskListAndCallback> noAndNaTaskListAndCallbackList = [];
  List<FailureReason> failureReasonList = [];
  bool isValid = false;
  List<bool> isValidForTaskList = [];

  @override
  void initState() {
    super.initState();
    isValid = false;
    isExtraQuestion = false;
    failureReasonList = [];
    commentController.text = '';
    if (widget.noTaskList.isEmpty) isValid = true;
    int index = 0;
    for (int i = 0; i < widget.myTasksList.length; i++) {
      if (widget.myTaskDetailsList[i].data.yesCount +
                  widget.myTaskDetailsList[i].data.noCount +
                  widget.myTaskDetailsList[i].data.naCount >
              3 &&
          !widget.myTaskDetailsList[i].data.submitWithComment) {
        submitWithComment = true;
        // print("here");
      }
      if (!widget.myTaskDetailsList[i].data.filledForFollowUp &&
          widget.myTaskDetailsList[i].data.followUp) {
        submitWithComment = true;
        // print("there");
        isExtraQuestion = true;
      }
      if (widget.noTaskList.contains(widget.myTasksList[i])) {
        noAndNaTaskListAndCallbackList.add(NoAndNaTaskListAndCallback(
            index: index,
            task: widget.myTasksList[i],
            callback: CallbackForNoNa));
        index++;
        failureReasonList
            .add(FailureReason(task: widget.myTasksList[i], reason: ""));
        isValidForTaskList.add(false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> callSubmitWithNoCommentsAPI() async {
    String url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/addPatientFollowReq";

    for (int i = 0; i < widget.myTasksList.length; i++) {
      String startTime = widget.myTaskStartTime[i];
      String endTime = DateFormat("hh-mm-ss").format(DateTime.now());
      var format = DateFormat("hh-mm-ss");
      var one = format.parse(startTime);
      var two = format.parse(endTime);

      String timeDiffer = two.difference(one).toString();

      var body = widget.yesTaskList.contains(widget.myTasksList[i])
          ? json.encode({
              "follow_rec": "Yes",
              "recommended_task": widget.myTasksList[i],
              "mobile_number": widget.myInfo.mobile_number,
              "eval_date": widget.myInfo.eval_date,
              "start_Time": startTime,
              "end_Time": endTime,
              "time_diff": timeDiffer,
              "daily_comment": commentController.text,
              "submit_with_comments": "No",
              "filled_for_followup": "No",
            })
          : widget.noTaskList.contains(widget.myTasksList[i])
              ? json.encode({
                  "follow_rec": "No",
                  "failure_reason": failureReasonList
                      .firstWhere(
                          (element) => element.task == widget.myTasksList[i])
                      .reason,
                  "recommended_task": widget.myTasksList[i],
                  "mobile_number": widget.myInfo.mobile_number,
                  "eval_date": widget.myInfo.eval_date,
                  "start_Time": startTime,
                  "end_Time": endTime,
                  "time_diff": timeDiffer,
                  "daily_comment": commentController.text,
                  "submit_with_comments": "No",
                  "filled_for_followup": "No",
                })
              : json.encode({
                  "follow_rec": "NA",
                  "failure_reason": failureReasonList
                      .firstWhere(
                          (element) => element.task == widget.myTasksList[i])
                      .reason,
                  "recommended_task": widget.myTasksList[i],
                  "mobile_number": widget.myInfo.mobile_number,
                  "eval_date": widget.myInfo.eval_date,
                  "start_Time": startTime,
                  "end_Time": endTime,
                  "time_diff": timeDiffer,
                  "daily_comment": commentController.text,
                  "submit_with_comments": "No",
                  "filled_for_followup": "No",
                });
      // print(
      //     '$startTime : $endTime : $timeDiffer: ${failureReasonList[i].reason}');
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
    print("All Action is Done!");
    return 'success';
  }

  void CallbackForNoNa(
    int index,
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
    bool checkVal10,
    bool checkVal11,
    bool checkVal12,
    bool checkVal13,
    String comment,
    bool isValidTask,
  ) {
    String reason = '';
    bool flag = false;
    if (checkVal1) {
      reason = '${reason}Too hard';
      flag = true;
    }
    if (checkVal2) {
      if (flag) reason = '$reason|';
      reason = "${reason}Couldn't find time";
      flag = true;
    }
    if (checkVal3) {
      if (flag) reason = '$reason|';
      reason = '${reason}Work';
      flag = true;
    }
    if (checkVal4) {
      if (flag) reason = '$reason|';
      reason = '${reason}Injury/Sickness';
      flag = true;
    }
    if (checkVal5) {
      if (flag) reason = '$reason|';
      reason = '${reason}Forgot';
      flag = true;
    }
    if (checkVal6) {
      if (flag) reason = '$reason|';
      reason = '${reason}No mention';
      flag = true;
    }
    if (checkVal7) {
      if (flag) reason = '$reason|';
      reason = '${reason}Too tired';
      flag = true;
    }
    if (checkVal8) {
      if (flag) reason = '$reason|';
      reason = "${reason}Mental health";
      flag = true;
    }
    if (checkVal9) {
      if (flag) reason = '$reason|';
      reason = '${reason}Familly/Social engagement';
      flag = true;
    }
    if (checkVal10) {
      if (flag) reason = '$reason|';
      reason = '${reason}Traveling';
      flag = true;
    }
    if (checkVal11) {
      if (flag) reason = '$reason|';
      reason = '${reason}Unexpected';
      flag = true;
    }
    if (checkVal12) {
      if (flag) reason = '$reason|';
      reason = '${reason}Not enjoying goal';
      flag = true;
    }
    if (checkVal13) {
      if (flag) reason = '$reason|';
      reason = '${reason}Other|$comment';
      flag = true;
    }

    //Update myTaskList
    FailureReason newReason = FailureReason(task: task, reason: reason);
    failureReasonList[index] = newReason;
    isValidForTaskList[index] = isValidTask;

    isValid = !isValidForTaskList.contains(false);

    // print("Updated $index th TaskComment.");
  }

  @override
  Widget build(BuildContext context) {
    //create a CardController
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
      backgroundColor: Constants.BUTTON_COLOR,
    );

    SuccessAlert mySuccessAlert = widget.mySuccessAlert;
    List<String> myTasksList = widget.myTasksList;
    List<TaskDetails> myTaskDetailsList = widget.myTaskDetailsList;
    List<String> noTaskList = widget.noTaskList;
    List<String> yesTaskList = widget.yesTaskList;
    List<String> naTaskList = widget.naTaskList;
    UserInfo myInfo = widget.myInfo;

    return isSubmitWithNoComments
        ? FutureBuilder(
            future: callSubmitWithNoCommentsAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                isSubmitWithNoComments = false;
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
                return Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: Constants.BODY_TEXT_FONT,
                      fontWeight: FontWeight.bold),
                );
              }
              // By default, show a loading spinner.
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  backgroundColor: Constants.APPBAR_COLOR,
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 30),
                      Text("Performing Actions ..."),
                    ],
                  ),
                ),
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: Constants.APPBAR_COLOR,
            ),
            body: ListView(
              children: [
                ...(noAndNaTaskListAndCallbackList).map((taskAndCallback) {
                  return Comment(
                      index: taskAndCallback.index,
                      task: taskAndCallback.task,
                      myCallback: taskAndCallback.callback);
                }).toList(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                      children: [
                        const Text(
                          'Do you like to share any thoughts or feelings today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Constants.CHECK_TASK_FONT,
                            fontWeight: FontWeight.bold,
                            color: Constants.CHECK_TASK_TEXT_COLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Use this box to record your thoughts/feelings along this journey! You can also use it to send the team @ Health Guider feedback. We want to make this an exceptional experience!',
                            // labelText:
                            //     'Do you like to share any thoughts or feelings today?',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                        ),
                      ],
                    )),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          style: style,
                          onPressed: submitWithComment
                              ? (() {
                                  if (isValid) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubmitPage(
                                              myInfo: myInfo,
                                              yesTaskList: yesTaskList,
                                              myTaskDetailsList:
                                                  myTaskDetailsList,
                                              myTasksList: myTasksList,
                                              naTaskList: naTaskList,
                                              noTaskList: noTaskList,
                                              myTaskStartTime:
                                                  widget.myTaskStartTime,
                                              failureReasonList:
                                                  failureReasonList,
                                              dailyComment:
                                                  commentController.text,
                                              mySuccessAlert: mySuccessAlert,
                                              isExtraQuestion:
                                                  isExtraQuestion)),
                                    );
                                  } else {
                                    setState(() {
                                      Fluttertoast.showToast(
                                        msg:
                                            "please mark the closest reason or reasons for not doing the task",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color.fromARGB(
                                            255, 143, 141, 141),
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    });
                                  }
                                })
                              : null,
                          child: const Text(
                            'Submit with Comments',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          style: style,
                          onPressed: submitWithNoComment
                              ? (() {
                                  if (isValid) {
                                    setState(() {
                                      isSubmitWithNoComments = true;
                                    });
                                  } else {
                                    setState(() {
                                      Fluttertoast.showToast(
                                        msg:
                                            "please mark the closest reason or reasons for not doing the task",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color.fromARGB(
                                            255, 143, 141, 141),
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    });
                                  }
                                })
                              : null,
                          child: const Text(
                            'Submit with no comments',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
  }
}
