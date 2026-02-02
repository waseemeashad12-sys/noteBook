import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notebook/views/login_view.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Get.offAll(() => Login());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("images/5.png"),
            ),
          ],
        ),
      ),
    );
  }
}
