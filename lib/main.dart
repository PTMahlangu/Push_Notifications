import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/notification.dart';

Future<void> backgroundNotification(RemoteMessage message) async {
  
  PushNotification.showNotification(message,1);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotification.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundNotification);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Push Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {

      if (message != null) {

        PushNotification.showNotification(message, index);
        index++;
      }
    });
    // foreground
    FirebaseMessaging.onMessage.listen((message) {

      if (message.notification != null) {
     
        PushNotification.showNotification(message, index);
        index++;
      }
    });
    // called when a user presses a notification message displayed
    FirebaseMessaging.onMessageOpenedApp.listen((message) {

      //  Go somewhere
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push Notification Test',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
