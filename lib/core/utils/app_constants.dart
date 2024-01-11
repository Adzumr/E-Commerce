/// create a class for app constants  usinhg signleton pattern
///
class AppConstants {
  static final AppConstants instance = AppConstants._internal();

  factory AppConstants() {
    return instance;
  }

  AppConstants._internal();

  final String appName = "E-Commerce";
  final String baseUrl = "https://fakestoreapi.com";
}
