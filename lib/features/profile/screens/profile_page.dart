import 'package:flutter/material.dart';

import '../../../shared/widgets/shop_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Профиль',
      child: Column(
        children: [
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 16),
          const Text(
            'Пользователь',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('user@example.com'),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Адрес доставки'),
            subtitle: const Text('Москва, ул. Примерная, 10'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Способ оплаты'),
            subtitle: const Text('Банковская карта'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Поддержка'),
            subtitle: const Text('Связаться с магазином'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
