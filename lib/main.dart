import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/route_config/route_configuration.dart';
import 'core/route_config/route_names.dart';
import 'core/theme/themes.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseAuth = FirebaseAuth.instance;
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    const EcommerceApp(),
  );
}

SharedPreferences? sharedPreferences;

FirebaseAuth? firebaseAuth;

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      defaultTransition: Transition.fade,
      themeMode: ThemeMode.system,

      /// The routes for the app.
      getPages: AppRoutesConfiguration.routes,
      builder: EasyLoading.init(),

      /// The routes for the app.
      initialRoute: sharedPreferences!.getBool("skipIntro") != true
          ? Routes.introduction
          : firebaseAuth!.currentUser != null
              ? Routes.home
              : Routes.login,
    );
  }
}
