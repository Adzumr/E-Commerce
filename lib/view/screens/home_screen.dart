import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Text(
              "Home Screen",
            ),
          ),
        ),
      ),
    );
  }
}
