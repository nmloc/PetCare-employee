import 'package:dogs_park/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(onPressed: () {
              NotificationService().showNotification2(0, "title", "hello world 1",2);
            }, child: const Text("Send Noftication")),
            ElevatedButton(onPressed: () {
              NotificationService().showNotification2(1, "title2", "hello world 2",10);
            }, child: const Text("Send 2")),
            // ElevatedButton(onPressed: () {
            //   notificationsServices.scheduleNotification("title", "xin hay mo app len");
            // }, child: Text("Schedule Noftication")),
            ElevatedButton(onPressed: () {}, child: Text("Stop Noftication")),
          ],
        ),
      ),
    );
  }
}
