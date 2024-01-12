import 'package:commerce_app/controllers/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? isLoading = false;
  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Profile",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                        ),
                        title: Text(
                          "Full Name",
                          style: theme.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          authController.user.currentUser!.displayName ??
                              "No Name",
                          style: theme.textTheme.bodyLarge,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                final nameController = TextEditingController();
                                return AlertDialog.adaptive(
                                  title: const Text(
                                    "Update Name",
                                  ),
                                  content: TextFormField(
                                    controller: nameController,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Update",
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Cancel",
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.email_outlined,
                        ),
                        title: Text(
                          "Email",
                          style: theme.textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          "${authController.user.currentUser!.email}",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isLoading!
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: const Text(
                                "Logout",
                              ),
                              content: const Text(
                                "Are you sure?",
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Get.back();
                                    try {
                                      await authController.signOut();
                                    } catch (e) {
                                      debugPrint('$e');
                                      throw Exception(e);
                                    }
                                  },
                                  child: const Text(
                                    "Yes",
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Cancel",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Sign out",
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
