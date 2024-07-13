import 'package:commerce_app/core/route_config/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/user_model.dart';

/// Controller responsible for handling authentication operations.
class AuthController extends GetxController {
  /// Registers a new user with the provided customer details and password.
  ///
  /// Parameters:
  /// - `customer`: The user model containing customer details.
  /// - `password`: The password for the new user.
  Future<void> registerUser({
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
      EasyLoading.showError("${exception.message}");
      throw Exception(exception);
    } catch (e) {
      EasyLoading.showError("$e");
      throw Exception(e);
    }
  }

  /// Logs in a user with the provided email and password.
  ///
  /// Parameters:
  /// - `email`: The email address of the user.
  /// - `password`: The password for the user.
  Future<void> loginUser({
    required String? email,
    required String? password,
  }) async {
    try {
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
      EasyLoading.showError("${exception.message}");
    } catch (e) {
      EasyLoading.showError("$e");
      throw Exception(e);
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    try {
      await firebaseAuth!.signOut().then(
        (value) {
          Get.offNamed(Routes.login);
        },
      );
    } on FirebaseAuthException catch (exception) {
      EasyLoading.showError("${exception.message}");
    } catch (e) {
      EasyLoading.showError("$e");
      throw Exception(e);
    }
  }
}
