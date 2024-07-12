class AppAssets {
  static final AppAssets instance = AppAssets._internal();

  factory AppAssets() {
    return instance;
  }

  AppAssets._internal();
  static String logo = "assets/logo.png";
}
