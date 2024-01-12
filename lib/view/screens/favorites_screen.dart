import 'package:commerce_app/controllers/controller/product_controller.dart';
import 'package:commerce_app/data/models/products_model.dart';
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
              Expanded(
                child: StreamBuilder<List<Product>>(
                  stream: productController.getFavoritesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Product> products = snapshot.data ?? [];
                      // Use the 'debtors' list to build your UI.
                      return products.isEmpty
                          ? Center(
                              child: Text(
                                "No Favorites",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          : ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProducWidget(
                                  product: products[index],
                                  isfavorite: true,
                                  onPressed: () {
                                    productController.removeFavorite(
                                      productModel: products[index],
                                    );
                                  },
                                );
                              },
                            );
                    }
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
