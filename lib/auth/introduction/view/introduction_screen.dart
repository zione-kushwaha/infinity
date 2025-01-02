import 'package:flutter/material.dart';
import 'package:i/auth/authentication/view/sigup_view.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/page_constant/page_constant.dart';
import '../../authentication/view/login_view.dart';

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
            image: Lottie.asset(IntroPage.firstPage.path),
          ),
          PageViewModel(
            title: IntroPage.secondPage.title,
            body: IntroPage.secondPage.body,
            image: Lottie.asset(IntroPage.secondPage.path),
          ),
          PageViewModel(
            title: IntroPage.thirdPage.title,
            body: IntroPage.thirdPage.body,
            image: Lottie.asset(IntroPage.thirdPage.path),
          ),
        ],
        showSkipButton: true,
        skip: const Text('Skip'),
        showNextButton: true,
        next: const Icon(Icons.arrow_forward),
        showDoneButton: true,
        done: const Text('Done'),
        onDone: () {
          // Handle what happens when done button is pressed
          //save the data that the user has seen the introduction screen
          //TODO: Implement the logic to save the data

          //Navigate to the next screen
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginView();
          }));
        },
      ),
    );
  }
}
