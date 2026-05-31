import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductLocalDataSource {
  Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/products.json',
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map((jsonItem) => Product.fromJson(jsonItem))
        .toList();
  }
}