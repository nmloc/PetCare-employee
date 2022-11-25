import 'package:intl/intl.dart';
import '../../pages/home_screens/components/appbar_custom.dart';
import 'package:flutter/material.dart';
import '../../resources/resource.dart';
import '../../utils/data_bucket.dart';
import 'component/item_details_common.dart';
import 'component/maps.dart';
import 'package:get/get.dart';




// ignore: must_be_immutable
class TaskDetail extends StatelessWidget {
  int index;

  TaskDetail({Key? key, required this.index}) : super(key: key);

  final taskListDetail = DataBucket.getInstance().getTaskListByDay();

  @override
  Widget build(BuildContext context) {
    //final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        tittle:Strings.taskDetail,
        appBar: AppBar(),
        backIcon: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ItemDetailCommon(
                  tittle: Strings.checkInTime,
                  description: DateFormat('dd-MM-yyyy HH:mm').format(taskListDetail[index].checkIn),
                  onTap: () {},
                ),
                ItemDetailCommon(
                  tittle: Strings.package,
                  description: taskListDetail[index].package,
                  onTap: () {},
                ),
                ItemDetailCommon(
                  tittle:Strings.packageTime,
                  description: taskListDetail[index].packageTime,
                  onTap: () {},
                ),
                ItemDetailCommon(
                    tittle: Strings.dog,
                    description: taskListDetail[index].dogName,
                    onTap: () {}),
                ItemDetailCommon(
                    tittle: Strings.customer,
                    description: taskListDetail[index].customer,
                    onTap: () {}),
                (taskListDetail[index].pickUp == 'Yes')
                    ? Column(
                        children: [
                          ItemDetailCommon(
                              tittle: Strings.pickUp,
                              description: taskListDetail[index].pickUp,
                              onTap: () {}),
                          ItemDetailCommon(
                              tittle: Strings.pickUpTime,
                              description:DateFormat('dd-MM-yyyy HH:mm').format(taskListDetail[index].pickUpTime),
                              onTap: () {}),
                          ItemDetailCommon(
                              tittle: Strings.pickUpDriver,
                              description: taskListDetail[index].driver,
                              onTap: () {}),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: GestureDetector(
                              onTap:  () {
                               Get.to(Maps(pickUpAddress: taskListDetail[index].pickUpAddress));
                              },
                              child: Container(
                                width: maxWidth,
                                  // height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: ColorResources.greyColor),
                                    color: const Color(0xFFF9F9F9)),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [Expanded(child:
                                           Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  Strings.pickUpAddress,
                                                  style: TextStyle(
                                                    color: Color(0xFF666666),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "SF Pro Display",
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 5),
                                                    child: Text(
                                                       taskListDetail[index].pickUpAddress,
                                                      style: const TextStyle(
                                                        color: Color(0xFF8A8A8F),
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "SF Pro Display",
                                                        fontSize: 15.0,
                                                    ),
                                                  ),
                                              )
                                            ],
                                  ),
                                         ),
                                           const Padding(
                                             padding: EdgeInsets.all(5.0),
                                             child: Icon(Icons.map_outlined,color: ColorResources.mainColor),
                                           )
                                         ],
                                       ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ItemDetailCommon(
                        tittle: Strings.pickUp,
                        description: taskListDetail[index].pickUp,
                        onTap: () {}
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
