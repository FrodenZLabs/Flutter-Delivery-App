import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class DeliveryInfoView extends StatefulWidget {
  const DeliveryInfoView({super.key});

  @override
  State<DeliveryInfoView> createState() => _DeliveryInfoViewState();
}

class _DeliveryInfoViewState extends State<DeliveryInfoView> {
  // Dummy Delivery Info Data
  List<Map<String, dynamic>> deliveryInfos = [
    {
      'id': '1',
      'address': '123 K-Labs Street',
      'city': 'Nairobi',
      'contact': '+254712345678',
      'isDefault': true,
    },
    {
      'id': '2',
      'address': '456 Westlands Avenue',
      'city': 'Nairobi',
      'contact': '+254700987654',
      'isDefault': false,
    },
  ];

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  void showAddAddressModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Address',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      deliveryInfos.add({
                        'id': DateTime.now().toString(),
                        'address': _addressController.text,
                        'city': _cityController.text,
                        'contact': _contactController.text,
                        'isDefault': false,
                      });
                    });
                    Navigator.pop(context);
                    _addressController.clear();
                    _cityController.clear();
                    _contactController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        kSecondaryColor, // 👈 Background color here
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ), // Optional: Better padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Optional: Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Save Address',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void selectAsDefault(String id) {
    setState(() {
      for (var info in deliveryInfos) {
        info['isDefault'] = info['id'] == id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Delivery Addresses',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: deliveryInfos.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final info = deliveryInfos[index];
          return ListTile(
            onTap: () =>
                selectAsDefault(info['id']), // 👈 Set default on whole tile tap
            leading: const Icon(Icons.location_on),
            title: Text(info['address']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${info['city']}'),
                Text('Contact: ${info['contact']}'),
              ],
            ),
            trailing: info['isDefault']
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null, // 👈 No trailing button for non-default
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: showAddAddressModal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
