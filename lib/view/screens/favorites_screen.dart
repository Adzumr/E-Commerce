import 'package:flutter/material.dart';

import '../../data/models/products_model.dart';
import '../widgets/product_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    final product = Product(
                      category: "Men",
                      description: "Men Description",
                      id: 01,
                      image:
                          "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                      price: 35567,
                      rating: Rating(
                        count: 247,
                        rate: 4.5,
                      ),
                      title: "T-Shirt",
                    );
                    return ProducWidget(
                      product: product,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
