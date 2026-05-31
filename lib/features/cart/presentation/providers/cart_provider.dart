import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../catalog/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold<double>(0, (total, item) => total + item.totalPrice);
});

final cartItemsCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold<int>(0, (total, item) => total + item.quantity);
});

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return const [];
  }

  void addProduct(Product product) {
    final existingItemIndex = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex == -1) {
      state = [...state, CartItem(product: product, quantity: 1)];
      return;
    }

    state = [
      for (var i = 0; i < state.length; i++)
        if (i == existingItemIndex)
          state[i].copyWith(quantity: state[i].quantity + 1)
        else
          state[i],
    ];
  }

  void decreaseQuantity(int productId) {
    final item = state.firstWhere((item) => item.product.id == productId);

    if (item.quantity <= 1) {
      removeProduct(productId);
      return;
    }

    state = [
      for (final cartItem in state)
        if (cartItem.product.id == productId)
          cartItem.copyWith(quantity: cartItem.quantity - 1)
        else
          cartItem,
    ];
  }

  void removeProduct(int productId) {
    state = [
      for (final item in state)
        if (item.product.id != productId) item,
    ];
  }

  void clear() {
    state = const [];
  }
}
