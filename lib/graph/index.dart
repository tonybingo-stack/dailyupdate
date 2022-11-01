import 'package:dailyupdate/models/userinfo.dart';
import 'package:flutter/material.dart';
import './graph.dart';
import './title.dart';
import '../cardview/cardpage.dart';

// load models
import '../models/tasks.dart';
import '../models/taskdetails.dart';
import '../models/past7data.dart';
import '../models/chartdata.dart';
import '../models/successalert.dart';
// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class GraphPage extends StatefulWidget {
  const GraphPage({
    Key? key,
    required this.myTasks,
    required this.myPast7Data,
    required this.myTaskDetailsList,
    required this.mySuccessAlert,
    required this.myInfo,
  }) : super(key: key);

  final String title = Constants.GRAPH_TITLE_TEXT;

  final Tasks myTasks;
  final List<TaskDetails> myTaskDetailsList;
  final Past7Data myPast7Data;
  final SuccessAlert mySuccessAlert;
  final UserInfo myInfo;

  @override
  // ignore: library_private_types_in_public_api
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
    backgroundColor: Constants.BUTTON_COLOR,
  );
  int taskCompletedCount = 0, taskNotFollowedCount = 0;
  List<ChartData> followChartData = [
    ChartData(7, 0),
    ChartData(6, 0),
    ChartData(5, 0),
    ChartData(4, 0),
    ChartData(3, 0),
    ChartData(2, 0),
    ChartData(1, 0)
  ];
  List<ChartData> notFollowChartData = [
    ChartData(7, 0),
    ChartData(6, 0),
    ChartData(5, 0),
    ChartData(4, 0),
    ChartData(3, 0),
    ChartData(2, 0),
    ChartData(1, 0)
  ];
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
    List<EvalFollow> myEvalFollowList = [];
    for (int i = 0; i < widget.myPast7Data.data.length; i++) {
      myEvalFollowList.add(EvalFollow.fromJson(widget.myPast7Data.data[i]));
    }

    DateTime dateOrigin = DateTime.parse(myEvalFollowList[0].eval_date);

    for (int i = 0; i < myEvalFollowList.length; i++) {
      DateTime dateNow = DateTime.parse(myEvalFollowList[i].eval_date);
      int index = dateNow.difference(dateOrigin).inDays;

      if (myEvalFollowList[i].follow_rec == "Yes") {
        taskCompletedCount++;
        followChartData[index].y = followChartData[index].y + 1;
      } else {
        taskNotFollowedCount++;
        notFollowChartData[index].y = notFollowChartData[index].y + 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(30),
      child: ListView(
        shrinkWrap: true,
        children: [
          MyTitle(
              taskCompletedCount: taskCompletedCount,
              taskNotFollowedCount: taskNotFollowedCount),
          const SizedBox(height: 30),
          MyGraph(
              followChartData: followChartData,
              notFollowChartData: notFollowChartData),
          const SizedBox(height: 40),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CardPage(
                          myInfo: widget.myInfo,
                          myTasks: widget.myTasks,
                          myTaskDetailsList: widget.myTaskDetailsList,
                          mySuccessAlert: widget.mySuccessAlert,
                        )),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
