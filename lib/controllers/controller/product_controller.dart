import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../data/models/products_model.dart';

class ProductController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  final _sellsCollection = FirebaseFirestore.instance.collection('favorites');
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

  Future addProduct({
    Product? productModel,
  }) async {
    try {
      DocumentReference documentRef =
          _sellsCollection.doc(user!.uid).collection("product").doc();
      String productId = documentRef.id;
      productModel!.id = productId;

      await documentRef
          .set(
            productModel.toJson(),
          )
          .then(
            (value) async => getProductsStream(),
          );
    } on FirebaseException catch (e) {
      exceptionError(
        exception: e,
      );
    }
  }

  Stream<List<ProductModel>> getProductsStream() {
    return _productsCollection
        .doc(user!.uid)
        .collection("product")
        .snapshots()
        .map((querySnapshot) {
      List<ProductModel> products = [];
      for (var documentSnapshot in querySnapshot.docs) {
        ProductModel productModel =
            ProductModel.fromJson(documentSnapshot.data());
        productModel.id = documentSnapshot.id;
        products.add(productModel);
      }
      return products;
    });
  }

  removeFavorite(Product? product) {
    if (favorites.contains(product)) {
      favorites.remove(product!);
      debugPrint("Favorites: ${favorites.length}");
    }
  }
}
