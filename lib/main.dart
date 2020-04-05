import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:aces_timer/rizme_button.dart';
import 'sender_page.dart';
import 'reciever_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    title: "ACES Timer",
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _portraitModeOnly();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: ChoicePage(),
      title: new Text(
        'Life Changing Experience',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      image: new Image.asset('assets/logo.png'),
      backgroundColor: Colors.green[900],
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      loaderColor: Colors.white,
      loadingText: Text(
        "Developed by Mohamed El-Marakby",
        style: TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );
  }

  @override
  void dispose() {
    _enableRotation();
    super.dispose();
  }
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void _enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}



class ChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: media.width,
                height: media.height / 2,
                child: Image.asset(
                  'assets/logo.png',
                )),
            SizedBox(
              height: 5.0,
            ),
            RizmeButton(
              text: "Time Sender",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              borderRadius: 10.0,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SenderPage()),
                );
              },
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 24.0,
              ),
              backColor: Colors.grey[600],
              width: media.width / 1.1,
              height: media.height / 10,
              splashColor: Colors.green,
            ),
            SizedBox(
              height: 20.0,
            ),
            RizmeButton(
              text: "Time Reciever",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              borderRadius: 10.0,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecieverPage()),
                );
              },
              icon: Icon(
                Icons.call_received,
                color: Colors.white,
                size: 24.0,
              ),
              backColor: Colors.grey[600],
              width: media.width / 1.1,
              height: media.height / 10,
              splashColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
