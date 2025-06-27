import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  String? selectedMethod;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Mastercard/Visa Card',
      'image':
          'assets/images/mastercard.jpeg', // ✅ Replace with your actual image paths
    },
    {'name': 'M-pesa', 'image': 'assets/images/mpesa.png'},
    {'name': 'Paypal', 'image': 'assets/images/paypal.png'},
  ];

  void selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  void savePaymentMethod() {
    // TODO: Implement save logic
    print('Selected Payment Method: $selectedMethod');
    Navigator.pop(context); // Example: Pop the page after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...paymentMethods.map((method) {
              final isSelected = selectedMethod == method['name'];
              return GestureDetector(
                onTap: () => selectMethod(method['name']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.brown.shade100
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.brown : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        method['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        method['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.brown : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Colors.brown),
                    ],
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedMethod != null ? savePaymentMethod : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Payment Method',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
