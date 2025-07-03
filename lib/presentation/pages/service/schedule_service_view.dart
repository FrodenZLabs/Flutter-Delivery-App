import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ScheduleServiceView extends StatefulWidget {
  final Service service;

  const ScheduleServiceView({super.key, required this.service});

  @override
  State<ScheduleServiceView> createState() => _ScheduleServiceViewState();
}

class _ScheduleServiceViewState extends State<ScheduleServiceView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
                  child: CachedNetworkImage(
                    imageUrl: widget.service.imageUrl,
                    height: 70,
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.service.subName,
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

            BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
              builder: (context, state) {
                if (state is DeliveryInfoFetchLoading) {
                  LoadingOverlay.show();
                } else {
                  LoadingOverlay.hide();
                }

                if (state is DeliveryInfoFetchSuccess) {
                  final selectedDeliveryInfo =
                      state.selectedDeliveryInformation;

                  if (selectedDeliveryInfo == null) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.deliveryInfo);
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
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.deliveryInfo);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.brown.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Address: ${selectedDeliveryInfo.address}'),
                            Text('City: ${selectedDeliveryInfo.city}'),
                            Text(
                              'Contact: ${selectedDeliveryInfo.contactNumber}',
                            ),
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
                    );
                  }
                } else {
                  return const Text('Failed to load delivery info');
                }
              },
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
          child: InputFormButton(
            onClick: () {},
            titleText: 'Book Delivery',
            icon: Icon(Icons.schedule_send, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
