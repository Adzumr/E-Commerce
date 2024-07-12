import 'package:commerce_app/controllers/controller/auth_controller.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../core/route_config/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? _isVisible = true;
  bool? _isLoading = false;

  final _authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

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
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Welcome Back",
                            style: theme.textTheme.titleLarge,
                          ).animate().fadeIn(duration: 500.ms).slide(),
                          const SizedBox(height: 10),
                          Text(
                            "Log in to your account to continue exploring our marketplace.",
                            style: theme.textTheme.bodyLarge,
                          ).animate().fadeIn(duration: 500.ms).slide(),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              context.nextFocus(_emailNode, _passwordNode);
                            },
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
                          ).animate().fadeIn(duration: 500.ms).slide(),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: _isVisible!,
                            controller: _passwordController,
                            focusNode: _passwordNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) async {
                              _passwordNode.unfocus();
                              await _loginFunction();
                            },
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
                                    _isVisible = !_isVisible!;
                                  });
                                },
                                icon: Icon(
                                  _isVisible!
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 500.ms).slide(),
                          const SizedBox(height: 32),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot password?",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).animate().fadeIn(duration: 500.ms).slide(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _isLoading!
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ).animate().fadeIn(duration: 500.ms).scale()
                    : ElevatedButton(
                        onPressed: () async {
                          context.dissmissKeyboard();
                          await _loginFunction();
                        },
                        child: const Text(
                          "Log in",
                        ),
                      ).animate().fadeIn(duration: 500.ms).slide(),
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
                            Get.toNamed(Routes.signup);
                          },
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 500.ms).slide(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginFunction() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        await _authController.loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
