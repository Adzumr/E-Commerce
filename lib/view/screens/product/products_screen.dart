import 'package:commerce_app/controllers/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool? isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  final productController = Get.find<ProductController>();

  fetchData() async {
    if (productController.products.isEmpty) {
      setState(() {
        isLoading = true;
      });
      await productController.fetchProducts();
      setState(() {
        isLoading = false;
      });
    }
  }

  refreshData() async {
    setState(() {
      isLoading = true;
    });
    await productController.fetchProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await refreshData();
          },
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ).animate().fadeIn(duration: 500.ms).scale()
                : Obx(
                    () => productController.products.isEmpty
                        ? Center(
                            child: Text(
                              "No Products",
                              style: theme.textTheme.displaySmall,
                            ).animate().fadeIn(duration: 500.ms).slide(
                                  begin: const Offset(0, 1),
                                ),
                          )
                        : Column(
                            children: [
                              Text(
                                "Products",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge,
                              ).animate().fadeIn(duration: 500.ms).slide(
                                    begin: const Offset(0, -1),
                                  ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: productController.products.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final product =
                                        productController.products[index];
                                    return ProducWidget(
                                      product: product,
                                      onPressed: () {
                                        // productController.addFavorite(
                                        //     product: product);
                                      },
                                    ).animate().fadeIn(duration: 500.ms).slide(
                                        begin: index.isEven
                                            ? const Offset(1, 0)
                                            : const Offset(1, 1));
                                  },
                                ).animate().fadeIn(duration: 500.ms),
                              ),
                            ],
                          ).animate().fadeIn(duration: 500.ms).saturate(),
                  ),
          ),
        ),
      ),
    );
  }
}
