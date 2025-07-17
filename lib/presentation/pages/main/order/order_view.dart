import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/schedule/schedule_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/alert_card.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Fetch schedules when the view initializes
    context.read<ScheduleBloc>().add(
      GetSchedulesByUserEvent(
        ScheduleModel(
          id: '',
          userId: '',
          serviceId: '',
          deliveryInfoId: '',
          scheduleDate: DateTime.now(),
          scheduleTime: '',
          status: '',
          name: '',
          subname: '',
          imageUrl: '',
          address: '',
          city: '',
          contact: '',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ScheduleModel> _filterSchedules(
    List<ScheduleModel> schedules,
    String statusFilter,
  ) {
    return schedules.where((schedule) {
      final status = schedule.status.toLowerCase();
      switch (statusFilter.toLowerCase()) {
        case 'pending':
          return status == 'pending' ||
              status.contains('placed') ||
              status.contains('assigned') ||
              status.contains('transit');
        case 'completed':
          return status == 'completed' || status.contains('delivered');
        case 'canceled':
          return status.contains('cancel');
        default:
          return false;
      }
    }).toList();
  }

  Widget buildOrderList(List<ScheduleModel> schedules, String statusFilter) {
    final filteredSchedules = _filterSchedules(schedules, statusFilter);

    if (filteredSchedules.isEmpty) {
      return const Center(child: Text('No orders in this category.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: filteredSchedules.length,
      separatorBuilder: (context, index) => const Divider(height: 5),
      itemBuilder: (context, index) {
        final schedule = filteredSchedules[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: schedule.imageUrl,
              height: 50,
              width: 50,
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
          title: Text(
            schedule.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${DateFormat('dd MMMM y').format(schedule.scheduleDate)} at ${schedule.scheduleTime}',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:
                  schedule.status == 'Pending' ||
                      schedule.status == 'Order Placed' ||
                      schedule.status == 'Driver Assigned' ||
                      schedule.status == 'In Transit'
                  ? Colors.orange.shade50
                  : schedule.status == 'Completed' ||
                        schedule.status == 'Delivered'
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              schedule.status,
              style: TextStyle(
                color:
                    schedule.status == 'Pending' ||
                        schedule.status == 'Order Placed' ||
                        schedule.status == 'Driver Assigned' ||
                        schedule.status == 'In Transit'
                    ? Colors.orange.shade800
                    : schedule.status == 'Completed' ||
                          schedule.status == 'Delivered'
                    ? Colors.green.shade800
                    : Colors.red.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(AppRouter.orderDetails, arguments: schedule);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.list_alt),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.brown.shade800,
          unselectedLabelColor: Colors.grey.shade700,
          indicatorColor: Colors.brown.shade800,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
            Tab(text: 'Canceled'),
          ],
        ),
        backgroundColor: Colors.brown.shade50,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleFetchFail) {
              if (state.failure is ServerFailure) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlertCard(
                      image: kEmpty,
                      message:
                          "No Orders Found.\n You haven't placed any orders yet",
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<NavbarCubit>().update(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        // padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Explore Services",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                );
              }
            } else if (state is ScheduleFetchLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            } else if (state is ScheduleFetchSuccess) {
              return TabBarView(
                controller: _tabController,
                children: [
                  buildOrderList(state.schedule, 'Pending'),
                  buildOrderList(state.schedule, 'Completed'),
                  buildOrderList(state.schedule, 'Canceled'),
                ],
              );
            }
            return AlertCard(
              image: kEmpty,
              message: "Session token expired.\n Please Login!",
            );
          },
        ),
      ),
    );
  }
}
