import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_app/core/utils/app_constants.dart';
import 'package:commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../models/products_model.dart';

/// Controller responsible for managing products and favorites.
class ProductController extends GetxController {
  final _userCollection = FirebaseFirestore.instance.collection('favorites');

  /// Observable list of all products.
  final RxList<Product> products = <Product>[].obs;

  /// Observable list of favorite products.
  final RxList<Product> favorites = <Product>[].obs;

  /// Fetches products from the API and updates the [products] list.
  ///
  /// Returns a list of fetched products.
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/products'),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> data = jsonDecode(response.body);
        products.value = data.map((json) => Product.fromJson(json)).toList();
        debugPrint("Products: ${products.length}");
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Exception: $error');
    }
  }

  /// Adds a product to the user's favorites collection in Firestore.
  ///
  /// Parameters:
  /// - `product`: The product to be added to favorites.
  Future<void> addFavorite({required Product product}) async {
    try {
      QuerySnapshot querySnapshot = await _userCollection
          .doc(firebaseAuth!.currentUser!.uid)
          .collection("favorites")
          .where('id', isEqualTo: product.id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("Product is already added as a favorite.");
        EasyLoading.showError("Product is already added as a favorite.");
      } else {
        await _userCollection
            .doc(firebaseAuth!.currentUser!.uid)
            .collection("favorites")
            .add(product.toJson());

        favorites.add(product); // Add the product to the favorites list
        EasyLoading.showSuccess("Product added to favorites");
      }
    } on FirebaseException catch (e) {
      EasyLoading.showError("$e");
    }
  }

  /// Retrieves a stream of favorite products from Firestore.
  ///
  /// Returns a stream of lists of favorite products.
  Stream<List<Product>> getFavoritesStream() {
    return _userCollection
        .doc(firebaseAuth!.currentUser!.uid)
        .collection("favorites")
        .snapshots()
        .map((querySnapshot) {
      List<Product> products = [];
      for (var documentSnapshot in querySnapshot.docs) {
        Product productModel = Product.fromJson(documentSnapshot.data());
        products.add(productModel);
        favorites.add(productModel);
      }
      // favorites.value = products; // Update the favorites list
      return products;
    });
  }

  /// Removes a product from the user's favorites collection in Firestore.
  ///
  /// Parameters:
  /// - `productModel`: The product model to be removed from favorites.
  Future<void> removeFavorite({
    required Product? productModel,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _userCollection
          .doc(firebaseAuth!.currentUser!.uid)
          .collection("favorites")
          .where('id', isEqualTo: productModel!.id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        favorites
            .remove(productModel); // Remove the product from the favorites list
        EasyLoading.showToast("Remove from favorites");
      } else {
        debugPrint("Document not found");
      }
    } on FirebaseException catch (e) {
      EasyLoading.showError("$e");
    }
  }
}
