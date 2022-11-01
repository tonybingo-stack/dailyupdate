import 'package:flutter/material.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class MyTitle extends StatefulWidget {
  const MyTitle(
      {Key? key,
      required this.taskCompletedCount,
      required this.taskNotFollowedCount})
      : super(key: key);
  final int taskCompletedCount;
  final int taskNotFollowedCount;

  @override
  // ignore: library_private_types_in_public_api
  _MyTitleState createState() => _MyTitleState();
}

class _MyTitleState extends State<MyTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.GRAPH_TITLE_BORDER_COLOR,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        gradient: const LinearGradient(
          colors: [
            Constants.GRAPH_TITLE_GRADIENT_TOP_COLOR,
            Constants.GRAPH_TITLE_GRADIENT_BOTTOM_COLOR
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Last 7 day's response",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const Divider(
              color: Colors.green,
            ),
            Text(
              "You have successfully completed ${widget.taskCompletedCount} tasks on time and not followed ${widget.taskNotFollowedCount} tasks in last 7 days",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
