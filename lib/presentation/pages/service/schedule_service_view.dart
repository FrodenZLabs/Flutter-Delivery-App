import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:intl/intl.dart';

class ScheduleServiceView extends StatefulWidget {
  const ScheduleServiceView({super.key});

  @override
  State<ScheduleServiceView> createState() => _ScheduleServiceViewState();
}

class _ScheduleServiceViewState extends State<ScheduleServiceView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Dummy Service Data
  final dummyService = {
    'name': 'Laundry Service',
    'subName': 'Same-day laundry and delivery',
    'image': 'assets/images/laundry.png',
  };

  // Dummy Delivery Info (Simulate empty and filled)
  Map<String, String>? dummyDeliveryInfo;

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: kSecondaryColor, // Header background & OK button
              onPrimary: kBackgroundColor, // Header text color
              onSurface: Colors.brown, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: kSecondaryColor, // Header background & OK button
              onPrimary: kBackgroundColor, // Header text color
              onSurface: Colors.brown, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule Delivery',
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
            // ✅ Service Details
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
                          fontSize: 18,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Delivery Information
            const Text(
              'Delivery Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            dummyDeliveryInfo == null
                ? GestureDetector(
                    onTap: () {
                      // Navigate to Delivery Info Selection Page
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.edit_location_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Select Delivery Information',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      // Navigate to change address
                      Navigator.pushNamed(context, '/delivery-info-list');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.brown.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address: ${dummyDeliveryInfo!['address']}'),
                          Text('City: ${dummyDeliveryInfo!['city']}'),
                          Text('Contact: ${dummyDeliveryInfo!['contact']}'),
                          const SizedBox(height: 6),
                          const Text(
                            'Change Address',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 20),

            // ✅ Schedule Date
            const Text(
              'Select Delivery Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  selectedDate != null
                      ? DateFormat.yMMMMd().format(selectedDate!)
                      : 'Choose a date',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Schedule Time
            const Text(
              'Select Time Slot',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: pickTime,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : 'Choose time',
                  style: TextStyle(
                    color: selectedTime != null ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: // ✅ Book Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Handle booking submission
              print('Booking scheduled for: $selectedDate at $selectedTime');
            },
            icon: const Icon(
              Icons.schedule_send,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(
              'Book Delivery',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
