import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👤 Profile Avatar
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                  'assets/images/female-avatar.png',
                ), // Replace with your asset path
              ),
            ),
            const SizedBox(height: 12),

            // 👥 Name
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // 📧 Email
            const Text(
              'john.doe@example.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 20),

            // 💳 Payment Method (Clickable)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.blueAccent),
              title: const Text('Payment Method'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Navigate to payment method selection page
              },
            ),

            const Divider(height: 30),

            // 📋 Personal Details
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.email_outlined, color: Colors.orange),
              title: const Text('Email'),
              subtitle: const Text('john.doe@example.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone_outlined, color: Colors.green),
              title: const Text('Phone Number'),
              subtitle: const Text('+254 712 345 678'),
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on_outlined,
                color: Colors.redAccent,
              ),
              title: const Text('Address'),
              subtitle: const Text('Nairobi, Kenya'),
            ),

            const Divider(height: 30),

            // 📖 View Booking History (Clickable)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.deepPurple),
              title: const Text('View Booking History'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Navigate to booking history page
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
