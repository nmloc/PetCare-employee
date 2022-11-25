import 'package:dogs_park/pages/home_screens/components/appbar_custom.dart';
import 'package:dogs_park/pages/task_list_page/component/item_details_common.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dogs_park/controllers/controller.dart';
import '../../resources/resource.dart';

class EmployeeInformation extends StatefulWidget {
  const EmployeeInformation({Key? key}) : super(key: key);

  @override
  State<EmployeeInformation> createState() => _EmployeeInformationState();
}

class _EmployeeInformationState extends State<EmployeeInformation> {
  final employeeData = DataBucket.getInstance().getEmployeeInformation();
  final employeeController = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {

    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;



    return Scaffold(
      appBar: AppBarCustom(
          appBar: AppBar(), backIcon: true, tittle: "Employee information"),
      body: Container(
        padding:const EdgeInsets.all(20),
        child: Column(
          children:<Widget> [
            ItemDetailCommon(tittle: Strings.fullName, description: employeeData[0].fullName, onTap: (){}),
            ItemDetailCommon(tittle: Strings.phoneNumber, description: employeeData[0].phoneNumber, onTap: (){}),
            ItemDetailCommon(tittle: Strings.dateOfBirth, description: DateFormat("dd/MM/yyyy").format(employeeData[0].dateOfBirth), onTap: (){}),
            ItemDetailCommon(tittle: Strings.isModerator, description: employeeData[0].isModerator.toString(), onTap: (){}),
        Container(
          margin:const EdgeInsets.only(top: 15),
          height: 50,
          width: maxWidth,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(ColorResources.mainColor)),
            onPressed: () {
            employeeController.logOut();
            },
            child: const Text(
              Strings.logOut,
              style: TextStyle(
                color: ColorResources.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
