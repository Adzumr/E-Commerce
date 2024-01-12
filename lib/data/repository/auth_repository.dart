import 'package:commerce_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Future<User?> login({
    required String? emailAddress,
    required String? password,
  }) async {
    try {
      final response = await firebaseAuth!
          .signInWithEmailAndPassword(
            email: emailAddress!,
            password: password!,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      return response.user;
    } catch (e) {
      throw Exception(
        e,
      );
    }
  }

  Future<User?> signup({
    required String? emailAddress,
    required String? password,
  }) async {
    try {
      final response = await firebaseAuth!
          .createUserWithEmailAndPassword(
            email: emailAddress!,
            password: password!,
          )
          .timeout(
            const Duration(seconds: 30),
          );
      return response.user;
    } catch (e) {
      throw Exception(
        e,
      );
    }
  }
}
