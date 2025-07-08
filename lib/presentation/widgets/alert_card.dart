import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String image;
  final String? message;
  final Function()? onClick;

  const AlertCard({super.key, required this.image, this.message, this.onClick});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            SizedBox(height: 20),
            if (message != null)
              Container(
                width: double.infinity, // Takes full width
                padding: const EdgeInsets.all(8), // Adds inner spacing
                decoration: BoxDecoration(
                  color: Colors.red.shade100, // Light red background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(
                    color: Colors.red.shade300, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: Text(
                  message!,
                  style: TextStyle(
                    color: Colors.red.shade800, // Darker red text for contrast
                    fontSize: 18,
                    fontWeight: FontWeight.w500, // Slightly bold
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
            if (onClick != null)
              IconButton(
                onPressed: onClick,
                icon: Icon(Icons.refresh, size: 35),
              ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
