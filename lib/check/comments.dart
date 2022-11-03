import 'package:flutter/material.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class Comment extends StatefulWidget {
  const Comment(
      {super.key,
      required this.task,
      required this.myCallback,
      required this.index});
//   Comment({Key? key, required this.task}) : super(key: key);
  final String task;
  final Function myCallback;
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final commentController = TextEditingController();
  // This is value for options
  bool checkedValue_1 = false;
  bool checkedValue_2 = false;
  bool checkedValue_3 = false;
  bool checkedValue_4 = false;
  bool checkedValue_5 = false;
  bool checkedValue_6 = false;
  bool checkedValue_7 = false;
  bool checkedValue_8 = false;
  bool checkedValue_9 = false;
  bool checkedValue_10 = false;
  bool checkedValue_11 = false;
  bool checkedValue_12 = false;
  bool checkedValue_13 = false;

  bool isMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isValidNow() {
    return (checkedValue_1 |
        checkedValue_2 |
        checkedValue_3 |
        checkedValue_4 |
        checkedValue_5 |
        checkedValue_6 |
        checkedValue_7 |
        checkedValue_8 |
        checkedValue_9 |
        checkedValue_10 |
        checkedValue_11 |
        checkedValue_12 |
        (checkedValue_13 & commentController.text.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    //create a CardController
    int index = widget.index;
    // Function widget.myCallback = widget.callback;
    String task = widget.task;
    bool isValid = isValidNow();
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Constants.CHECK_BORDER_COLOR,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: const LinearGradient(
              colors: [
                Constants.CHECK_BOX_TOP_COLOR,
                Constants.CHECK_BOX_BOTTOM_COLOR
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  widget.task,
                  style: const TextStyle(
                    fontSize: Constants.CHECK_TASK_FONT,
                    fontWeight: FontWeight.bold,
                    color: Constants.CHECK_TASK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isValid
                          ? Constants.CHECK_BORDER_COLOR
                          : Constants.CHECK_BORDER_ERROR_COLOR,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_1,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_1 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Too hard"),
                          ),
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_2,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_2 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Couldn't find time"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_3,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_3 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Work"),
                          ),
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_4,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_4 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Injury/Sickness"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_5,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_5 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Forgot"),
                          ),
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_6,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_6 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("No mention"),
                          ),
                        ],
                      ),
                      isMore
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_7,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_7 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Too tired"),
                                ),
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_8,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_8 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Mental health"),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      isMore
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_9,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_9 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Family/Social Engagement"),
                                ),
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_10,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_10 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Travelling"),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      isMore
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_11,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_11 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Unexpected Situation"),
                                ),
                                Expanded(
                                  child: Switch(
                                    // thumb color (round icon)
                                    activeColor:
                                        Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                                    activeTrackColor: Constants
                                        .TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                                    inactiveThumbColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                                    inactiveTrackColor: Constants
                                        .TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                                    splashRadius: 50.0,
                                    // boolean variable value
                                    value: checkedValue_12,
                                    // changes the state of the switch
                                    onChanged: (value) => setState(() {
                                      checkedValue_12 = value;
                                      isValid = isValidNow();
                                      widget.myCallback(
                                        index,
                                        task,
                                        checkedValue_1,
                                        checkedValue_2,
                                        checkedValue_3,
                                        checkedValue_4,
                                        checkedValue_5,
                                        checkedValue_6,
                                        checkedValue_7,
                                        checkedValue_8,
                                        checkedValue_9,
                                        checkedValue_10,
                                        checkedValue_11,
                                        checkedValue_12,
                                        checkedValue_13,
                                        commentController.text,
                                        isValid,
                                      );
                                    }),
                                  ),
                                ),
                                const Expanded(
                                  child: Text("Not enjoying goal"),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: checkedValue_13,
                              // changes the state of the switch
                              onChanged: (value) => setState(() {
                                checkedValue_13 = value;
                                isValid = isValidNow();
                                widget.myCallback(
                                  index,
                                  task,
                                  checkedValue_1,
                                  checkedValue_2,
                                  checkedValue_3,
                                  checkedValue_4,
                                  checkedValue_5,
                                  checkedValue_6,
                                  checkedValue_7,
                                  checkedValue_8,
                                  checkedValue_9,
                                  checkedValue_10,
                                  checkedValue_11,
                                  checkedValue_12,
                                  checkedValue_13,
                                  commentController.text,
                                  isValid,
                                );
                              }),
                            ),
                          ),
                          const Expanded(
                            child: Text("Other"),
                          ),
                          Expanded(
                            child: Switch(
                              // thumb color (round icon)
                              activeColor: Constants.TOGGLE_BUTTON_ACTIVE_COLOR,
                              activeTrackColor:
                                  Constants.TOGGLE_BUTTON_ACTIVE_TRACK_COLOR,
                              inactiveThumbColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_THUMB_COLOR,
                              inactiveTrackColor:
                                  Constants.TOGGLE_BUTTON_INACTIVE_TRACK_COLOR,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: isMore,
                              // changes the state of the switch
                              onChanged: (value) =>
                                  setState(() => isMore = value),
                            ),
                          ),
                          const Expanded(
                            child: Text("More options..."),
                          ),
                        ],
                      ),
                      checkedValue_13
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                              child: TextField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                // keyboardType: TextInputType.multiline,
                                // maxLines: 6,
                                onChanged: (value) => setState(() {
                                  isValid = isValidNow();
                                  widget.myCallback(
                                    index,
                                    task,
                                    checkedValue_1,
                                    checkedValue_2,
                                    checkedValue_3,
                                    checkedValue_4,
                                    checkedValue_5,
                                    checkedValue_6,
                                    checkedValue_7,
                                    checkedValue_8,
                                    checkedValue_9,
                                    checkedValue_10,
                                    checkedValue_11,
                                    checkedValue_12,
                                    checkedValue_13,
                                    commentController.text,
                                    isValid,
                                  );
                                }),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
