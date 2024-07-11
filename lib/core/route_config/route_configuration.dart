import 'package:commerce_app/controllers/binding/product_binding.dart';
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
  static List<GetPage> routes = [
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.introduction}',
      binding: AuthBinding(),
      page: () => const IntroductionScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.login}',
      binding: AuthBinding(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.signup}',
      binding: AuthBinding(),
      page: () => const SignupScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.home}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const MainScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.products}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProductsScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.product}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProductScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.favorites}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const FavoritesScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.profile}',
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
      page: () => const ProfileScreen(),
    ),
  ];
}
