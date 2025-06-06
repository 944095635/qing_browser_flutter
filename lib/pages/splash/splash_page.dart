import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qing/pages/frame/frame_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(
        () => const FramePage(),
        transition: Transition.fade,
        duration: Durations.extralong2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Qing",
          style: TextStyle(
            fontSize: 64,
            fontFamily: "Prompt",
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
