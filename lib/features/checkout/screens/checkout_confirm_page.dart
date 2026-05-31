import 'package:flutter/material.dart';
import '../models/checkout_data.dart';

class CheckoutConfirmPage extends StatelessWidget {
  final CheckoutData data;

  const CheckoutConfirmPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подтверждение заказа'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Проверьте введенные данные',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConfirmRow(title: 'Имя', value: data.name),
                  ConfirmRow(title: 'Телефон', value: data.phone),
                  ConfirmRow(title: 'Адрес', value: data.address),
                  ConfirmRow(title: 'Комментарий', value: data.comment),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
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
        ),
      ),
    );
  }
}

class ConfirmRow extends StatelessWidget {
  final String title;
  final String value;

  const ConfirmRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value.isEmpty ? 'Не указано' : value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(displayValue),
        ],
      ),
    );
  }
}