import 'package:commerce_app/core/utils/extentions.dart';
import 'package:commerce_app/models/user_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controller/auth_controller.dart';
import '../../../core/route_config/route_names.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isVisible = true;
  bool? isLoading = false;

  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(
                              "Create an Account",
                              style: theme.textTheme.titleLarge,
                            ),
                            subtitle: Text(
                              "Join our community and start exploring the best products on our decentralized marketplace.",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: fullNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Your name";
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Full name",
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
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
                        ],
                      ),
                    ),
                  ),
                ),
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
                              await authController.registerUser(
                                customer: UserModel(
                                  email: emailAddressController.text.trim(),
                                  name: fullNameController.text.trim(),
                                ),
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
                          "Sign Up",
                        ),
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
                            Get.toNamed(Routes.login);
                          },
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
