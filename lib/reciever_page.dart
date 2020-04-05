import 'dart:async';
import 'package:flutter/services.dart';

import 'fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RecieverPage extends StatefulWidget {
  @override
  _RecieverPageState createState() => _RecieverPageState();
}

final databaseReference = FirebaseDatabase.instance.reference();
String basic = '0:00', timechanged;
int minutes = 0, seconds = 0;

class _RecieverPageState extends State<RecieverPage> {
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: Colors.green[900],
          body: Center(
            child: Text(
              minutes == 0 && seconds == 0
                  ? "Thanks for your Time!"
                  : "${minutes.toString()}:${seconds.toString()}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 76.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          )),
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
