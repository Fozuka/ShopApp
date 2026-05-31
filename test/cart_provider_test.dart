import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:shop_app/features/catalog/domain/entities/product.dart';

void main() {
  test('cart adds products and calculates total', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(cartProvider.notifier).addProduct(testProduct);
    container.read(cartProvider.notifier).addProduct(testProduct);

    final items = container.read(cartProvider);

    expect(items, hasLength(1));
    expect(items.first.quantity, 2);
    expect(container.read(cartItemsCountProvider), 2);
    expect(container.read(cartTotalProvider), 199.98);
  });
}

const testProduct = Product(
  id: 1,
  title: 'Test Phone',
  description: 'Test description',
  price: 99.99,
  imageUrl: 'https://example.com/phone.png',
  category: 'smartphones',
  rating: 4.5,
  stock: 10,
);
