import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {

    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future<void> showNotification(int id, String title, String body,DateTime notificationTime) async {
    // DateTime now = DateTime(2022,10,21,15,53);

    Duration offsetTime= notificationTime.timeZoneOffset;
    tz.TZDateTime zoneTime =  tz.TZDateTime.local(notificationTime.year,notificationTime.month,notificationTime.day,notificationTime.hour,notificationTime.minute).subtract(offsetTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,zoneTime, //schedule the notification to show after 2 seconds.
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: "channelDescription",
            importance: Importance.max,
            priority: Priority.max),
        // iOS details
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
      true, // To show notification even when the app is closed
    );
  }



  Future<void> showNotification2(int id, String title, String body,int notificationTime) async {
    // DateTime now = DateTime(2022,10,21,15,53);
   // Duration offsetTime= notificationTime.timeZoneOffset;
  //  tz.TZDateTime zoneTime =  tz.TZDateTime.local(notificationTime.year,notificationTime.month,notificationTime.day,notificationTime.hour,notificationTime.minute).subtract(offsetTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,tz.TZDateTime.now(tz.local).add(Duration(seconds: notificationTime)), //schedule the notification to show after 2 seconds.
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: "channelDescription",
            importance: Importance.max,
            priority: Priority.max),
        // iOS details
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
      true, // To show notification even when the app is closed
    );
  }
}
