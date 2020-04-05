import 'dart:async';
import 'package:flutter/services.dart';

import 'fluttertoast.dart';
import 'package:flutter/material.dart';
import 'rizme_button.dart';
import 'package:firebase_database/firebase_database.dart';

TextEditingController controller = TextEditingController();

class SenderPage extends StatefulWidget {
  @override
  _SenderPageState createState() => _SenderPageState();
}

String basic = '0:00', timechanged;
int minutes = 0, seconds = 0;

class _SenderPageState extends State<SenderPage> {
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Do you want to CLOSE the application?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  FlatButton(
                    child: Text("NO!"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ));
    }

    var media = MediaQuery.of(context).size;
    bool empty = false;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.green[900],
        body: Center(
          child: Container(
            width: media.width,
            height: media.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  minutes == 0 && seconds == 0
                      ? "Thanks for your Time!"
                      : "Time left for speaker\n${minutes.toString()}:${seconds.toString()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                Container(
                    width: media.width,
                    height: media.height / 3,
                    child: Image.asset(
                      'assets/logo.png',
                    )),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: controller,
                  cursorWidth: 0.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter Minutes here!",
                      labelStyle: TextStyle(
                        wordSpacing: 2,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      helperText: "Maximum 3 digits.",
                      helperStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      prefix: Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      border: OutlineInputBorder(),
                      errorText: empty ? "MUST enter time" : null),
                ),
                SizedBox(
                  height: 5.0,
                ),
                RizmeButton(
                  text: "Start Timer",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  borderRadius: 10.0,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      sendTime();
                    } else {}
                  },
                  backColor: Colors.grey[600],
                  width: media.width / 1.1,
                  splashColor: Colors.green,
                ),
                SizedBox(
                  height: 5.0,
                ),
                RizmeButton(
                  text: "Reset Timer",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  borderRadius: 10.0,
                  onPressed: () {
                    resetTime();
                  },
                  backColor: Colors.grey[600],
                  width: media.width / 1.1,
                  splashColor: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      _start = int.parse(snapshot.value.toString());
    });
    listenToFirebase();
  }

  int starter() {
    databaseReference.once().then((DataSnapshot snapshot) {
      _start = int.parse(snapshot.value.toString());
    });
  }

  void listenToFirebase() {
    FirebaseDatabase.instance
        .reference()
        .child("Time")
        .child("Minutes")
        .onValue
        .listen((Event user) {
      setState(() {
        _timer.cancel();
        _start = int.parse(user.snapshot.value.toString());
        startTimer();
      });
    });
    startTimer();
  }

  @override
  void initState() {
    _start = 0;
    getData();
    super.initState();
  }

  Timer _timer;
  int _start;

  void startTimer() {
    if (_start == 1) {
      minutes = 0;
      seconds = 59;
    }
    if (_start == 0) {
      minutes = 0;
      seconds = 0;
    } else {
      minutes = _start - 1;
      seconds = 59;
    }
    const oneSec = const Duration(
      seconds: 1,
    );
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (minutes == 0 && seconds == 0) {
                _timer.cancel();
              } else {
                setState(() {
                  seconds -= 1;
                  if (seconds < 1) {
                    if (minutes > 0) {
                      minutes -= 1;
                      seconds = 59;
                    }
                  }
                });
              }
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final databaseReference = FirebaseDatabase.instance.reference();
void sendTime() {
  databaseReference.child("Time").set({
    'Minutes': controller.text.toString(),
  });
}

void resetTime() {
  databaseReference.child("Time").set({
    'Minutes': "0",
  });
}
