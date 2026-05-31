import 'package:flutter/material.dart';

import '../../../shared/widgets/product_card.dart';
import '../../../shared/widgets/shop_screen.dart';
import '../../checkout/screens/checkout_form_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Корзина',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductCard(
            imagePath: 'assets/images/phone.png',
            title: 'iPhone 15 Pro',
            price: '129 990 ₽',
          ),
          const ProductCard(
            imagePath: 'assets/images/headphones.png',
            title: 'AirPods Pro',
            price: '24 990 ₽',
          ),
          const SizedBox(height: 20),
          const Text(
            'Итого: 154 980 ₽',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutFormPage(),
                  ),
                );
              },
              child: const Text('Оформить заказ'),
            ),
          ),
        ],
      ),
    );
  }
}
