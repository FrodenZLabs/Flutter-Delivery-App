import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> pendingOrders = [
    {
      'orderId': 'ORD001',
      'service': 'Food Delivery',
      'date': '26 June 2025',
      'status': 'Pending',
    },
    {
      'orderId': 'ORD002',
      'service': 'Parcel Pickup',
      'date': '25 June 2025',
      'status': 'Pending',
    },
  ];

  final List<Map<String, String>> completedOrders = [
    {
      'orderId': 'ORD003',
      'service': 'Grocery Delivery',
      'date': '24 June 2025',
      'status': 'Completed',
    },
    {
      'orderId': 'ORD004',
      'service': 'Laundry Service',
      'date': '23 June 2025',
      'status': 'Completed',
    },
  ];

  final List<Map<String, String>> canceledOrders = [
    {
      'orderId': 'ORD005',
      'service': 'Courier Service',
      'date': '22 June 2025',
      'status': 'Canceled',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildOrderList(List<Map<String, String>> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('No orders in this category.'));
    }

    return ListView.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          leading: const Icon(Icons.local_shipping, color: Colors.blueAccent),
          title: Text(order['service']!),
          subtitle: Text('Date: ${order['date']}'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: order['status'] == 'Pending'
                  ? Colors.orange.shade50
                  : order['status'] == 'Completed'
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              order['status']!,
              style: TextStyle(
                color: order['status'] == 'Pending'
                    ? Colors.orange.shade800
                    : order['status'] == 'Completed'
                    ? Colors.green.shade800
                    : Colors.red.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          onTap: () {
            // TODO: Navigate to order details
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.brown.shade800,
          unselectedLabelColor: Colors.grey.shade700,
          indicatorColor: Colors.brown.shade800,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
            Tab(text: 'Canceled'),
          ],
        ),
        backgroundColor: Colors.brown.shade50,
      ),
      backgroundColor: kBackgroundColor,
      body: TabBarView(
        controller: _tabController,
        children: [
          buildOrderList(pendingOrders),
          buildOrderList(completedOrders),
          buildOrderList(canceledOrders),
        ],
      ),
    );
  }
}
