import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Text("Login Screen"),
          ),
        ),
      ),
    );
  }
}
