import 'package:dogs_park/pages/home_screens/main_page.dart';
import 'package:dogs_park/resources/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dog_checking/common_widget/button_page_checking.dart';



class CheckingStatusPage extends StatefulWidget {
   final String namePage;
   final String status;
   final String message;


   const CheckingStatusPage({super.key, required this.status, required this.namePage, required this.message});

  @override
  State<CheckingStatusPage> createState() => _CheckingStatusPageState();
}

class _CheckingStatusPageState extends State<CheckingStatusPage> {


  @override
  Widget build(BuildContext context) {

  // double screenWidth = MediaQuery.of(context).size.width;
   double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: (widget.status!=Strings.failed)?ColorResources.mainColor:ColorResources.redColor,
                shape: BoxShape.circle,
              ),
              child:
                 Icon((widget.status!=Strings.failed)?Icons.check_circle_outline:Icons.close,color:ColorResources.whiteColor,size: 100,)
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "${widget.status} !"  ,
              style: TextStyle(
                color: (widget.status!=Strings.failed)?ColorResources.textColorCheckingStatus:ColorResources.redColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
             Text(
               (widget.status!=Strings.failed)?
              "${widget.namePage} ${Strings.completed} ":widget.message,
               style: const TextStyle(
                color: ColorResources.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              Strings.autoRedirect,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorResources.blackColor54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left:screenHeight*0.028,right:screenHeight*0.028),
                child: buttonChecking(
                  title: Strings.homePage,color:ColorResources.mainColor,context: context,
                  onPressed: () {
                  Get.offAll(const MainPage());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
