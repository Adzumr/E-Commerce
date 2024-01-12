import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../data/models/products_model.dart';

class ProductController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  final _userCollection = FirebaseFirestore.instance.collection('user');
  List<Product>? products;
  final RxList<Product> favorites = <Product>[].obs;
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      debugPrint("Fetching...");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If the server returns a 200 OK response, parse the products.
        List<dynamic> data = jsonDecode(response.body);
        products = data.map((json) => Product.fromJson(json)).toList();
        debugPrint("Products: ${products!.length}");
        return products!;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load products');
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request.
      debugPrint('Error fetching products: $error');
      throw Exception('Failed to fetch products');
    }
  }

  Future addFavorite({
    Product? productModel,
  }) async {
    try {
      // Check if the product is already added by querying the "favorites" collection
      QuerySnapshot querySnapshot = await _userCollection
          .doc(user!.uid)
          .collection("favorites")
          .where('title', isEqualTo: productModel!.title)
          .get();

      // If a document with the same title exists, handle it accordingly
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint("Product is already added as a favorite.");
        // You can choose to update the existing document or skip the addition
        // Example: Update the existing document's fields
        // await querySnapshot.docs.first.reference.update({
        //   'field1': newValue1,
        //   'field2': newValue2,
        //   // ... other fields you may want to update
        // });
      } else {
        // If the product is not already added, proceed with adding it
        DocumentReference documentRef =
            _userCollection.doc(user!.uid).collection("favorites").doc();
        await documentRef
            .set(
              productModel.toJson(),
            )
            .then(
              (value) async => getFavoritesStream(),
            );
        Get.snackbar(
          "Failed",
          "Already Added as Favorite",
        );
      }
    } on FirebaseException catch (e) {
      exceptionError(
        exception: e,
      );
    }
  }

  Stream<List<Product>> getFavoritesStream() {
    return _userCollection
        .doc(user!.uid)
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
          .doc(user!.uid)
          .collection("favorites")
          .where('id', isEqualTo: productModel!.id)
          .get();

      // Check if there is any document matching the query
      if (querySnapshot.docs.isNotEmpty) {
        // Delete the first document found (assuming titles are unique)
        await querySnapshot.docs.first.reference.delete();
        // Optionally, you can call getFavoritesStream() after deletion

        getFavoritesStream();
        Get.snackbar(
          "Deleted",
          "Deleted as Favorite",
        );
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
