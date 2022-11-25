import 'package:dogs_park/service/notification_test.dart';
import 'package:flutter/material.dart';
import 'package:dogs_park/resources/resource.dart';
import 'package:get/get.dart';
class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String tittle;
  final AppBar appBar;
  final bool backIcon;

   const AppBarCustom({super.key, required this.tittle, required this.appBar,required this.backIcon});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell( onTap: () {},
        child: (backIcon==true)?  IconButton(
          icon:const Icon(
          Icons.arrow_back_ios,
          color: ColorResources.blackColor,),onPressed:() {Get.back();},):const Icon(
          Icons.subject,
          color: ColorResources.blackColor,)
      ),
      actions: [ InkWell( onTap: () {},
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child:  (backIcon==true)? const Icon(
            Icons.menu_outlined,
            color: ColorResources.blackColor,): IconButton(
           icon:const Icon( Icons.notifications),
            onPressed: (){Get.to(const NotificationTest());},
            color: ColorResources.blackColor,)
        ),
      ),
      ],
      title:  Text( tittle,
        style: const TextStyle(
            fontSize: 17,
            color: ColorResources.blackColor,
            letterSpacing: 0.53),
      ),
      centerTitle: true,
      backgroundColor: ColorResources.mainColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
