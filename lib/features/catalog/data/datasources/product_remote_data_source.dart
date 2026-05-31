import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_dto.dart';

class ProductRemoteDataSource {
  static const String _baseUrl = 'https://dummyjson.com';
  static const List<String> _electronicsCategories = [
    'smartphones',
    'laptops',
    'tablets',
    'mobile-accessories',
  ];

  final http.Client client;

  const ProductRemoteDataSource({required this.client});

  Future<List<ProductDto>> fetchProducts() async {
    final categoryResults = await Future.wait(
      _electronicsCategories.map(_fetchProductsByCategory),
    );

    return categoryResults.expand((products) => products).toList();
  }

  Future<List<ProductDto>> _fetchProductsByCategory(String category) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/products/category/$category'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Products category request failed: $category, ${response.statusCode}',
      );
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body);
    final List<dynamic> productsJson = decoded['products'] as List<dynamic>;

    return productsJson
        .map((jsonItem) => ProductDto.fromJson(jsonItem))
        .toList();
  }

  Future<ProductDto> fetchProductById(int id) async {
    final response = await client.get(Uri.parse('$_baseUrl/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Product request failed: ${response.statusCode}');
    }

    return ProductDto.fromJson(jsonDecode(response.body));
  }
}
