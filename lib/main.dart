import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/di/injection.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/data/models/service/service_model.dart';
import 'package:flutter_delivery_app/data/models/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapter
  Hive.registerAdapter(ServiceModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(DeliveryInfoModelAdapter());

  // Initialize Dependency Injection
  await configureDependencies();

  // Launch the app
  runApp(const DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Labs Delivery Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const Placeholder(), // Replace with HomeScreen() later
    );
  }
}
