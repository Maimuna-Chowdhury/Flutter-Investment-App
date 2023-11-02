import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:investment_agro/constant/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investment_agro/constant/image_strings.dart';
import 'package:investment_agro/constant/sizes.dart';
import 'package:investment_agro/src/features/authentication/controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {


  final splashScreenController=Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashScreenController.startAnimation();
    return Scaffold(
      backgroundColor: AppColors.light_green,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: splashScreenController.animate.value ? 150 : -30,
            left:100,
            child: Image(image: AssetImage(tSplashTopIcon)),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 400,
              left: splashScreenController.animate.value ? 50 : -90,
              child:AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splashScreenController.animate.value?1:0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Investment App',
                        style: TextStyle(
                            color: Color(0xFF006436),
                            fontWeight: FontWeight.bold,
                            fontSize: 40.sp)),
                    Text('          Happy Farmer, Happy Nation',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp)),
                  ],
                ),
              )

          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: splashScreenController.animate.value ? 100 : -30,
            left: 90,
            child: Image(image: AssetImage(tSplashImage)),
          ),
          Positioned(
            bottom: 40,
            right: tDefaultSize,
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
