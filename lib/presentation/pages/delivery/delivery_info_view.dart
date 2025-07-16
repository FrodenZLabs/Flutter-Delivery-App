import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/widgets/alert_card.dart';
import 'package:flutter_delivery_app/presentation/widgets/delivery_info_card.dart';
import 'package:flutter_delivery_app/presentation/widgets/delivery_info_form.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class DeliveryInfoView extends StatefulWidget {
  const DeliveryInfoView({super.key});

  @override
  State<DeliveryInfoView> createState() => _DeliveryInfoViewState();
}

class _DeliveryInfoViewState extends State<DeliveryInfoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        if (state is DeliveryInfoActionLoading) {
          LoadingOverlay.show();
        } else {
          LoadingOverlay.hide();
        }

        if (state is DeliveryInfoSelectActionSuccess) {
          context.read<DeliveryInfoFetchCubit>().selectDeliveryInfo(
            state.deliveryInfo,
          );
        } else if (state is DeliveryInfoActionFail) {
          String errorMessage = " An error occurred. Please try again";

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Delivery Selection Failed"),
            description: Text(errorMessage),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        }
      },
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
            builder: (context, state) {
              if (state is DeliveryInfoFetchSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();
                  },
                  child: ListView.builder(
                    itemCount: (state is DeliveryInfoFetchLoading)
                        ? 5
                        : state.deliveryInformation.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemBuilder: (context, index) {
                      // // Actual delivery info items
                      if (index < state.deliveryInformation.length) {
                        return DeliveryInfoCard(
                          deliveryInformation: state.deliveryInformation[index],
                          isSelected:
                              state.deliveryInformation[index] ==
                              state.selectedDeliveryInformation,
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade50,
                          highlightColor: Colors.brown.shade100,
                          child: DeliveryInfoCard(),
                        );
                      }
                    },
                  ),
                );
              }

              if (state is DeliveryInfoFetchFail) {
                if (state.failure is NotFoundFailure) {
                  return Center(
                    child: AlertCard(
                      image: kEmpty,
                      message: "Delivery Information is empty.",
                    ),
                  );
                } else if (state.failure is NetworkFailure) {
                  return Center(
                    child: AlertCard(
                      image: kNoConnection,
                      message: "Network failure.\n Check internet connection!",
                      onClick: () {
                        context
                            .read<DeliveryInfoFetchCubit>()
                            .fetchDeliveryInfo();
                      },
                    ),
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            },
          ),
        ),
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: kSecondaryColor,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const DeliveryInfoForm();
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
