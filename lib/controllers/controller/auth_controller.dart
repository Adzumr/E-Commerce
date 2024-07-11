import 'package:commerce_app/core/route_config/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/user_model.dart';

class AuthController extends GetxController {
  Future registerUser({
    required UserModel? customer,
    required final String? password,
  }) async {
    try {
      await firebaseAuth!
          .createUserWithEmailAndPassword(
        email: customer!.email!,
        password: password!,
      )
          .then((value) async {
        await firebaseAuth!.currentUser!.updateDisplayName(customer.name);
        await sharedPreferences!.setBool("skipIntro", true);
        Get.toNamed(Routes.home);
      });
    } on FirebaseAuthException catch (exception) {
      exceptionError(
        exception: exception,
      );
      throw Exception(exception);
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
      );
      throw Exception(e);
    }
  }

  Future loginUser({
    required String? email,
    required String? password,
  }) async {
    try {
      // Step 1: Sign in user with email and password
      await firebaseAuth!
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) async {
        await sharedPreferences!.setBool("skipIntro", true);
        Get.toNamed(Routes.home);
      });
    } on FirebaseAuthException catch (exception) {
      exceptionError(
        exception: exception,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future signOut() async {
    try {
      await firebaseAuth!.signOut().then(
        (value) {
          Get.snackbar(
            "Log out",
            "Successfully logged out.",
          );
          Get.offNamed(Routes.login);
        },
      );
    } on FirebaseAuthException catch (exception) {
      exceptionError(
        exception: exception,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
      );
      throw Exception(e);
    }
  }

  void exceptionError({
    FirebaseAuthException? exception,
  }) {
    Get.snackbar(
      "Something went wrong",
      exception!.code,
    );
    throw Exception(exception.message);
  }
}
