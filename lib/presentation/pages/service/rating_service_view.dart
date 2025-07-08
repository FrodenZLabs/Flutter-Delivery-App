import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/data/models/schedule/schedule_model.dart';
import 'package:flutter_delivery_app/domain/entities/rating/rating.dart';
import 'package:flutter_delivery_app/domain/usecases/rating/add_rating_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/rating/rating_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class RatingServiceView extends StatefulWidget {
  final ScheduleModel schedule;

  const RatingServiceView({super.key, required this.schedule});

  @override
  State<RatingServiceView> createState() => _RatingServiceViewState();
}

class _RatingServiceViewState extends State<RatingServiceView> {
  String selectedRating = '';
  final TextEditingController commentController = TextEditingController();
  final TextEditingController tipController = TextEditingController();

  final List<String> ratingOptions = [
    'Great',
    'Good',
    'Okay',
    'Bad',
    'Terrible',
  ];

  @override
  void initState() {
    super.initState();
    // Trigger rating check when view loads
    context.read<RatingBloc>().add(CheckRatingsEvent(widget.schedule.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingBloc, RatingState>(
      listener: (context, state) {
        if (state is RatingCheckLoading || state is RatingAddLoading) {
          LoadingOverlay.show();
        } else {
          LoadingOverlay.hide();
        }

        if (state is RatingAddSuccess) {
          Navigator.pop(context, true); // Return success
          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Rating Success"),
            description: Text("Rating is successfully submitted."),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        } else if (state is RatingAddFailure) {
          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Rating Error"),
            description: Text("Failed to submit rating."),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text(
              'Rate Your Delivery',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            backgroundColor: kBackgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: kBackgroundColor,
          body: _buildBodyContent(context, state),
          bottomNavigationBar: _buildSubmitButton(context, state),
        );
      },
    );
  }

  Widget _buildBodyContent(BuildContext context, RatingState state) {
    if (state is RatingCheckFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load rating information'),
            TextButton(
              onPressed: () => context.read<RatingBloc>().add(
                CheckRatingsEvent(widget.schedule.id),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is RatingExistingSuccess) {
      // Show existing rating if it exists
      return _buildExistingRatingView(state.rating);
    }

    // Default view (including RatingCheckSuccess state)
    return _buildRatingForm(context);
  }

  Widget _buildExistingRatingView(Rating rating) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 60),
          const SizedBox(height: 20),
          const Text(
            'You already rated this delivery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Your rating: ${rating.rating}',
            style: const TextStyle(fontSize: 18),
          ),
          if (rating.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Comment:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(rating.comment, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<NavbarCubit>().update(0);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.home,
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Info Section
            if (widget.schedule.driverId != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      kMaleAvatar,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.schedule.driverName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.schedule.vehicleInfo!,
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],

            // Rating Question
            const Text(
              'How was your delivery?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ratingOptions.map((option) {
                final isSelected = selectedRating == option;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedRating = option),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.brown : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

            // Leave a Comment
            const Text(
              'Leave a Comment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your feedback here...',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tip Section
            const Text(
              'Tip Your Delivery Person (Optional)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: tipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter tip amount (e.g., Kshs. 100/=)',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, RatingState state) {
    if (state is RatingExistingSuccess) {
      return const SizedBox.shrink(); // Hide button if rating exists
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: state is RatingCheckSuccess && state.canRate
              ? () => _submitRating(context)
              : null,
          icon: const Icon(Icons.send, color: Colors.white),
          label: const Text(
            'Submit',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: state is RatingCheckSuccess && state.canRate
                ? kSecondaryColor
                : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  void _submitRating(BuildContext context) {
    if (selectedRating.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a rating')));
      return;
    }

    // Convert rating text to numerical value
    final ratingValue = _convertRatingToNumber(selectedRating);

    context.read<RatingBloc>().add(
      AddRatingEvent(
        RatingParams(
          scheduleId: widget.schedule.id,
          rating: ratingValue,
          comment: commentController.text,
        ),
      ),
    );
  }

  int _convertRatingToNumber(String ratingText) {
    switch (ratingText) {
      case 'Great':
        return 5;
      case 'Good':
        return 4;
      case 'Okay':
        return 3;
      case 'Bad':
        return 2;
      case 'Terrible':
        return 1;
      default:
        return 3;
    }
  }
}
