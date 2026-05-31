class Product {
  final int id;
  final String title;
  final String price;
  final String imagePath;
  final String description;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      imagePath: json['imagePath'],
      description: json['description'],
    );
  }
}