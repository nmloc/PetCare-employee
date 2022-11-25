import 'package:dogs_park/controllers/controller.dart';
import 'package:dogs_park/resources/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;

class ItemCommon extends StatefulWidget {
  final String dogName;
  final String ownerName;
  final DateTime checkInTime;
  final Function() onTap;
  final String pickUp;
  final Image img;
  final int index;

  const ItemCommon(
      {super.key,
      required this.dogName,
      required this.ownerName,
      required this.checkInTime,
      required this.onTap,
      required this.pickUp,
      required this.img,
      required this.index});

  @override
  State<ItemCommon> createState() => _ItemCommonState();
}

class _ItemCommonState extends State<ItemCommon> {
  final controller = Get.put(TaskListController());
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }



  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    //final double maxWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: GestureDetector(
          onTap: () {
            widget.onTap.call();
          },
          child: Container(
            //height: maxHeight*0.09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Colors.white),
              color: controller.getColorAndNotificationByTime(widget.checkInTime, widget.index).withOpacity(0.9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                          height: maxHeight * 0.13,
                          width: maxHeight * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(width: 2, color: Colors.white70),
                          //  color: const Color(0xFFEFEFF4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                FittedBox(fit: BoxFit.cover, child: widget.img),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.dogName,
                              style: const TextStyle(
                                  fontFamily: "SF Pro Display",
                                  color: ColorResources.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 10),
                              child: Text(
                                widget.ownerName,
                                style: const TextStyle(
                                    fontFamily: "SF Pro Display",
                                    color: ColorResources.whiteColor70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            Text(
                              DateFormat('HH:mm').format(widget.checkInTime),
                              style: const TextStyle(color: ColorResources.whiteColor,fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  (widget.pickUp == Strings.yes)
                      ? const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.drive_eta_rounded,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
