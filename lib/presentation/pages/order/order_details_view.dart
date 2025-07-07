import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsView extends StatefulWidget {
  final ScheduleModel schedule;
  const OrderDetailsView({super.key, required this.schedule});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final dummyDriver = {
    'name': 'John Doe',
    'image': kMaleAvatar,
    'vehicle': 'Blue Sedan',
    'plate': 'KDA 123A',
  };

  List<Map<String, dynamic>> _getDeliveryStages(String status) {
    final statusLower = status.toLowerCase();
    final now = DateFormat('dd MMMM y, h:mm a').format(DateTime.now());

    return [
      {
        'title': 'Pending',
        'completed': true,
        'icon': Icons.hourglass_empty,
        'time': now,
      },
      {
        'title': 'Order Placed',
        'completed': statusLower != 'pending',
        'icon': Icons.shopping_cart,
        'time': now,
      },
      {
        'title': 'Driver Assigned',
        'completed':
            statusLower.contains('assigned') ||
            statusLower.contains('transit') ||
            statusLower.contains('delivered') ||
            statusLower.contains('completed'),
        'icon': Icons.person_pin_circle,
        'time': statusLower.contains('assigned') ? now : null,
      },
      {
        'title': 'In Transit',
        'completed':
            statusLower.contains('transit') ||
            statusLower.contains('delivered') ||
            statusLower.contains('completed'),
        'icon': Icons.local_shipping,
        'time': statusLower.contains('transit') ? now : null,
      },
      {
        'title': 'Delivered',
        'completed':
            statusLower.contains('delivered') ||
            statusLower.contains('completed'),
        'icon': Icons.check_circle,
        'time': statusLower.contains('delivered') ? now : null,
      },
    ];
  }

  Widget _buildDriverInfo() {
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $launchUri';
      }
    }

    Future<void> sendSms(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {'body': 'Hello driver, regarding my delivery...'},
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $launchUri';
      }
    }

    if (widget.schedule.driverId == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Driver Information',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity, // Stretches to full width
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red.shade50, // Light red background
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200, width: 1),
            ),
            child: Text(
              'No driver assigned yet',
              style: TextStyle(color: Colors.red.shade800, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                kMaleAvatar,
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
                    widget.schedule.driverName!,
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

        // Vehicle and Contact Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_car, size: 22, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  'Vehicle: ${widget.schedule.vehicleInfo}',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, size: 22, color: Colors.grey),
                const SizedBox(width: 10),
                Text(
                  'Contact: ${widget.schedule.driverContact}',
                  style: const TextStyle(fontSize: 15),
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
                  if (widget.schedule.driverContact != null &&
                      widget.schedule.driverContact!.isNotEmpty) {
                    makePhoneCall(widget.schedule.driverContact!);
                  } else {
                    // ✅ Show toast
                    toastification.show(
                      context: context,
                      title: Text("Contact Error"),
                      description: Text("Driver contact number not available"),
                      type: ToastificationType.error,
                      style: ToastificationStyle.minimal,
                      autoCloseDuration: const Duration(seconds: 10),
                      dragToClose: true,
                    );
                  }
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
                  if (widget.schedule.driverContact != null &&
                      widget.schedule.driverContact!.isNotEmpty) {
                    sendSms(widget.schedule.driverContact!);
                  } else {
                    // ✅ Show toast
                    toastification.show(
                      context: context,
                      title: Text("Contact Error"),
                      description: Text("Driver contact number not available"),
                      type: ToastificationType.error,
                      style: ToastificationStyle.minimal,
                      autoCloseDuration: const Duration(seconds: 10),
                      dragToClose: true,
                    );
                  }
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deliveryStages = _getDeliveryStages(widget.schedule.status);

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
                    kDryCleaning,
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
                        widget.schedule.serviceId,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Order #${widget.schedule.id}',
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
            Text(
              '${DateFormat('dd MMMM y').format(widget.schedule.scheduleDate)} at ${widget.schedule.scheduleTime}',
            ),

            const SizedBox(height: 12),
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text('address city'),
            Text('Contact: contact'),

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

            _buildDriverInfo(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
