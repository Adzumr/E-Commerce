import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/auth_repository.dart';

class AppRepositoryProviders extends StatelessWidget {
  final Widget child;

  const AppRepositoryProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        // Add more Repository providers as needed
      ],
      child: child,
    );
  }
}
