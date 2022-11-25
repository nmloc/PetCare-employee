import 'package:dogs_park/pages/home_screens/main_page.dart';
import 'package:dogs_park/resources/colors.dart';
import 'package:dogs_park/service/notification_service.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../pages/authentication/login.dart';
import 'package:flutter/material.dart';

import 'utils/networking.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var employeePhoneNumber = prefs.getString('employeePhoneNumber');
  runApp(GetMaterialApp(
      title: 'Dog Park User App',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: Colors.white),
          primaryColor: const Color(0xFF04CEBC),
          fontFamily: 'SF Pro Display',
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w700,
            ),
            titleMedium: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w600,
            ),
            titleSmall: TextStyle(
              fontSize: 17,
              color: Color(0xFF8A8A8F),
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w400,
            ),
          )),
      home: (employeePhoneNumber == null)
          ? const LoginPage()
          : AdminApp(codeUser: employeePhoneNumber),
      debugShowCheckedModeBanner: false));
}

class UpdateTaskList extends StatelessWidget {
  const UpdateTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AdminApp extends StatefulWidget {
  const AdminApp({required this.codeUser, Key? key}) : super(key: key);
  final String codeUser;

  // This widget is the root of your application.
  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Networking.getInstance().getTaskList(widget.codeUser),
        builder: (context, snapchat) {
          if (snapchat.hasData) {
            dynamic value = snapchat.data;
            if (value == false) {
              return const MainPage();
            } else {
              DataBucket.getInstance().setMetaData(value['Metadata']);
              return const MainPage();
            }
          } else {
            return const Center(
              child: SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  backgroundColor: ColorResources.blackColor,
                  valueColor: AlwaysStoppedAnimation(ColorResources.pinkColor),
                ),
              ),
            );
          }
        });
  }
}
