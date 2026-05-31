import '../../domain/entities/product.dart';

class ProductDto {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int stock;

  const ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.stock,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: json['thumbnail'] as String? ?? '',
      category: json['category'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      category: category,
      rating: rating,
      stock: stock,
    );
  }
}
