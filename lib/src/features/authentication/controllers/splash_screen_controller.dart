import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_agro/src/ui/bottom_nav_controller.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find=> Get.find();
  RxBool animate=false.obs;
  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    // You can add navigation logic here
     await Future.delayed(Duration(milliseconds: 3500));

    if (!(Get.currentRoute == '/bottomNavController')) {
      Get.offAll(() => BottomNavController()); // Navigate to BottomNavController and clear the previous history
    }
   //Get.to(()=>BottomNavController());

  }
}