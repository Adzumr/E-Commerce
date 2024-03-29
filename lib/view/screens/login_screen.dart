import 'package:commerce_app/controllers/controller/auth_controller.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/route_config/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isVisible = true;
  bool? isLoading = false;

  final authController = Get.find<AuthenticationController>();

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
                    ListTile(
                      title: Text(
                        "Welcome Back!",
                        style: theme.textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        "Log in to your Immersive Commerce account to continue your seamless shopping experience.",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Email Address";
                        }
                        if (!value.trim().isEmail) {
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
                    const SizedBox(height: 16),

                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          // context.pushNamed(AppRouteNames.login);
                        },
                        child: Text(
                          "Forgot password?",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    isLoading!
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              context.dissmissKeyboard();
                              if (formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await authController.login(
                                    emailAddress:
                                        emailAddressController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Log in",
                            ),
                          ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRouteNames.signup);
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
        ),
      ),
    );
  }
}
