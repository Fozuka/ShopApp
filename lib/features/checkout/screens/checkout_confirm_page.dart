import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/domain/entities/cart_item.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import '../models/checkout_data.dart';

class CheckoutConfirmPage extends ConsumerWidget {
  final CheckoutData data;

  const CheckoutConfirmPage({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подтверждение заказа'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Проверьте заказ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _ContactDataCard(data: data),
              const SizedBox(height: 12),
              _OrderItemsCard(items: data.items),
              const SizedBox(height: 12),
              _TotalCard(total: data.total),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _confirmOrder(context, ref),
                  child: const Text('Подтвердить заказ'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Изменить данные'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmOrder(BuildContext context, WidgetRef ref) {
    ref.read(cartProvider.notifier).clear();

    Navigator.popUntil(context, (route) => route.isFirst);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Заказ оформлен'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _ContactDataCard extends StatelessWidget {
  final CheckoutData data;

  const _ContactDataCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Получатель',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ConfirmRow(title: 'Имя', value: data.name),
            ConfirmRow(title: 'Телефон', value: data.phone),
            ConfirmRow(title: 'Адрес', value: data.address),
            ConfirmRow(title: 'Комментарий', value: data.comment),
          ],
        ),
      ),
    );
  }
}

class _OrderItemsCard extends StatelessWidget {
  final List<CartItem> items;

  const _OrderItemsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Состав заказа',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            for (final item in items) _OrderItemRow(item: item),
          ],
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final CartItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(item.product.title)),
          const SizedBox(width: 12),
          Text('${item.quantity} шт.'),
          const SizedBox(width: 12),
          Text(_formatPrice(item.totalPrice)),
        ],
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  final double total;

  const _TotalCard({required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Итого',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              _formatPrice(total),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmRow extends StatelessWidget {
  final String title;
  final String value;

  const ConfirmRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final displayValue = value.isEmpty ? 'Не указано' : value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(displayValue),
        ],
      ),
    );
  }
}

String _formatPrice(double price) {
  return '\$${price.toStringAsFixed(2)}';
}
