import 'package:commerce_app/controllers/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_widget.dart';

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
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : productController.products!.isEmpty
                  ? Center(
                      child: Text(
                        "No Products",
                        style: theme.textTheme.displaySmall,
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          "Products",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: productController.products!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product =
                                  productController.products![index];
                              return ProducWidget(
                                product: product,
                                onPressed: () {
                                  debugPrint("Product:${product.title}");
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
