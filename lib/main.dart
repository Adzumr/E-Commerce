import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_bloc_providers.dart';
import 'app_repo_providers.dart';
import 'core/route_config/route_configuration.dart';
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
    return AppRepositoryProviders(
      child: AppBlocProviders(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants().appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppRoutesConfiguration.router,
        ),
      ),
    );
  }
}
