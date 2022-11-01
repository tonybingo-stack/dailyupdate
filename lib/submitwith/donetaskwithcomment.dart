import 'package:flutter/material.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class DoneTaskWithComment extends StatefulWidget {
  const DoneTaskWithComment({
    Key? key,
    required this.task,
    required this.callbackForComment,
    required this.isFollowUp,
    required this.isExtraQuestion,
  }) : super(key: key);
  final String title = "Daily Update";
  final String task;
  final Function callbackForComment;
  final bool isFollowUp;
  final bool isExtraQuestion;

  @override
  // ignore: library_private_types_in_public_api
  _DoneTaskWithCommentState createState() => _DoneTaskWithCommentState();
}

class _DoneTaskWithCommentState extends State<DoneTaskWithComment> {
  bool checkedValue_1 = false;
  bool checkedValue_2 = false;
  bool checkedValue_3 = false;
  bool checkedValue_4 = false;
  bool checkedValue_5 = false;
  bool checkedValue_6 = false;
  bool checkedValue_7 = false;
  bool checkedValue_8 = false;
  bool checkedValue_9 = false;

  double _currentSliderValue = 0;
  double _currentFollowUpCommentValue = 0;
  String comment = '';
  final commentController = TextEditingController();

  bool isFollowUp = true;
  @override
  void initState() {
    super.initState();
    isFollowUp = widget.isFollowUp;
    commentController.text = '';
    comment = '';
  }

  @override
  Widget build(BuildContext context) {
    //create a CardController

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.SUBMIT_BORDER_COLOR,
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(widget.task,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                )),
            const Divider(color: Colors.black),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Icon(
                Icons.help,
                color: Color(0xFF666065),
                size: 24,
              ),
              SizedBox(width: 5),
              Text("How satisfied are you with the Recommendation?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ]),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Not happy"),
                  Text("It's okay"),
                  Text("Very happy"),
                ]),
            Slider(
              value: _currentSliderValue,
              max: 10,
              divisions: 10,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  widget.callbackForComment(
                      widget.task,
                      checkedValue_1,
                      checkedValue_2,
                      checkedValue_3,
                      checkedValue_4,
                      checkedValue_5,
                      checkedValue_6,
                      checkedValue_7,
                      checkedValue_8,
                      checkedValue_9,
                      _currentSliderValue.toInt(),
                      _currentFollowUpCommentValue.toInt(),
                      commentController.text);
                });
              },
            ),
            Text(_currentSliderValue.toInt().toString()),
            widget.isExtraQuestion
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.help,
                        color: Color(0xFF666065),
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text(
                          "From 0-10, how would you rate your effort in achieving this weeks goals? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ],
                  )
                : const SizedBox(),
            widget.isExtraQuestion
                ? Slider(
                    value: _currentFollowUpCommentValue,
                    max: 10,
                    divisions: 10,
                    onChanged: (double value) {
                      setState(() {
                        _currentFollowUpCommentValue = value;
                        widget.callbackForComment(
                            widget.task,
                            checkedValue_1,
                            checkedValue_2,
                            checkedValue_3,
                            checkedValue_4,
                            checkedValue_5,
                            checkedValue_6,
                            checkedValue_7,
                            checkedValue_8,
                            checkedValue_9,
                            _currentSliderValue.toInt(),
                            _currentFollowUpCommentValue.toInt(),
                            commentController.text);
                      });
                    },
                  )
                : const SizedBox(),
            widget.isExtraQuestion
                ? Text(_currentFollowUpCommentValue.toInt().toString())
                : SizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
              Icon(
                Icons.help,
                color: Color(0xFF666065),
                size: 24,
              ),
              SizedBox(width: 5),
              Text("How would you describe the Recommendation?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Fun"),
                      ]),
                ),
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Not Good"),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Easy"),
                      ]),
                ),
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Boring"),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Challenging"),
                      ]),
                ),
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Too Hard"),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                          value: checkedValue_7,
                          // changes the state of the switch
                          onChanged: (value) => setState(() {
                            checkedValue_7 = value;
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Effective"),
                      ]),
                ),
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                          value: checkedValue_8,
                          // changes the state of the switch
                          onChanged: (value) => setState(() {
                            checkedValue_8 = value;
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Doesn't Work"),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
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
                          value: checkedValue_9,
                          // changes the state of the switch
                          onChanged: (value) => setState(() {
                            checkedValue_9 = value;
                            widget.callbackForComment(
                                widget.task,
                                checkedValue_1,
                                checkedValue_2,
                                checkedValue_3,
                                checkedValue_4,
                                checkedValue_5,
                                checkedValue_6,
                                checkedValue_7,
                                checkedValue_8,
                                checkedValue_9,
                                _currentSliderValue.toInt(),
                                _currentFollowUpCommentValue.toInt(),
                                commentController.text);
                          }),
                        ),
                        const Text("Progressive"),
                      ]),
                ),
                const SizedBox(width: 185),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Comments',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
