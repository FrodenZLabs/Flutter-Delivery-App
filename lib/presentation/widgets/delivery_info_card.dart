import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_delivery_app/presentation/widgets/delivery_info_form.dart';
import 'package:shimmer/shimmer.dart';

class DeliveryInfoCard extends StatelessWidget {
  final DeliveryInfo? deliveryInformation;
  final bool isSelected;

  const DeliveryInfoCard({
    super.key,
    this.isSelected = false,
    this.deliveryInformation,
  });

  @override
  Widget build(BuildContext context) {
    return deliveryInformation == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: buildBody(context),
          )
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          context.read<DeliveryInfoActionCubit>().selectDeliveryInfo(
            deliveryInformation!,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.brown.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.brown : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 25, color: Colors.brown),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: deliveryInformation == null
                          ? Container(
                              width: 120,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                          : Text(
                              deliveryInformation!.contactNumber,
                              style: const TextStyle(fontSize: 14),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                      child: deliveryInformation == null
                          ? Container(
                              width: 120,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                          : Text(
                              "${deliveryInformation!.address}, ${deliveryInformation!.city}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return DeliveryInfoForm(
                                deliveryInfo: deliveryInformation,
                              );
                            },
                          );
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.brown),
            ],
          ),
        ),
      ),
    );
  }
}
