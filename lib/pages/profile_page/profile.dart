import 'package:dogs_park/pages/home_screens/components/appbar_custom.dart';
import 'package:dogs_park/pages/profile_page/employee_information.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../resources/resource.dart';
import 'components/common_list_title.dart';
import 'others/other.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
  //  final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    // bool isChecked = false;
    return Scaffold(
      appBar:AppBarCustom(backIcon: false,appBar: AppBar(),tittle: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Container(
              width: maxWidth,
              color: const Color(0xFF666666).withOpacity(0.5) ,
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
              child: const Text(
                "INFORMATION",style: TextStyle(color: ColorResources.textDarkColor),
              ),
            ),
            ListTileWidget(
              title: 'Account', onPressed: (){Get.to( const EmployeeInformation());},
            ),
             Container(
               width: maxWidth,
               color: const Color(0xFF666666).withOpacity(0.5) ,
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
              child: const Text(
                "SECURITY & AUTHENTICATION",style: TextStyle(color: ColorResources.textDarkColor),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: ColorResources.textDarkColor,
              ),
              child: Column(
                children:  [
                  ListTileWidget(
                    onPressed: (){},
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => FaqPage())),
                    title: 'Login by FaceID',
                  ),
                ],
              ),
            ),
            Container(
              width: maxWidth,
              color: const Color(0xFF666666).withOpacity(0.5) ,
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
              child: const Text(
                "OTHERS...",style: TextStyle(color: ColorResources.textDarkColor)
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                children: [
                  ListTileWidget(
                    onPressed: (){Get.to( FaqPage());},
                     title: 'FAQ',
                  ),
                  const Divider (color: ColorResources.blackColor,height:0),
                  ListTileWidget(
                    onPressed: (){
                      Get.to( VersionInfoPages());},
                    title: 'Version',

                  ),
                  const Divider (color: ColorResources.blackColor,height:0),
                  ListTileWidget(
                    onPressed: (){
                      Get.to( Tern());},
                     title: 'Term of Use',
                  ),
                  const Divider (color: ColorResources.blackColor,height:0),
                  ListTileWidget(
                    onPressed: (){
                       Get.to(PaymentPolicyPages());},
                    title: 'Payment Policy',
                  ),
                  const Divider (color: ColorResources.blackColor,height:0),
                  ListTileWidget(
                    onPressed: (){Get.to( CompanyProfilePages());},
                    title: 'Company Profile',
                  ),
                  const Divider (color: ColorResources.blackColor,height:0),
                ],
              ),
            ),
            // SizedBox(
            //   height: maxHeight*0.07,
            //     width: maxWidth,
            //     child: ElevatedButton(style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(ColorResources.mainColor)),onPressed: (){}, child: const Text("LOG OUT")))
          ],
        ),
      ),
    );
  }
}
