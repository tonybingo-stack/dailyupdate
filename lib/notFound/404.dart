import 'package:dailyupdate/main.dart';
import 'package:flutter/material.dart';

// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  // ignore: library_private_types_in_public_api
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
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
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
      backgroundColor: Constants.BUTTON_COLOR,
    );
    return Padding(
      padding: const EdgeInsets.all(50),
      child: ListView(
        children: [
          const SizedBox(
            height: 200,
          ),
          const Icon(
            Icons.no_accounts,
            color: Color.fromARGB(200, 197, 26, 26),
            size: 100,
            semanticLabel: "",
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(200, 0, 0, 0)),
          ),
          const SizedBox(
            height: 150,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const MyApp()),
                  ModalRoute.withName(
                      '/') // Replace this with your root screen's route name (usually '/')
                  );
            },
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}
