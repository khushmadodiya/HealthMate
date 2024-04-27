import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/Screens/chatbot.dart';
import 'package:health_mate/Screens/helth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_mate/Screens/httpresponse.dart';
import 'package:health_mate/Screens/nearbyservices.dart';
import 'package:health_mate/Screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../Notification Services/notification_services.dart';
import '../Notification Services/notifications.dart';
import '../provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:android_intent/android_intent.dart';

class HealthMainScreen extends StatefulWidget {
  final id;
  const HealthMainScreen({super.key, this.id});

  @override
  State<HealthMainScreen> createState() => _HealthMainScreenState();
}

class _HealthMainScreenState extends State<HealthMainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var token;
  NotificationServices notificationServices = NotificationServices();
  bool isdata = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationServices.requestNotificationPermission();
    // notificationServices.forgroundMessage();
    // notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     print('device token');
    //     print(value);
    //   }
    // });
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    fetchDetail();
  }
  Future<void> submit() async {
    try {
      final url = 'http://13.48.136.54:8000/api/api-code/';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer 60ea5369-5d67-4d9d-8de6-04bd9712d766',
        },
        body: jsonEncode('data'),
      );

      if (response.statusCode == 200) {
        print('Request successful');
        Fluttertoast.showToast(msg: 'successful');
        var data = json.decode(response.body);
        print('Response body: ${response.body}');
        print(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HTTPResponse(data: data['api_code']),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: 'Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "error : $e");
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    dynamic profilesnap = context.watch<AppState>().firstSnapshot;
    return isdata
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.deepPurple,
            )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  'HealthMate',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              actions: [
                // Expanded(child: SelectableText(token)),
                IconButton(
                    onPressed: () {
                      // send notification from one device to another
                      // _scheduleAlarm();
                      // AndroidIntent intent = AndroidIntent(
                      //   action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
                      //   data: 'package:your.package.name',
                      // );
                      // intent.launch();
                      // LocalNotifications.showSimpleNotification(
                      //     title: "Schedule Notification",
                      //     body: "This is a Schedule Notification",
                      //     payload: "This is schedule data");
                      submit();
                      // LocalNotifications.cancel(1);
                    },
                    icon: Icon(Icons.send,color: Colors.white,)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    name: profilesnap['username'],
                                    email: profilesnap['email'],
                                  )));
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${profilesnap['profile']}'),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                dividerColor: Colors.white,
                unselectedLabelColor: Colors.grey[400],
                indicatorColor: Colors.deepPurple,
                tabs: [
                  Tab(
                    child: Text(
                      'Health Notifier',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'MedBot',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Tab(child: Text('Emergency',style: TextStyle(fontSize: 15),),),
                  // Tab(text: 'Tab 3'),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                HealthNotifierScreen(),
                Chatbot(),
                Emergency()
                // BotWeb(),
              ],
            ),
          );
  }

  Future<void> fetchDetail() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Provider.of<AppState>(context, listen: false).firstSnapshot = snapshot;
      print('Second Snapshot: ${snapshot['username']}');
      isdata = false;
      setState(() {});
    } catch (e) {
      // Fluttertoast.showToast(msg: 'Some error occured');

    }
  }

  static const _alarmId = 0;

  Future<void> _scheduleAlarm() async {
    //   await AndroidAlarmManager.oneShot(
    //     Duration(minutes: 5),
    //     _alarmId,
    //     _sendNotificationRequest,
    //     exact: true,
    //     wakeup: true,
    //   );
    // }

    // void _sendNotificationRequest() async {
    // notificationServices.getDeviceToken().then((value) async {
    //   var data = {
    //     'to': value.toString(),
    //     'notification': {
    //       'title': 'Hii',
    //       'body': 'Hello this is Khushvant',
    //       "sound": "jetsons_doorbell.mp3"
    //     },
    //     'android': {
    //       'notification': {
    //         'notification_count': 23,
    //       },
    //     },
    //     'data': {'1': 'hello', '2': 'Khushvant'}
    //   };
    //
    //   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //       body: jsonEncode(data),
    //       headers: {
    //         'Content-Type': 'application/json; charset=UTF-8',
    //         'Authorization':
    //             'key=AAAA9k7YWXY:APA91bG9KOA1S0TwsIorf20JKDQgDcZT4EfB_P7VVfWkLgGff4u-iYSFXctmHUvPZxvUBJKzgECDAQ9L1jwv1v0XmEAnM3wrhv97hGnvL7M8Yx1K5Tjdtqa0TNdNZZGnQKgSvWdL_DGh'
    //       }).then((value) {
    //     if (kDebugMode) {
    //       print(value.body.toString());
    //     }
    //   }).onError((error, stackTrace) {
    //     if (kDebugMode) {
    //       print(error);
    //     }
    //   });
    // });
  }
}
