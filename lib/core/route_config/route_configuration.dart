import 'package:commerce_app/controllers/binding/product_binding.dart';
import 'package:commerce_app/view/screens/authentication/account_screen.dart';
import 'package:commerce_app/view/screens/product/favorites_screen.dart';
import 'package:commerce_app/view/screens/product/products_screen.dart';
import 'package:commerce_app/view/screens/authentication/profile_screen.dart';
import 'package:get/get.dart';

import '../../controllers/binding/auth_binding.dart';
import '../../view/screens/onboarding/main_screen.dart';
import '../../view/screens/onboarding/intro_screen.dart';
import '../../view/screens/authentication/login_screen.dart';
import '../../view/screens/product/product_screen.dart';
import '../../view/screens/authentication/signup_screen.dart';
import 'route_names.dart';

class AppRoutesConfiguration {
  /// List of routes for the application using GetX's [GetPage].
  static List<GetPage> routes = [
    /// Introduction Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.introduction}',
      binding: AuthBinding(),
      page: () => const IntroductionScreen(),
    ),

    /// Login Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.login}',
      binding: AuthBinding(),
      page: () => const LoginScreen(),
    ),

    /// Signup Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.signup}',
      binding: AuthBinding(),
      page: () => const SignupScreen(),
    ),

    /// Home Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.home}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const MainScreen(),
    ),

    /// Products Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.products}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProductsScreen(),
    ),

    /// Product Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.product}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProductScreen(),
    ),

    /// Favorites Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.favorites}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const FavoritesScreen(),
    ),

    /// Profile Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.profile}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProfileScreen(),
    ),

    /// Account Screen route.
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${Routes.account}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const AccountScreen(),
    ),
  ];
}
