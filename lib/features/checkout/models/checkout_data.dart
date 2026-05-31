import '../../cart/domain/entities/cart_item.dart';

class CheckoutData {
  final String name;
  final String phone;
  final String address;
  final String comment;
  final List<CartItem> items;
  final double total;

  const CheckoutData({
    required this.name,
    required this.phone,
    required this.address,
    required this.comment,
    required this.items,
    required this.total,
  });
}
