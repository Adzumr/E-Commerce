import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce_app/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/route_config/route_names.dart';
import '../../data/models/products_model.dart';

class ProducWidget extends StatelessWidget {
  const ProducWidget({
    super.key,
    required this.product,
    this.isfavorite = false,
  });

  final Product product;
  final bool isfavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          debugPrint("Product: ${product.title}");
          Get.toNamed(
            AppRouteNames.product,
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
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      isfavorite ? Icons.favorite : Icons.favorite_outline,
                      color: theme.colorScheme.error,
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
