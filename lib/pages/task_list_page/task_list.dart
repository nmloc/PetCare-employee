import 'package:dogs_park/resources/resource.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import '../../controllers/controller.dart';
import '../../pages/task_list_page/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_screens/components/appbar_custom.dart';
import 'component/item_common.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final taskListController = Get.put(TaskListController());
  final DateTime _currentTime = DateTime.now();
  String? dropdownValue;
  String zone = "";
  List<String> zoneList = ['All Employee','Nguyen Ngoc Yen', 'Trinh Van Thuong', 'Do Mai Huong', 'Le Cong Minh Khoi'];

  @override
  void initState() {
    super.initState();
    taskListController.initDate();
  }


  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    //final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBarCustom(appBar: AppBar(), tittle: "Daily task", backIcon: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: ColorResources.whiteColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 22),
                decoration: const BoxDecoration(
                    color: ColorResources.calendarBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                    // bottomLeft: Radius.circular(50),
                    // bottomRight: Radius.circular(50),

                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Obx(
                      () => HorizontalCalendar(
                        lastDate:
                            DateTime(_currentTime.year, _currentTime.month + 1),
                        showMonth: true,
                        date: taskListController.selectedDate.value,
                        textColor: ColorResources.greyColorShade600,
                        backgroundColor: ColorResources.calendarBackgroundColor,
                        initialDate: DateTime(_currentTime.year,
                            _currentTime.month, _currentTime.day - 7),
                        selectedColor: ColorResources.mainColor,
                        onDateSelected: (date) {
                          taskListController.onChangeDate(
                              DateFormat("yyyy-MM-dd").parse(date.toString()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                //height: 600,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.task,
                            style: GoogleFonts.montserrat(
                              color: ColorResources.blackColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                            //  borderRadius: BorderRadius.all(Radius.circular(10)),
                              //dropdownColor: Colors.black,
                              isExpanded: false,
                              hint: Text(
                                Strings.selectEmployee,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              value: dropdownValue,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  zone = newValue;
                                });
                              },
                              items: zoneList
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: ColorResources.mainColor),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LiquidPullToRefresh(
                      springAnimationDurationInMilliseconds: 500,
                      showChildOpacityTransition: false,
                      color: ColorResources.whiteColor,
                      height: maxHeight*0.1,
                      backgroundColor: ColorResources.mainColor,
                      onRefresh: () => taskListController.updateEmployee(),
                      child: Obx(
                        () => (taskListController.taskListByDay.isEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: ((context, index) => Center(
                                      child: SizedBox(
                                          height: maxHeight,
                                          child: const Text(Strings.noTask),),)
                                  ),
                                ),)
                            : Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: SizedBox(
                                  height: maxHeight,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          taskListController.taskListByDay.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ItemCommon(
                                          index: index,
                                          ownerName: taskListController
                                              .taskListByDay[index].customer,
                                          dogName: taskListController
                                              .taskListByDay[index].dogName,
                                          checkInTime: taskListController
                                              .taskListByDay[index].checkIn,
                                          onTap: () {
                                            Get.to(TaskDetail(index: index));
                                          },
                                          pickUp: taskListController
                                              .taskListByDay[index].pickUp,
                                          img: taskListController
                                              .taskListByDay[index].image,
                                        );
                                      }),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
