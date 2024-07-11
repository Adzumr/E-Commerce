import 'package:commerce_app/core/utils/app_constants.dart';

import '../../models/welcome_model.dart';
import 'app_assets.dart';

class Helper {
  static List<IntroductionMessage> introductionMessges = [
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Welcome to ${AppConstants.appName}",
      subtitle:
          "Discover a new way to shop with our decentralized marketplace.",
    ),
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Vast Product Range",
      subtitle: "Browse and find the best products suited to your needs.",
    ),
    IntroductionMessage(
      image: AppAssets.logo,
      title: "Easy and Secure",
      subtitle: "Enjoy a seamless and secure shopping experience.",
    ),
  ];
}
