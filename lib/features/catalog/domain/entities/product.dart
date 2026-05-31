class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int stock;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.stock,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
