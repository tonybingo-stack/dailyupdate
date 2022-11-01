import 'package:dailyupdate/notFound/404.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

import './graph/index.dart';

// load models
import './models/tasks.dart';
import './models/taskdetails.dart';
import './models/past7data.dart';
import './models/successalert.dart';
import './models/userinfo.dart';

// ignore: library_prefixes
import './assets/constants.dart' as Constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: Constants.TITLE_TEXT),
      debugShowCheckedModeBanner: true,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ResponseData {
  final Tasks myTasks;
  final List<TaskDetails> myTaskDetailsList;
  final Past7Data myPast7Data;
  final SuccessAlert mySuccessAlert;
  final UserInfo myInfo;

  const ResponseData({
    required this.myPast7Data,
    required this.myTaskDetailsList,
    required this.myTasks,
    required this.mySuccessAlert,
    required this.myInfo,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = LocalStorage('dailyupdate');
  final phoneController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  late ResponseData myResponseData;
  late Tasks myTasks;
  late Past7Data myPast7Data;
  late SuccessAlert mySuccessAlert;
  late List<TaskDetails> myTaskDetailsList = [];
  late UserInfo myInfo;

  bool isLoading = false;
  bool isFisrtLoading = false;

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now();
    phoneController.text = '';
    myTaskDetailsList = [];
    myInfo = UserInfo(phoneController.text,
        DateFormat("yyyy-MM-dd").format(selectedDateTime));
    storage.ready;
  }

  @override
  void dispose() {
    phoneController.dispose();
    storage.dispose();
    super.dispose();
  }

  // Define API call
  Future<ResponseData> fetchDataFromAPICall() async {
    // Add phone number to local storage.
    myInfo.mobile_number = phoneController.text;
    try {
      await storage.ready;
      await storage.setItem("phone", myInfo.mobile_number);
    } on Exception catch (e) {
      throw Exception("Local storage error: $e");
    }
    // Call the first API to fetch tasks.
    print("Start Tasks fetching...");

    String url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getPatientRecommendedTask";
    var body = json.encode({"mobile_number": myInfo.mobile_number});
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode != 200) {
      throw Exception('Error while fetching tasks');
    }
    myTasks = Tasks.fromJson(jsonDecode(response.body));
    print("Tasks fetching Success!");

    // Call the second API to fetch details for each tasks.
    List<String> myTasksList = myTasks.data.split('|');
    print(myTasksList.length);
    url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getCountForRecTaskByMobileNumber";
    print("Start TasksDetails fetching...${myTaskDetailsList.length}");

    for (int i = 0; i < myTasksList.length; i++) {
      body = json.encode({
        "mobile_number": myInfo.mobile_number,
        "rec_task": myTasksList[i],
      });
      response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode != 200) {
        throw Exception('Error while fetching ${i}th Task details.');
      }
      myTaskDetailsList.add(TaskDetails.fromJson(json.decode(response.body)));
    }
    print("TasksDetails fetching Success!${myTaskDetailsList.length}");

    print("Start Past 7 Data fetching...");

    // Call third API to fetch past 7 days data.
    url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getPatientLastStatusResponsesByMobileNumber";
    body = json.encode({
      "mobile_number": myInfo.mobile_number,
      "from_date": DateFormat('yyyy-MM-dd')
          .format(selectedDateTime.subtract(const Duration(days: 7))),
      "to_date": DateFormat('yyyy-MM-dd').format(selectedDateTime),
    });

    response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode != 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      throw Exception('Error while fetching past 7 days data');
    }
    myPast7Data = Past7Data.fromJson(jsonDecode(response.body));

    print("Past 7 Data fetching Success!");
    // Call forth API to fetch data for alert
    print("Start ALert data fetching...");

    url =
        "${Constants.DOMAIN_NAME}doctorweb/public/index.php/api/patient/getRandAlert";

    response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      throw Exception('Error while fetching Alert data');
    }
    mySuccessAlert = SuccessAlert.fromJson(jsonDecode(response.body));
    print("All done!");
    return ResponseData(
      myPast7Data: myPast7Data,
      myTaskDetailsList: myTaskDetailsList,
      myTasks: myTasks,
      mySuccessAlert: mySuccessAlert,
      myInfo: myInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: Constants.BUTTON_TEXT_FONT),
      backgroundColor:
          isLoading ? const Color(0x6700E676) : Constants.BUTTON_COLOR,
    );
    myTaskDetailsList = [];

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Constants.APPBAR_COLOR,
      ),
      body: isLoading
          ? FutureBuilder<ResponseData>(
              future: fetchDataFromAPICall(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  isLoading = false;
                  return GraphPage(
                    myInfo: snapshot.data!.myInfo,
                    myTasks: snapshot.data!.myTasks,
                    myPast7Data: snapshot.data!.myPast7Data,
                    myTaskDetailsList: snapshot.data!.myTaskDetailsList,
                    mySuccessAlert: snapshot.data!.mySuccessAlert,
                  );
                } else if (snapshot.hasError) {
                  isLoading = false;
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const NotFoundPage(
                  //             message:
                  //                 "There is no goals defined for this user")),
                  //   );
                  // });

                  return const NotFoundPage(
                      message: "There is no goals defined for this user");
                }

                // By default, show a loading spinner.
                return AbsorbPointer(
                  child: Stack(
                    children: [
                      Container(
                        color: const Color(0xFF717671),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        // Center is a layout widget. It takes a single child and positions it
                        // in the middle of the parent.
                        child: Column(
                          // Column is also a layout widget. It takes a list of children and
                          // arranges them vertically. By default, it sizes itself to fit its
                          // children horizontally, and tries to be as tall as its parent.
                          //
                          // Invoke "debug painting" (press "p" in the console, choose the
                          // "Toggle Debug Paint" action from the Flutter Inspector in Android
                          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                          // to see the wireframe for each widget.
                          //
                          // Column has various properties to control how it sizes itself and
                          // how it positions its children. Here we use mainAxisAlignment to
                          // center the children vertically; the main axis here is the vertical
                          // axis because Columns are vertical (the cross axis would be
                          // horizontal).
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  Constants.BODY_TEXT,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Constants.BODY_TEXT_FONT,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.history),
                              ],
                            ),
                            const SizedBox(height: 80),
                            DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.event_note),
                                labelText: 'Current Date',
                              ),
                              initialValue: selectedDateTime,
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              // validator: (e) => (e?.day ?? 0) == 1
                              //     ? 'Please not the first day'
                              //     : null,
                              onDateSelected: (DateTime value) {
                                selectedDateTime = value;
                                myInfo.eval_date =
                                    DateFormat("yyyy-MM-dd").format(value);
                              },
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              autofocus: false,
                              controller: phoneController,
                              // onChanged: (value) => setState(() => phoneNumber = value),
                              // onChanged: (value){print(phoneController.text);},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone',
                                hintText: 'Phone number',
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: style,
                              onPressed: () {
                                setState(() => isLoading = true);
                              },
                              child: const Text('Search'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : FutureBuilder(
              // future: getItemFromLocalStorage("phone"),
              future: storage.ready,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == true) {
                  if (storage.getItem("phone") == null) {
                    phoneController.text = '';
                    isFisrtLoading = true;
                  } else {
                    phoneController.text = storage.getItem("phone");
                  }
                  return Padding(
                    padding: const EdgeInsets.all(30),
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      //
                      // Invoke "debug painting" (press "p" in the console, choose the
                      // "Toggle Debug Paint" action from the Flutter Inspector in Android
                      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                      // to see the wireframe for each widget.
                      //
                      // Column has various properties to control how it sizes itself and
                      // how it positions its children. Here we use mainAxisAlignment to
                      // center the children vertically; the main axis here is the vertical
                      // axis because Columns are vertical (the cross axis would be
                      // horizontal).
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              Constants.BODY_TEXT,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Constants.BODY_TEXT_FONT,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.history),
                          ],
                        ),
                        const SizedBox(height: 80),
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Current Date',
                          ),
                          initialValue: selectedDateTime,
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          // validator: (e) => (e?.day ?? 0) == 1
                          //     ? 'Please not the first day'
                          //     : null,
                          onDateSelected: (DateTime value) {
                            selectedDateTime = value;
                            myInfo.eval_date =
                                DateFormat("yyyy-MM-dd").format(value);
                          },
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: phoneController,
                          // onChanged: (value) => setState(() => phoneNumber = value),
                          // onChanged: (value){print(phoneController.text);},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            hintText: 'Phone number',
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: style,
                          onPressed: () {
                            if (phoneController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Phone number required",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              setState(() => isLoading = true);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const NotFoundPage(
                              //           message:
                              //               "There is no goals defined for this user")),
                              // );
                            }
                          },
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Something go wrong while fetching local data!"),
                        ]),
                  );
                }

                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 30),
                        Text("Loading ..."),
                      ]),
                );
              },
            ),
    );
  }
}
