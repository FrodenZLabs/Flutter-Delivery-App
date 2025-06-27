import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for testing
    final dummyService = {
      'name': 'Laundry Service',
      'subName': 'Same-day laundry and delivery',
      'image': 'assets/images/laundry.png',
    };

    final dummyDeliveryInfo = {
      'address': '123 K-Labs Street',
      'city': 'Nairobi',
      'contact': '+254712345678',
    };

    final dummyDriver = {
      'name': 'John Doe',
      'image': 'assets/images/male-avatar.png',
      'vehicle': 'Blue Sedan',
      'plate': 'KDA 123A',
    };

    final List<Map<String, dynamic>> deliveryStages = [
      {
        'title': 'Pending',
        'completed': true,
        'icon': Icons.hourglass_empty,
        'time': '26 June 2025, 8:00 AM',
      },
      {
        'title': 'Order Placed',
        'completed': true,
        'icon': Icons.shopping_cart,
        'time': '26 June 2025, 8:10 AM',
      },
      {
        'title': 'Driver Assigned',
        'completed': true,
        'icon': Icons.person_pin_circle,
        'time': '26 June 2025, 8:30 AM',
      },
      {
        'title': 'In Transit',
        'completed': false,
        'icon': Icons.local_shipping,
        'time': null, // Not yet updated
      },
      {
        'title': 'Delivered',
        'completed': false,
        'icon': Icons.check_circle,
        'time': null,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Service Info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    dummyService['image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyService['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dummyService['subName']!,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Schedule Date & Delivery Info
            const Text(
              'Scheduled Date',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text('26th June 2025 at 10:00 AM'),

            const SizedBox(height: 12),
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              '${dummyDeliveryInfo['address']}, ${dummyDeliveryInfo['city']}',
            ),
            Text('Contact: ${dummyDeliveryInfo['contact']}'),

            const SizedBox(height: 20),

            // ✅ Delivery Status Vertical Timeline
            const Text(
              'Delivery Status',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(deliveryStages.length, (index) {
                final stage = deliveryStages[index];
                final isCompleted = stage['completed'] as bool;
                final isLast = index == deliveryStages.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Icon and line
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          stage['icon'],
                          size: 25,
                          color: isCompleted ? Colors.green : Colors.grey,
                        ),
                        if (!isLast)
                          Container(
                            width: 3,
                            height: 40,
                            color: isCompleted ? Colors.green : Colors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // ✅ Stage title and time
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stage['title'],
                              style: TextStyle(
                                fontSize: 16,
                                color: isCompleted ? Colors.green : Colors.grey,
                                fontWeight: isCompleted
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              stage['time'] != null
                                  ? stage['time']!
                                  : 'Not updated yet',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),

            // ✅ Driver Info
            const Text(
              'Driver Information',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(height: 8),

            // Row for Image and Name
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    dummyDriver['image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyDriver['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Driver",
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.brown,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Vehicle and Plate Row (on a new line)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_car,
                      size: 22,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Vehicle: ${dummyDriver['vehicle']!}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.confirmation_number,
                      size: 22,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Plate: ${dummyDriver['plate']}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Contact Driver Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Calling driver...');
                    },
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Messaging driver...');
                    },
                    icon: const Icon(Icons.message, color: Colors.black54),
                    label: const Text(
                      'Message',
                      style: TextStyle(color: Colors.black54),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
