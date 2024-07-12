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
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/products'),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If the server returns a 200 OK response, parse the products.
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
      // Check if the product is already added by querying the "favorites" collection
      QuerySnapshot querySnapshot = await _userCollection
          .doc(firebaseAuth!.currentUser!.uid)
          .collection("favorites")
          .where('id', isEqualTo: product.id)
          .get();

      // If a document with the same id exists, handle it accordingly
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("Product is already added as a favorite.");
        EasyLoading.showError("Product is already added as a favorite.");
      } else {
        // If the product is not already added, proceed with adding it
        await _userCollection
            .doc(firebaseAuth!.currentUser!.uid)
            .collection("favorites")
            .add(product.toJson());

        // Refresh the favorites stream
        getFavoritesStream();
        EasyLoading.showSuccess("Product added to favorites");
        // Get.snackbar(
        //   "Success",
        //   "Product added to favorites",
        // );
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
      return products;
    });
  }

  Future removeFavorite({
    Product? productModel,
  }) async {
    try {
      // Query to find the document with the specified title
      QuerySnapshot querySnapshot = await _userCollection
          .doc(firebaseAuth!.currentUser!.uid)
          .collection("favorites")
          .where('id', isEqualTo: productModel!.id)
          .get();

      // Check if there is any document matching the query
      if (querySnapshot.docs.isNotEmpty) {
        // Delete the first document found (assuming titles are unique)
        await querySnapshot.docs.first.reference.delete();
        // Optionally, you can call getFavoritesStream() after deletion

        getFavoritesStream();
        EasyLoading.showToast("Remove from favorites");
        // Get.snackbar(
        //   "Deleted",
        //   "Deleted as Favorite",
        // );
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
