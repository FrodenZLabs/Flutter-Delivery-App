import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';

class ServiceDetailsView extends StatelessWidget {
  const ServiceDetailsView({super.key});

  // Dummy Service Data for testing
  final Service dummyService = const Service(
    id: '1',
    name: 'Dry Cleaning',
    subName: 'Expert Dry Cleaning Services',
    description:
        'We provide professional dry cleaning for all your clothes with doorstep pickup and delivery. Same-day and next-day service available.',
    imageUrl: 'assets/images/dry-cleaning.png',
    baseFee: 300.0,
    perKmFee: 50.0,
    available: true,
    openDay: 'Monday',
    closeDay: 'Friday',
    openTime: '8:00 AM',
    closeTime: '5:00 PM',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          dummyService.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image (30% height of screen)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Image.asset(dummyService.imageUrl, fit: BoxFit.cover),
            ),

            const SizedBox(height: 16),

            // Title and Subname
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dummyService.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dummyService.subName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                dummyService.description,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 16),

            // Pricing Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pricing',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Base Fee: Ksh ${dummyService.baseFee.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Price per Km: Ksh ${dummyService.perKmFee.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Availability Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Availability',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.brown,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${dummyService.openTime} - ${dummyService.closeTime}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.brown,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${dummyService.openDay} - ${dummyService.closeDay}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        dummyService.available
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: dummyService.available
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dummyService.available ? 'Available' : 'Not Available',
                        style: TextStyle(
                          color: dummyService.available
                              ? Colors.green
                              : Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Book Delivery Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Navigate to Booking Page
                  },
                  child: const Text(
                    'Book Delivery',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
