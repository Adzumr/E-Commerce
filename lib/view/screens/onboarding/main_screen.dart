import 'package:commerce_app/view/screens/authentication/account_screen.dart';
import 'package:commerce_app/view/screens/product/favorites_screen.dart';
import 'package:commerce_app/view/screens/product/products_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Theme.of(context).colorScheme.secondary,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              tooltip: "products",
              icon: Icon(Icons.home_outlined),
              label: 'products',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite),
              tooltip: "Favorites",
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              tooltip: "Profile",
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          /// Home page
          const ProductsScreen(),

          /// Transactions page
          const FavoritesScreen(),

          /// Settings page
          const AccountScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
