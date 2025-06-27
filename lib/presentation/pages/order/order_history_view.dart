import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:intl/intl.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  String selectedFilter = 'All';

  // Dummy Order History Data
  final List<Map<String, dynamic>> allOrders = [];

  List<Map<String, dynamic>> get filteredOrders {
    final now = DateTime.now();

    switch (selectedFilter) {
      case 'Recent':
        return allOrders
            .where(
              (order) =>
                  order['date'].isAfter(now.subtract(const Duration(days: 7))),
            )
            .toList();
      case 'Last Week':
        final start = now.subtract(const Duration(days: 14));
        final end = now.subtract(const Duration(days: 7));
        return allOrders
            .where(
              (order) =>
                  order['date'].isAfter(start) && order['date'].isBefore(end),
            )
            .toList();
      case 'Last Month':
        return allOrders
            .where(
              (order) =>
                  order['date'].isAfter(now.subtract(const Duration(days: 30))),
            )
            .toList();
      case 'Last 3 Months':
        return allOrders
            .where(
              (order) =>
                  order['date'].isAfter(now.subtract(const Duration(days: 90))),
            )
            .toList();
      case 'Last 6 Months':
        return allOrders
            .where(
              (order) => order['date'].isAfter(
                now.subtract(const Duration(days: 180)),
              ),
            )
            .toList();
      default:
        return allOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ✅ Filter Buttons (Non-scrollable horizontal Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterButton('All'),
                filterButton('Recent'),
                filterButton('Last Week'),
                filterButton('Last Month'),
                filterButton('Last 3 Months'),
                filterButton('Last 6 Months'),
              ],
            ),
            const SizedBox(height: 16),

            // ✅ Order History List
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(
                      child: Text('No orders found for this filter.'),
                    )
                  : ListView.separated(
                      itemCount: filteredOrders.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              order['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(order['name']),
                          subtitle: Text(
                            DateFormat.yMMMd().format(order['date']),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            // TODO: Navigate to Order Details
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterButton(String title) {
    final isSelected = selectedFilter == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedFilter = title);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.brown.shade300 : Colors.brown.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.brown.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
