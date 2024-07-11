import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHead(
                  authController: authController,
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OptionTile(
                      name: "Privacy Policy",
                      onPressed: () {},
                    ),
                    OptionTile(
                      name: "Help and Support",
                      onPressed: () {},
                    ),
                    OptionTile(
                      name: "Appearances",
                      onPressed: () {
                        // AppConstants.switchTheme(context);
                      },
                    ),
                    OptionTile(
                      name: "Rate Us",
                      onPressed: () {},
                    ),
                    OptionTile(
                      name: "Logout",
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: Text(
                                "Log out",
                                style: theme.textTheme.titleLarge,
                              ),
                              content: Text(
                                "Are you sure?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              actionsAlignment: MainAxisAlignment.end,
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await authController.signOut();
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "No",
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.name,
    this.onPressed,
  });

  final String? name;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onPressed,
        title: Text(
          name!,
          style: theme.textTheme.bodyLarge,
        ),
        leading: Icon(
          Icons.adaptive.arrow_forward,
          size: 20,
        ),
      ),
    );
  }
}

class ProfileHead extends StatelessWidget {
  const ProfileHead({
    super.key,
    required this.authController,
  });
  final AuthController? authController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: authController?.userModel?.name ?? "",
            height: 200,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => const Icon(
              Icons.account_circle_outlined,
              size: 150,
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${authController?.userModel?.email}",
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        Text(
          "${authController?.userModel?.name}",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
