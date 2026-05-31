import 'package:flutter/material.dart';

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
