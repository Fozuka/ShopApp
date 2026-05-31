import 'package:flutter/material.dart';
import '../models/checkout_data.dart';
import 'checkout_confirm_page.dart';

class CheckoutFormPage extends StatefulWidget {
  const CheckoutFormPage({super.key});

  @override
  State<CheckoutFormPage> createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends State<CheckoutFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  void openConfirmPage() {
    final checkoutData = CheckoutData(
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      comment: commentController.text,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Телефон',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Адрес доставки',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
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
    );
  }
}