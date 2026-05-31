import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/product_card.dart';
import '../../../../shared/widgets/shop_screen.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/product.dart';
import '../providers/catalog_providers.dart';
import 'product_details_page.dart';

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);

    return ShopScreen(
      title: 'Каталог электроники',
      child: productsState.when(
        loading: () => const _CatalogLoadingView(),
        error: (error, stackTrace) => _CatalogErrorView(
          onRetry: () {
            ref.invalidate(productsProvider);
          },
        ),
        data: (products) {
          if (products.isEmpty) {
            return const _CatalogEmptyView();
          }

          return Column(
            children: products
                .map(
                  (product) => ProductCard(
                    imagePath: product.imageUrl,
                    title: product.title,
                    price: product.formattedPrice,
                    onTap: () => _openProductDetails(context, product),
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} добавлен в корзину'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  void _openProductDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(productId: product.id),
      ),
    );
  }
}

class _CatalogLoadingView extends StatelessWidget {
  const _CatalogLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _CatalogErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _CatalogErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Не удалось загрузить товары',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Проверьте подключение к интернету и попробуйте снова.'),
        const SizedBox(height: 16),
        FilledButton(onPressed: onRetry, child: const Text('Повторить')),
      ],
    );
  }
}

class _CatalogEmptyView extends StatelessWidget {
  const _CatalogEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Text('Список товаров пуст', style: TextStyle(fontSize: 18));
  }
}
