import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:commerce_app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product? _product;

  @override
  void initState() {
    _product = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "${_product!.title}",
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium,
        ).animate().fadeIn(duration: 500.ms).slide(begin: const Offset(-1, 0)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: _product!.title!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CachedNetworkImage(
                          imageUrl: "${_product!.image}",
                          height: 250,
                          errorWidget: (context, url, error) {
                            return const Center(
                              child: Icon(
                                Icons.error_outline,
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ).animate().fadeIn(duration: 700.ms).scale(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Name",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${_product!.title}".capitalizeFirst!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slide(begin: const Offset(-1, 0)),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Rating",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${_product!.rating!.rate}",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slide(begin: const Offset(1, 0)),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Category",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${_product!.category}".capitalizeFirst!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slide(begin: const Offset(-1, 0)),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Description",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${_product!.description}",
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slide(begin: const Offset(1, 0)),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Price",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${_product!.price}".toCurrency(),
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slide(begin: const Offset(-1, 0)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Close"),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slide(begin: const Offset(-1, 1)),
            ),
          ],
        ),
      ),
    );
  }
}
