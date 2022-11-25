import 'dart:ffi';

import 'package:get/get.dart';

class MainPageController extends GetxController{
  RxInt selectedIndex =1.obs;

   onItemTaped(int index){
    selectedIndex.value = index;
  }
}