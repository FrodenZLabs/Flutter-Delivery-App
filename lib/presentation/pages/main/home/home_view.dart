import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy Data with image paths
  final List<Map<String, String>> popularServices = [
    {'title': 'Food Delivery', 'image': kPharmacy},
    {'title': 'Grocery Delivery', 'image': kGrocery},
    {'title': 'Parcel Pickup', 'image': kPromotions},
    {'title': 'Laundry Service', 'image': kPharmacy},
  ];

  final List<Map<String, String>> featuredServices = [
    {
      'image': kLaundry,
      'title': 'Laundry Service',
      'subtitle': 'Same-day pickup and delivery',
    },
    {
      'image': kDryCleaning,
      'title': 'Water Delivery',
      'subtitle': 'Expert dry cleaning services',
    },
    {
      'image': kShoeRepair,
      'title': 'Shoe Repair',
      'subtitle': 'Professional shoe repair',
    },
    {
      'image': kTailoring,
      'title': 'Tailoring',
      'subtitle': 'Custom tailoring and alterations',
    },
    {
      'image': kDryCleaning,
      'title': 'Document Delivery',
      'subtitle': 'Expert dry cleaning services',
    },
    {
      'image': kLaundry,
      'title': 'Cake Delivery',
      'subtitle': 'Same-day pickup and delivery',
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(CheckUserEvent());
    context.read<DeliveryInfoFetchCubit>().fetchDeliveryInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ✅ Logo Image
            Image.asset(
              kAppLogo, // <-- Replace with your actual logo path
              height: 50,
            ),
            const SizedBox(width: 16), // Space between image and text
            // ✅ Text Title
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'K-Labs',
                  style: TextStyle(
                    fontSize: 22,

                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Adjust if needed
                  ),
                ),
                Text(
                  'Delivery Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
        // ✅ Add Avatar Icon Button on the Right
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRouter.profile,
                ); // <-- Make sure profile route exists
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  kUserAvatar,
                ), // <-- Put your user avatar image here
                backgroundColor:
                    Colors.grey[300], // fallback color if image fails
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),

              // ⭐ Popular Services (Horizontal Cards with Image and Label)
              const Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: popularServices.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final service = popularServices[index];
                    return SizedBox(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: Image.asset(
                                service['image']!,
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Text(
                                service['title']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 🎉 Promotions Section
              const Text(
                'Promotions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Offer Text
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Limited Time Offer!',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Free delivery on orders over 10,000/=',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Valid until 31st July",
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 4),

                    // Right: Promo Image
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          kPromotions,
                          height: 130,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🌟 Featured Services (Grid with Image + Title + Subtitle)
              const Text(
                'Featured Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      0.8, // Slightly taller for image + 2 text lines
                ),
                itemCount: featuredServices.length,
                itemBuilder: (context, index) {
                  final service = featuredServices[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            service['image']!,
                            height: 140, // 🔥 Consistent image size for all
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service['subtitle']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.brown,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
