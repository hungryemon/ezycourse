import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  // ignore: unused_field
  final SplashController _splashController =
      Get.find(tag: (SplashController).toString());

  @override
  void initState() {
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConstants.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32.w),
            child: Image.asset(AssetConstants.logo),
          ),
        ),
      ),
    );
  }
}
