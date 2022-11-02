import 'package:dailyupdate/models/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

import './card.dart';
// Load models
import '../models/tasks.dart';
import '../models/taskdetails.dart';
import '../check/check.dart';
import '../models/successalert.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class CardPage extends StatefulWidget {
  CardPage({
    Key? key,
    required this.myTasks,
    required this.myTaskDetailsList,
    required this.mySuccessAlert,
    required this.myInfo,
  }) : super(key: key);

  final String title = Constants.CARD_TITLE_TEXT;
  final Tasks myTasks;
  final List<TaskDetails> myTaskDetailsList;
  final SuccessAlert mySuccessAlert;
  final UserInfo myInfo;

  @override
  // ignore: library_private_types_in_public_api
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int counter = 3;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //create a CardController
    SwipeableCardSectionController cardController =
        SwipeableCardSectionController();

    List<TaskDetails> myTaskDetailsList = widget.myTaskDetailsList;
    SuccessAlert mySuccessAlert = widget.mySuccessAlert;
    List<String> myTaskList = widget.myTasks.data.split('|');
    List<String> noTaskList = [];
    List<String> yesTaskList = [];
    List<String> naTaskList = [];
    List<String> myTaskStartTime = List<String>.filled(myTaskList.length, '');

    UserInfo myInfo = widget.myInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Constants.APPBAR_COLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Constants.GRAPH_TITLE_BORDER_COLOR,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                gradient: const LinearGradient(
                  colors: [
                    Constants.GRAPH_TITLE_GRADIENT_TOP_COLOR,
                    Constants.GRAPH_TITLE_GRADIENT_BOTTOM_COLOR
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Were you able to complete todays goals?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Constants.BODY_TEXT_FONT,
                ),
              ),
            ),
            SwipeableCardsSection(
              cardController: cardController,
              context: context,
              //add the first 3 cards
              items: [
                CardView(text: myTaskList[0]),
                CardView(text: myTaskList[1]),
                CardView(text: myTaskList[2]),
              ],
              onCardSwiped: (dir, index, widget) {
                // Add the next card
                if (counter < myTaskList.length) {
                  // String task = widget.taskList[counter];
                  cardController.addItem(CardView(text: myTaskList[counter]));
                  counter++;
                }

                if (dir == Direction.left) {
                  noTaskList.add(myTaskList[index]);
                  myTaskStartTime[index] =
                      DateFormat("hh-mm-ss").format(DateTime.now());
                } else if (dir == Direction.right) {
                  // noTaskList.add(newTaskList[index]);
                  yesTaskList.add(myTaskList[index]);
                  myTaskStartTime[index] =
                      DateFormat("hh-mm-ss").format(DateTime.now());
                } else if (dir == Direction.up) {
                  // noTaskList.add(newTaskList[index]);
                  naTaskList.add(myTaskList[index]);
                  myTaskStartTime[index] =
                      DateFormat("hh-mm-ss").format(DateTime.now());
                } else if (dir == Direction.down) {}

                if (index == myTaskList.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckPage(
                              myInfo: myInfo,
                              noTaskList: noTaskList,
                              yesTaskList: yesTaskList,
                              naTaskList: naTaskList,
                              myTaskDetailsList: myTaskDetailsList,
                              myTasksList: myTaskList,
                              myTaskStartTime: myTaskStartTime,
                              mySuccessAlert: mySuccessAlert,
                            )),
                  );
                }
              },
              enableSwipeUp: true,
              enableSwipeDown: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'btn_no',
                  onPressed: () => cardController.triggerSwipeLeft(),
                  backgroundColor: Constants.BUTTON_COLOR,
                  child: const Icon(Icons.thumb_down_off_alt),
                ),
                FloatingActionButton(
                  heroTag: 'btn_block',
                  onPressed: () => cardController.triggerSwipeUp(),
                  backgroundColor: Constants.BUTTON_COLOR,
                  child: const Icon(Icons.block),
                ),
                FloatingActionButton(
                  heroTag: 'btn_yes',
                  onPressed: () => cardController.triggerSwipeRight(),
                  backgroundColor: Constants.BUTTON_COLOR,
                  child: const Icon(Icons.thumb_up_off_alt),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class MyTask {
//   String task;
//   String yesnona;
//   String startTime;
//   TaskDetails taskDetails;

//   MyTask([
//     this.task = '',
//     this.yesnona = '',
//     this.startTime = '',
//     this.taskDetails = const TaskDetails(
//         status: 'success',
//         message: 'none',
//         data: TaskDescribe(
//           yesCount: 0,
//           noCount: 0,
//           naCount: 0,
//           followUp: false,
//           filledForFollowUp: false,
//           submitWithComment: false,
//           recommended_task: '',
//         )),
//   ]);
// }
