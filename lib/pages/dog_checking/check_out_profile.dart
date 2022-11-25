import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/networking.dart';
import '../home_screens/components/checking_status.dart';
import 'common_widget/button_page_checking.dart';
import 'package:dogs_park/resources/resource.dart';
import 'package:dogs_park/controllers/controller.dart';

class CheckOutProfile extends StatefulWidget {
  final String? code;

  const CheckOutProfile({super.key, this.code});

  @override
  // ignore: library_private_types_in_public_api
  _CheckOutProfileState createState() => _CheckOutProfileState();
}

// ignore: camel_case_types
class _CheckOutProfileState extends State<CheckOutProfile> {
  final checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: Networking.getInstance().getDogData(widget.code.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          if (data['Dog'][0]['Tracking'][0]['CheckOutStatus'] != Strings.yes) {
            return const CheckingStatusPage(
                status: Strings.failed,
                namePage: Strings.checkOut,
                message: Strings.failedCheckOut);
          }
          checkOutController.setDogCheckOutData(data);
          return Scaffold(
              appBar: AppBar(
                leading: BackButton(
                    color: ColorResources.blackColor, onPressed: () => Get.back()),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                title: const Text(
                  Strings.checkOutProfile,
                  style: TextStyle(
                    color: ColorResources.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,

              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    Stack(children: [
                      Hero(
                        tag: 'ID',
                        child: SizedBox(
                          width: maxWidth,
                          height: maxHeight * 0.35,
                          child: checkOutController.listDogData[0].image,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Container(
                            color: ColorResources.whiteColor,
                            child: IconButton(
                              iconSize: 30,
                              onPressed: () {},
                              icon: const Icon(Icons.qr_code_2,
                                  color: ColorResources.blackColor),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Row(children: [
                            Text(
                              checkOutController.listDogData[0].dogName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                checkOutController.isMale
                                    ? Icons.male
                                    : Icons.female,
                                color: checkOutController.isMale
                                    ? ColorResources.blueColor
                                    : ColorResources.pinkColor,
                                size: 18,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                checkOutController.listDogData[0].dogBreed,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "${checkOutController.listDogData[0].weight} ${Strings.kg}",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              Text(
                                checkOutController.listDogData[0].dateOfBirth,
                                //DateFormat('dd/MM/yyyy').format(snapshot.data['Dog'][0]['DateOfBirth']),
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            checkOutController.listDogData[0].ownerName,
                            style: const TextStyle(
                              color: ColorResources.mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorResources.greyColorShade300),
                          color:  ColorResources.greyColorShade200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                           Strings.checkInTimeTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            checkOutController.listDogData[0].checkInTime,
                            style: TextStyle(color: ColorResources.greyColorShade600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorResources.greyColorShade300),
                          color: ColorResources.greyColorShade200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            Strings.duration,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            checkOutController.duration(),
                            style: TextStyle(color:ColorResources.greyColorShade600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonChecking(
                          title: Strings.cancel,
                          color: ColorResources.pinkColor,
                          context: context,
                          onPressed: () {
                            checkOutController.refuseButton();
                          },
                        ),
                        buttonChecking(
                            title: Strings.accept,
                            color: ColorResources.mainColor,
                            context: context,
                            onPressed: () {
                              checkOutController.acceptButton();
                            }),
                      ],
                    ),
                  ]),
                ),
              ));
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                child: Text("${snapshot.error}"),
              ),
            ),
          );
        }
        // By default, show a loading spinner.
        return const Scaffold(
          body: Center(
            child: SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                backgroundColor: ColorResources.blueColor,
                valueColor: AlwaysStoppedAnimation(ColorResources.pinkColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
