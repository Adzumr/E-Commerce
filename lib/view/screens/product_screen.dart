import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:commerce_app/data/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    product = Get.arguments;
    super.initState();
  }

  Product? product;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.adaptive.arrow_back,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "${product!.title}",
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Opacity(
                    opacity: 0,
                    child: BackButton(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: product!.title!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CachedNetworkImage(
                          imageUrl: "${product!.image}",
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Name",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${product!.title}".capitalizeFirst!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Rating",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${product!.rating!.rate}",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "category",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${product!.category}".capitalizeFirst!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Description",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${product!.description}",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Price",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "${product!.price}".toCurrency(),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
