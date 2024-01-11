import 'package:commerce_app/main.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Future login({
    required String? emailAddress,
    required String? password,
  }) async {
    try {
      await firebaseAuth!
          .signInWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      )
          .then(
        (value) {
          debugPrint(
            "Return $value",
          );
        },
      );
    } catch (e) {
      throw Exception(
        e,
      );
    }
  }

  Future signup({
    required String? emailAddress,
    required String? password,
  }) async {
    try {
      await firebaseAuth!
          .createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      )
          .then(
        (value) {
          debugPrint(
            "Return $value",
          );
        },
      );
    } catch (e) {
      throw Exception(
        e,
      );
    }
  }
}
