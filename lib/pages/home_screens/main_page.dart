import 'package:dogs_park/controllers/main_page_controller.dart';
import 'package:dogs_park/resources/colors.dart';
import 'package:flutter/material.dart';
import '../profile_page/profile.dart';
import '../task_list_page/task_list.dart';
import 'home_screen.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainPageController = Get.put(MainPageController());
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const TasksPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _widgetOptions.elementAt(mainPageController.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Checking"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined), label: "Task list"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          currentIndex: mainPageController.selectedIndex.value,
          //  selectedFontSize: 20,
          selectedItemColor: ColorResources.mainColor,
          onTap: (index) => mainPageController.onItemTaped(index),
        ),
      ),
    );
  }
}
