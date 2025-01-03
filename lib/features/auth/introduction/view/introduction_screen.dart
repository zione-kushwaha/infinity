import 'package:flutter/material.dart';
import 'package:i/core/constant/color_constant.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/page_constant/page_constant.dart';

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: IntroPage.firstPage.title,
            body: IntroPage.firstPage.body,
            decoration: PageDecoration(
                bodyAlignment: Alignment.centerLeft,
                titleTextStyle: TextStyle(
                    color: ColorConstant().second,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            image: Lottie.asset(IntroPage.firstPage.path),
          ),
          PageViewModel(
            title: IntroPage.secondPage.title,
            decoration: PageDecoration(
                titleTextStyle: TextStyle(
                    color: ColorConstant().second,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            body: IntroPage.secondPage.body,
            image: Lottie.asset(IntroPage.secondPage.path),
          ),
          PageViewModel(
            title: IntroPage.thirdPage.title,
            decoration: PageDecoration(
                titleTextStyle: TextStyle(
                    color: ColorConstant().second,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            body: IntroPage.thirdPage.body,
            image: Lottie.asset(IntroPage.thirdPage.path),
          ),
        ],
        showSkipButton: true,
        skip: Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ColorConstant().first)),
        showNextButton: true,
        next: Icon(Icons.arrow_forward, color: ColorConstant().first),
        showDoneButton: true,
        done: Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ColorConstant().first)),
        onSkip: () {
          //Navigate to the next screen
          Navigator.pushNamed(context, '/login');
        },
        onDone: () {
          //Navigate to the next screen
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
