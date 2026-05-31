import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/presentation/providers/cart_provider.dart';
import '../models/checkout_data.dart';
import 'checkout_confirm_page.dart';

class CheckoutFormPage extends ConsumerStatefulWidget {
  const CheckoutFormPage({super.key});

  @override
  ConsumerState<CheckoutFormPage> createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends ConsumerState<CheckoutFormPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();

  void openConfirmPage() {
    final items = ref.read(cartProvider);

    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Корзина пуста')));
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    final checkoutData = CheckoutData(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      comment: commentController.text.trim(),
      items: List.unmodifiable(items),
      total: ref.read(cartTotalProvider),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutConfirmPage(data: checkoutData),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsCount = ref.watch(cartItemsCountProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Оформление заказа'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OrderSummary(itemsCount: itemsCount, total: total),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Имя',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Телефон',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final phone = value?.trim() ?? '';
                    if (phone.length < 7) {
                      return 'Введите телефон';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Адрес доставки',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'Введите адрес доставки';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Комментарий',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: openConfirmPage,
                    child: const Text('Перейти к подтверждению'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final int itemsCount;
  final double total;

  const _OrderSummary({required this.itemsCount, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Товаров: $itemsCount'),
                  const SizedBox(height: 4),
                  Text(
                    'Сумма: ${_formatPrice(total)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatPrice(double price) {
  return '\$${price.toStringAsFixed(2)}';
}
