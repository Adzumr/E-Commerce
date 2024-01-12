import 'package:commerce_app/controllers/binding/product_binding.dart';
import 'package:commerce_app/view/screens/favorites_screen.dart';
import 'package:commerce_app/view/screens/products_screen.dart';
import 'package:commerce_app/view/screens/profile_screen.dart';
import 'package:get/get.dart';

import '../../controllers/binding/auth_binding.dart';
import '../../view/screens/main_screen.dart';
import '../../view/screens/intro_screen.dart';
import '../../view/screens/login_screen.dart';
import '../../view/screens/product_screen.dart';
import '../../view/screens/signup_screen.dart';
import 'route_names.dart';

class AppRoutesConfiguration {
  static List<GetPage> routes = [
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.introduction}',
      binding: AuthenticationBinding(),
      page: () => const IntroductionScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.login}',
      binding: AuthenticationBinding(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.signup}',
      binding: AuthenticationBinding(),
      page: () => const SignupScreen(),
    ),
    GetPage(
      fullscreenDialog: true,
      participatesInRootNavigator: true,
      opaque: true,
      name: '/${AppRouteNames.main}',
      bindings: [
        AuthenticationBinding(),
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
        AuthenticationBinding(),
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
        AuthenticationBinding(),
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
        AuthenticationBinding(),
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
        AuthenticationBinding(),
        ProductBinding(),
      ],
      page: () => const ProfileScreen(),
    ),
  ];
}
