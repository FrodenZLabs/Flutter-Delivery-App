import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_form_button.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ServiceDetailsView extends StatefulWidget {
  final Service service;

  const ServiceDetailsView({super.key, required this.service});

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  final NumberFormat currencyFormat = NumberFormat('#,##0');
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
          widget.service.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
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
              child: CachedNetworkImage(
                imageUrl: widget.service.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.white,
                  child: Container(color: Colors.grey.shade300),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),

            const SizedBox(height: 16),

            // Title and Subname
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.service.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.service.subName,
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
                widget.service.description,
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
                    'Base Fee: Ksh ${currencyFormat.format(widget.service.baseFee)}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Price per Km: Ksh ${currencyFormat.format(widget.service.perKmFee)}',
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
                        '${widget.service.openTime} - ${widget.service.closeTime}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 18,
                        color: Colors.brown,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.service.openDay} - ${widget.service.closeDay}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        widget.service.available
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: widget.service.available
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.service.available
                            ? 'Available'
                            : 'Not Available',
                        style: TextStyle(
                          color: widget.service.available
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
                child: InputFormButton(
                  onClick: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRouter.schedule, arguments: widget.service);
                  },
                  titleText: 'Book Delivery',
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
