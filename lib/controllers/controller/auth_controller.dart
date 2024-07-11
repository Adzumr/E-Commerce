import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_app/core/route_config/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/user_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _customers = FirebaseFirestore.instance.collection('customers');

  // TODO: Allow permission to write to firestore
  UserModel? userModel;
  Future<UserModel?> registerUser({
    required UserModel? customer,
    required final String? password,
  }) async {
    try {
      // Step 1: Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: customer!.email!,
        password: password!,
      );
      customer.id = userCredential.user!.uid;
      // Step 2: Store additional user data in Firestore
      await _customers.doc(userCredential.user!.uid).set(
        {
          ...customer.toJson(),
        },
      );

      // Step 3: Retrieve user data from Firestore
      DocumentSnapshot userSnapshot =
          await _customers.doc(userCredential.user!.uid).get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      // Step 4: Create a User model and return it
      if (userData != null) {
        userModel = UserModel.fromJson(userData);
        await sharedPreferences!.setBool("skipIntro", true);
        Get.toNamed(Routes.home);
      }
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
    return userModel;
  }

  Future<UserModel?> loginUser({
    required String? email,
    required String? password,
  }) async {
    try {
      // Step 1: Sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      // Step 3: Retrieve user data from Firestore
      DocumentSnapshot userSnapshot =
          await _customers.doc(userCredential.user!.uid).get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      // Step 4: Create a User model and return it
      if (userData != null) {
        userModel = UserModel.fromJson(userData);
        await sharedPreferences!.setBool("skipIntro", true);
        Get.toNamed(Routes.home);
      }
    } on FirebaseAuthException catch (exception) {
      exceptionError(
        exception: exception,
      );
    } catch (e) {
      throw Exception(e);
    }
    return userModel;
  }

  Future signOut() async {
    try {
      await _auth.signOut().then(
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
