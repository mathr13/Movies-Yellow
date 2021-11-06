import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poc_yellowc/constants/colours.dart';
import 'package:poc_yellowc/constants/labels.dart';
import 'package:poc_yellowc/constants/styles.dart';
import 'package:poc_yellowc/navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  @override _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  Animation<Offset> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    waitAndNavigate(context);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: const Offset(1, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.SECONDARY_BACKGROUND,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset("Assets/Images/insidelogo.svg"),
                // SizedBox(
                //   height: 25,
                // ),
                Text(
                  DisplayLabels.APP_NAME,
                  style: TextStyles.appLogo,
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) => Center(
              child: SlideTransition(
                position: _animation,
                child: Container(
                  height: 75,
                  color: Color(0xff16172F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void waitAndNavigate(context) async {
  await Future.delayed(Duration(seconds: 2+1));
  Get.offAllNamed(Routes.MOVIES_LIST);
}