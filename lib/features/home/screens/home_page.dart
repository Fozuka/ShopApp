import 'package:flutter/material.dart';

import '../../../shared/widgets/category_card.dart';
import '../../../shared/widgets/shop_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Магазин электроники',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.devices_other, size: 64),
                SizedBox(height: 16),
                Text(
                  'TechStore',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Смартфоны, ноутбуки, планшеты и мобильные аксессуары с быстрой доставкой.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Популярные категории',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const CategoryCard(icon: Icons.phone_android, title: 'Смартфоны'),
          const CategoryCard(icon: Icons.laptop_mac, title: 'Ноутбуки'),
          const CategoryCard(icon: Icons.tablet_android, title: 'Планшеты'),
          const CategoryCard(icon: Icons.headphones, title: 'Аксессуары'),
        ],
      ),
    );
  }
}
