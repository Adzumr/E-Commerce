import 'package:flutter/material.dart';
import '../../models/welcome_model.dart';
import 'app_assets.dart';
import 'app_constants.dart';

class Helper {
  static Color green = const Color(0xFF198155);
  static List<IntroductionMessage> introductionMessges = [
    IntroductionMessage(
      image: AppAssets().introImage,
      title: "Welcome",
      subtitle:
          "Welcome to ${AppConstants().appName}, your all-in-one utility services app!",
    ),
    IntroductionMessage(
      image: AppAssets().introImage,
      title: "Purchase Data and Airtime",
      subtitle:
          "Top up your phone with ease! Purchase data and airtime anytime, anywhere.",
    ),
    IntroductionMessage(
      image: AppAssets().introImage,
      title: "Pay Bills",
      subtitle:
          "Say goodbye to long queues! Pay your cable and electricity bills hassle-free.",
    ),
    IntroductionMessage(
      image: AppAssets().introImage,
      title: "Exam PINs",
      subtitle:
          "Need exam PINs? ${AppConstants().appName} has you covered. Easily purchase NECO, WEAC, and JAMB PINs.",
    ),
  ];
}
