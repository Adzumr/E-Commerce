import 'package:commerce_app/controllers/controller/product_controller.dart';
import 'package:commerce_app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/product_widget.dart';

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
      backgroundColor: theme.colorScheme.surface,
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
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slide(begin: const Offset(0, -1)),
              Expanded(
                child: StreamBuilder<List<Product>>(
                  stream: productController.getFavoritesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ).animate().fadeIn(duration: 500.ms).scale();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Product> products = snapshot.data ?? [];
                      return products.isEmpty
                          ? Center(
                              child: Text(
                                "No Favorites",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                                  .animate()
                                  .fadeIn(duration: 500.ms)
                                  .slide(begin: const Offset(0, 1)),
                            )
                          : ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProducWidget(
                                  product: products[index],
                                  // isfavorite: true,
                                  onPressed: () {
                                    productController.removeFavorite(
                                      productModel: products[index],
                                    );
                                  },
                                ).animate().fadeIn(duration: 500.ms).slide(
                                      begin: index.isEven
                                          ? const Offset(1, 0)
                                          : const Offset(1, 1),
                                    );
                              },
                            ).animate().fadeIn(duration: 500.ms);
                    }
                  },
                ),
              ).animate().fadeIn(duration: 500.ms).scale(),
            ],
          ).animate().fadeIn(duration: 500.ms).shimmer(),
        ),
      ),
    );
  }
}
