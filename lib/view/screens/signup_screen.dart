import 'package:commerce_app/blocs/auth/auth_bloc.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/route_config/route_names.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isVisible = true;

  final formKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: AppBar(
            title: const Text(
              "Sign Up",
            ),
            titleTextStyle: theme.textTheme.titleLarge,
            centerTitle: true,
            backgroundColor: theme.colorScheme.background,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // const AppLogo(),
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Email Address";
                          }
                          if (!value.trim().isEmail()) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Email Address",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: isVisible!,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (isVisible!) {
                                  isVisible = false;
                                } else {
                                  isVisible = true;
                                }
                              });
                            },
                            icon: Icon(
                              isVisible!
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is SignupSuccess) {
                            debugPrint("Sign Up Success");
                          }
                        },
                        builder: (context, state) {
                          return state is AuthLoading
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    context.dissmissKeyboard();
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            SignupEvent(
                                              emailAddress:
                                                  emailAddressController.text
                                                      .trim(),
                                              password: passwordController.text
                                                  .trim(),
                                            ),
                                          );
                                    }
                                  },
                                  child: const Text(
                                    "Sign Up",
                                  ),
                                );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Have an account? ",
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(AppRouteNames.login);
                                },
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
