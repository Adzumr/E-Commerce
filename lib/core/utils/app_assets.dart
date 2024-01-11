/// create a class for app constants  usinhg signleton pattern
///
class AppAssets {
  static final AppAssets instance = AppAssets._internal();

  factory AppAssets() {
    return instance;
  }

  AppAssets._internal();

  final String user = "assets/user.png";
  final String appLogo = "assets/logo.png";
  final String introImage = "assets/intro_image.png";
  final String success = "assets/success.png";

  /// Networks
  ///
  final String mtn = "assets/mtn.png";
  final String airtel = "assets/airtel.png";
  final String glo = "assets/glo.png";

  /// Platforms
  ///
  final String waec = "assets/waec.png";
}
