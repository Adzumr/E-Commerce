import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller/auth_controller.dart';
import '../../../main.dart';

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
                const ProfileHead(),
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

class ProfileHead extends StatefulWidget {
  const ProfileHead({
    super.key,
  });

  @override
  State<ProfileHead> createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {
  final formKey = GlobalKey<FormState>();
  final name =
      TextEditingController(text: firebaseAuth!.currentUser!.displayName);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: firebaseAuth?.currentUser?.photoURL ?? "",
            height: 200,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => const Icon(
              Icons.account_circle_outlined,
              size: 200,
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${firebaseAuth?.currentUser?.email}",
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        Text(
          "${firebaseAuth?.currentUser?.displayName}",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        IconButton(
          onPressed: () async {
            ValueNotifier isLoading = ValueNotifier<bool>(false);
            final formKey = GlobalKey<FormState>();
            final name = TextEditingController(
                text: firebaseAuth!.currentUser!.displayName);
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: Text(
                    "Update Name",
                    style: theme.textTheme.titleLarge,
                  ),
                  content: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  actions: [
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return isLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  try {
                                    isLoading.value = true;
                                    await firebaseAuth!.currentUser!
                                        .updateDisplayName(
                                      name.text.trim(),
                                    );
                                  } finally {
                                    isLoading.value = false;
                                    Get.back();
                                    setState(() {});
                                  }
                                },
                                child: const Text("Update"),
                              );
                      },
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
        )
      ],
    );
  }
}
