import 'package:dailyupdate/models/successalert.dart';
import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
// ignore: library_prefixes
import '../assets/constants.dart' as Constants;

class SuccessPage extends StatefulWidget {
  const SuccessPage({
    Key? key,
    required this.mySuccessAlert,
  }) : super(key: key);

  final String title = "Daily Update";
  final SuccessAlert mySuccessAlert;

  @override
  // ignore: library_private_types_in_public_api
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
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
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
      backgroundColor: Constants.BUTTON_COLOR,
    );
    SuccessAlert mySuccessAlert = widget.mySuccessAlert;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Constants.APPBAR_COLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF00E676),
              size: 100,
              semanticLabel: "",
            ),
            const SizedBox(height: 20),
            Text(mySuccessAlert.alert_name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10),
            const Text("Suggestion for you: Plan your goals",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                )),
            const SizedBox(height: 20),
            Image(
              image: NetworkImage(
                  '${Constants.DOMAIN_NAME}fr_end/${mySuccessAlert.img_links}'),
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(mySuccessAlert.alert_desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                )),
            const SizedBox(height: 10),
            LinkText(
                "Please click below link to watch/read some interesting information https://tinyurl.com//2p85p8cp",
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
                // You can optionally handle link tap event by yourself
                onLinkTap: (url) => {launch(url)}),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()),
                    ModalRoute.withName(
                        '/') // Replace this with your root screen's route name (usually '/')
                    );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }
}
