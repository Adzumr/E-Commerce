import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_app/core/utils/app_constants.dart';
import 'package:commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../models/products_model.dart';

class ProductController extends GetxController {
  final _userCollection = FirebaseFirestore.instance.collection('favorites');

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> favorites = <Product>[].obs;

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

        EasyLoading.showSuccess("Product added to favorites");
        favorites.add(product); // Add the product to the favorites list
      }
    } on FirebaseException catch (e) {
      exceptionError(exception: e);
    }
  }

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
      }
      favorites.value = products; // Update the favorites list
      return products;
    });
  }

  Future removeFavorite({
    Product? productModel,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _userCollection
          .doc(firebaseAuth!.currentUser!.uid)
          .collection("favorites")
          .where('id', isEqualTo: productModel!.id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        EasyLoading.showToast("Remove from favorites");
        favorites
            .remove(productModel); // Remove the product from the favorites list
      } else {
        debugPrint("Document not found");
      }
    } on FirebaseException catch (e) {
      exceptionError(
        exception: e,
      );
    }
  }

  void exceptionError({
    FirebaseException? exception,
  }) {
    Get.snackbar(
      "Something went wrong",
      exception!.code,
    );
    throw Exception(exception.message);
  }
}
