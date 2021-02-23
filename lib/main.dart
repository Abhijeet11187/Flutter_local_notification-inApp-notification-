import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Local Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future _generateNotification() async {
    print("--- In the function Generate Notification");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    var iOSDetails = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSDetails);
    print("Showing Notification !!!");
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void initState() {
    super.initState();
    print("In the init state");
    // AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    // IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings();
    _initialization();
  }

  _initialization() async {
    print("In the initialization function");

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    print("initializationSettingsAndroid added");
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    print('initializationSettingsIOS Added');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    print("initializationSettings Added");
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print("notificationAppLaunchDetails Added");
  }

  Future _onSelectNotification(String data) {
    print("On notification selected ");
    print("Data is $data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Notification Demo',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateNotification,
        tooltip: 'Increment',
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }
}
