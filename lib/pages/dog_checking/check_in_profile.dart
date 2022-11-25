import 'package:dogs_park/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../resources/resource.dart';
import '../../utils/networking.dart';
import '../home_screens/components/checking_status.dart';
import 'common_widget/button_page_checking.dart';

class CheckInProfile extends StatefulWidget {
  final String? code;

  const CheckInProfile({super.key, this.code});

  @override
  // ignore: library_private_types_in_public_api
  _CheckInProfileState createState() => _CheckInProfileState();
}

// ignore: camel_case_types
class _CheckInProfileState extends State<CheckInProfile> {
 // List<String> zoneList = ['Zone 1', 'Zone 2', 'Zone 3', 'Zone 4'];
  final checkInController = Get.put(CheckInController());

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: Networking.getInstance().getDogData(widget.code.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          if (data['Dog'][0]['Tracking'][0]['CheckInStatus'] != Strings.yes) {
            return CheckingStatusPage(
              status: Strings.failed,
              namePage: Strings.checkIn,
              message: "${Strings.youNotCheckOutAt} ${data['Dog'][0]['Tracking'][0]['Zone']}",
            );
          }
          checkInController.setDogCheckInData(data);
          checkInController.getZone();
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                  color: ColorResources.textColor, onPressed: () => Get.back()),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: const Text(
                Strings.checkInProfile,
                style: TextStyle(
                  color: ColorResources.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Stack(children: [
                      Hero(
                        tag: 'ID',
                        child: SizedBox(
                          width: maxWidth,
                          height: maxHeight * 0.35,
                          child: checkInController.listDogData[0].image,
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
                                  color: ColorResources.textColor),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              checkInController.listDogData[0].dogName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                checkInController.isMale
                                    ? Icons.male
                                    : Icons.female,
                                color: checkInController.isMale
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
                                checkInController.listDogData[0].dogBreed,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "${checkInController.listDogData[0].weight} ${Strings.kg}",
                                style: TextStyle(color: ColorResources.greyColorShade600),
                              ),
                              Text(
                                checkInController.listDogData[0].dateOfBirth,
                                style: TextStyle(color: ColorResources.greyColorShade600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            checkInController.listDogData[0].ownerName,
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
                          color: ColorResources.greyColorShade200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            Strings.lastCheckIn,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            checkInController.listDogData[0].checkInTime,
                            style: TextStyle(color: ColorResources.greyColorShade600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorResources.greyColorShade300),
                          color: ColorResources.greyColorShade200),
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                Strings.selectZone,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              value: checkInController.dropdownValue.value,
                              elevation: 16,
                              onChanged: (String? newValue) {
                                checkInController.dropdownValue.value =
                                    newValue!;
                              },
                              items: checkInController.listZone.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        color: ColorResources.mainColor),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonChecking(
                            title: Strings.refuse,
                            color: ColorResources.pinkColor,
                            context: context,
                            onPressed: () {
                              checkInController.refuseButton();
                            }),
                        buttonChecking(
                          title: Strings.accept,
                          color: ColorResources.mainColor,
                          context: context,
                          onPressed: () async {
                            checkInController.acceptButton();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
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
