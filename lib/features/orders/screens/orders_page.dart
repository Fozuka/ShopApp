import 'package:flutter/material.dart';

import '../../../shared/widgets/order_card.dart';
import '../../../shared/widgets/shop_screen.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Мои заказы',
      child: const Column(
        children: [
          OrderCard(
            number: 'Заказ №1024',
            status: 'Доставляется',
            price: '154 980 ₽',
          ),
          OrderCard(
            number: 'Заказ №1018',
            status: 'Выполнен',
            price: '79 990 ₽',
          ),
          OrderCard(
            number: 'Заказ №1009',
            status: 'Отменен',
            price: '24 990 ₽',
          ),
        ],
      ),
    );
  }
}
