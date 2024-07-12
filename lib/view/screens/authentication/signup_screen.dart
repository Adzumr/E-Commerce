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
  bool? _isVisible = true;
  bool? _isLoading = false;

  final _authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameNode.dispose();
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                            controller: _nameController,
                            focusNode: _nameNode,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              context.nextFocus(_nameNode, _emailNode);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Enter Your name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Name",
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
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
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: _isVisible!,
                            controller: _passwordController,
                            focusNode: _passwordNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) async {
                              _passwordNode.unfocus();
                              await _signupFunction();
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
                                    if (_isVisible!) {
                                      _isVisible = false;
                                    } else {
                                      _isVisible = true;
                                    }
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _isLoading!
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          context.dissmissKeyboard();
                          await _signupFunction();
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

  Future<void> _signupFunction() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        await _authController.registerUser(
          customer: UserModel(
            email: _emailController.text.trim(),
            name: _nameController.text.trim(),
          ),
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
