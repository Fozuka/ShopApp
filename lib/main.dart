import 'package:flutter/material.dart';
import 'features/checkout/screens/checkout_form_page.dart';
import 'features/articles/screens/article_sites_page.dart';
import 'features/catalog/data/product_local_data_source.dart';
import 'features/catalog/models/product.dart';

void main() {
  runApp(const ElectronicsShopApp());
}

class ElectronicsShopApp extends StatelessWidget {
  const ElectronicsShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronics Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

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
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.devices),
            label: 'Каталог',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          NavigationDestination(
            icon: Icon(Icons.article),
            label: 'Статьи',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

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
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Смартфоны, ноутбуки, наушники и другие гаджеты с быстрой доставкой.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Популярные категории',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const CategoryCard(
            icon: Icons.phone_android,
            title: 'Смартфоны',
          ),
          const CategoryCard(
            icon: Icons.laptop_mac,
            title: 'Ноутбуки',
          ),
          const CategoryCard(
            icon: Icons.headphones,
            title: 'Аудиотехника',
          ),
          const CategoryCard(
            icon: Icons.watch,
            title: 'Смарт-часы',
          ),
        ],
      ),
    );
  }
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final ProductLocalDataSource dataSource = ProductLocalDataSource();

  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = dataSource.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Каталог электроники',
      child: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Text(
              'Ошибка загрузки товаров',
              style: TextStyle(fontSize: 18),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Text(
              'Список товаров пуст',
              style: TextStyle(fontSize: 18),
            );
          }

          return Column(
            children: products
                .map(
                  (product) => ProductCard(
                imagePath: product.imagePath,
                title: product.title,
                price: product.price,
              ),
            )
                .toList(),
          );
        },
      ),
    );
  }
}

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

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Мои заказы',
      child: Column(
        children: const [
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShopScreen(
      title: 'Профиль',
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          const Text(
            'Пользователь',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
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

class ShopScreen extends StatelessWidget {
  final String title;
  final Widget child;

  const ShopScreen({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 36),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 74,
              height: 74,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Купить'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String number;
  final String status;
  final String price;

  const OrderCard({
    super.key,
    required this.number,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.inventory_2),
        title: Text(number),
        subtitle: Text(status),
        trailing: Text(price),
      ),
    );
  }
}