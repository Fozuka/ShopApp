import 'package:flutter/material.dart';

import '../features/articles/screens/article_sites_page.dart';
import '../features/cart/presentation/screens/cart_page.dart';
import '../features/catalog/presentation/screens/catalog_page.dart';
import '../features/home/screens/home_page.dart';
import '../features/profile/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CatalogPage(),
    CartPage(),
    ArticleSitesPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.devices), label: 'Каталог'),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          NavigationDestination(icon: Icon(Icons.article), label: 'Статьи'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
