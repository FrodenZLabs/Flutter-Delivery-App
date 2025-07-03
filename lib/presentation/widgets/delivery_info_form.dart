import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/data/models/delivery/delivery_info_model.dart';
import 'package:flutter_delivery_app/domain/entities/delivery/delivery_info.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_text_form_field.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class DeliveryInfoForm extends StatefulWidget {
  final DeliveryInfo? deliveryInfo;

  const DeliveryInfoForm({super.key, this.deliveryInfo});

  @override
  State<DeliveryInfoForm> createState() => _DeliveryInfoFormState();
}

class _DeliveryInfoFormState extends State<DeliveryInfoForm> {
  String? id;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.deliveryInfo != null) {
      id = widget.deliveryInfo!.id;
      _addressController.text = widget.deliveryInfo!.address;
      _cityController.text = widget.deliveryInfo!.city;
      _contactController.text = widget.deliveryInfo!.contactNumber;
    }
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

        if (state is DeliveryInfoAddActionSuccess) {
          Navigator.of(context).pop();
          context.read<DeliveryInfoFetchCubit>().addDeliveryInfo(
            state.deliveryInfo,
          );
          context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Delivery Success"),
            description: Text("Delivery Information successfully added"),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        } else if (state is DeliveryInfoEditActionSuccess) {
          Navigator.of(context).pop();
          context.read<DeliveryInfoFetchCubit>().editDeliveryInfo(
            state.deliveryInfo,
          );
          context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Delivery Success"),
            description: Text("Delivery Information successfully edited"),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        } else if (state is DeliveryInfoActionFail) {
          String errorMessage = " An error occurred. Please try again";

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Delivery Addition Failed"),
            description: Text(errorMessage),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputTextFormField(
                    controller: _addressController,
                    textInputAction: TextInputAction.next,
                    hint: "Address",
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _cityController,
                    textInputAction: TextInputAction.next,
                    hint: "City",
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _contactController,
                    hint: "Contact Number",
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  InputFormButton(
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        final deliveryInfoModel = DeliveryInfoModel(
                          id:
                              widget.deliveryInfo?.id ??
                              '', // Keep id if editing, empty if new
                          userId: '', // Let Cubit fill this
                          address: _addressController.text,
                          city: _cityController.text,
                          contactNumber: _contactController.text,
                        );

                        if (widget.deliveryInfo == null) {
                          // Add new address
                          context
                              .read<DeliveryInfoActionCubit>()
                              .addDeliveryInfo(deliveryInfoModel);
                        } else {
                          // Edit existing address
                          context
                              .read<DeliveryInfoActionCubit>()
                              .editDeliveryInfo(deliveryInfoModel);
                        }
                      }
                    },
                    titleText: widget.deliveryInfo == null
                        ? "Save Address"
                        : "Update Address",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
