import 'package:commerce_app/core/route_config/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth user = FirebaseAuth.instance;

  Future signup({
    String? emailAddress,
    String? password,
  }) async {
    try {
      await user
          .createUserWithEmailAndPassword(
            email: emailAddress!,
            password: password!,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw 'Timeout',
          )
          .then(
        (value) async {
          Get.toNamed(AppRouteNames.main);
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

  Future login({
    String? emailAddress,
    String? password,
  }) async {
    try {
      await user
          .signInWithEmailAndPassword(
            email: emailAddress!,
            password: password!,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw 'Timeout',
          )
          .then(
        (value) {
          Get.toNamed(AppRouteNames.main);
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

  Future signOut() async {
    try {
      await user.signOut().then(
        (value) {
          Get.snackbar(
            "Log out",
            "Successfully logged out.",
          );
          Get.offNamed(AppRouteNames.login);
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

  // Future resetPassword({
  //   String? emailAddress,
  // }) async {
  //   try {
  //     await user
  //         .sendPasswordResetEmail(
  //           email: emailAddress!,
  //         )
  //         .timeout(
  //           const Duration(seconds: 10),
  //           onTimeout: () => throw 'Timeout',
  //         )
  //         .then((value) {
  //       Get.snackbar(
  //         "Email Sent",
  //         "Reset Link is sent to your email",
  //       );
  //       Get.toNamed(
  //         AppRouteNames.resetPassword,
  //       );
  //     });
  //   } on FirebaseAuthException catch (exception) {
  //     exceptionError(
  //       exception: exception,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       "$e",
  //     );
  //     throw Exception(e);
  //   }
  // }

  void exceptionError({
    FirebaseAuthException? exception,
  }) {
    Get.snackbar(
      "Error",
      exception!.code,
    );
    throw Exception(exception.message);
  }
}
