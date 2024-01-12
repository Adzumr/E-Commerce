import 'package:commerce_app/controllers/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final productController = Get.find<ProductController>();
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
                "Favorites",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              productController.favorites.isEmpty
                  ? const Center(
                      child: Text("No Favorite"),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: productController.favorites.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = productController.favorites[index];
                          return ProducWidget(
                            product: product,
                            onPressed: () {
                              productController.removeFavorite(product);
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
