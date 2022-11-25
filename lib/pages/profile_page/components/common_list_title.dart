
import 'package:flutter/material.dart';

import '../../../resources/resource.dart';

class ListTileWidget extends StatelessWidget {
 final String title;
 final Function() onPressed;

  const ListTileWidget({super.key, required this.title, required this.onPressed});


 @override
 Widget build(BuildContext context) {
  return GestureDetector(
   onTap:(){ onPressed.call();},
   child: Container(
    color: ColorResources.whiteColor70
    ,
     child: Column(
       children: [
         ListTile(
          title: Text(title,style:const TextStyle(color: ColorResources.textLightColor),),
          trailing: const Icon(Icons.chevron_right,color: ColorResources.textLightColor,),
         ),

       ],
     ),
   ),
  );
 }
}
class ListLanguage extends StatelessWidget{
 final String title;
 final Function onPressed;
 final Icons icon;


  const ListLanguage(this.title, this.onPressed,this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
    onTap: onPressed.call(),
    child: ListTile(
     title: Text(title),
     trailing: const Icon(Icons.check),
    ),
   );
  }

}