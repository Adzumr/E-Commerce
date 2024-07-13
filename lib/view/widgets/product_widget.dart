import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller/product_controller.dart';
import '../../core/route_config/route_names.dart';
import '../../models/products_model.dart';

/// Widget for displaying a product item.
class ProducWidget extends StatelessWidget {
  /// Constructs a `ProducWidget`.
  ///
  /// Parameters:
  /// - `product`: The product to display.
  /// - `onPressed`: Callback function when the product is pressed.
  const ProducWidget({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  /// The product to display.
  final Product product;

  /// The product to display.
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productController = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          debugPrint("Product: ${product.title}");
          Get.toNamed(
            Routes.product,
            arguments: product,
          );
        },
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Obx(
                    () => IconButton(
                      onPressed: () async {
                        productController.favorites.contains(product)
                            ? productController.removeFavorite(
                                productModel: product)
                            : productController.addFavorite(product: product);
                      },
                      icon: Icon(
                        productController.favorites.contains(product)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: product.title!,
                  child: CachedNetworkImage(
                    imageUrl: "${product.image}",
                    height: 150,
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
                const SizedBox(height: 20),
                Text(
                  "${product.title}",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: theme.textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.price}".toCurrency(),
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: theme.colorScheme.error,
                      ),
                      label: Text(
                        "${product.rating!.rate}",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
