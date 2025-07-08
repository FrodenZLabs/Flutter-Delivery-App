import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/delivery/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/popular_service/popular_service_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/service/service_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/alert_card.dart';
import 'package:flutter_delivery_app/presentation/widgets/popular_service_card.dart';
import 'package:flutter_delivery_app/presentation/widgets/service_card.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    context.read<PopularServicesBloc>().add(
      LoadPopularServices(FilterServiceParams()),
    );
    context.read<ServiceBloc>().add(LoadAllServices(FilterServiceParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.brown,
          onRefresh: () async {
            context.read<PopularServicesBloc>().add(
              LoadPopularServices(FilterServiceParams()),
            );
            context.read<ServiceBloc>().add(
              LoadAllServices(FilterServiceParams()),
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLogged) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                kAppLogo, // <-- Replace with your actual logo path
                                height: 50,
                              ),
                              Text(
                                "Welcome, ${state.user.firstName} ${state.user.lastName}",
                                style: TextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context.read<NavbarCubit>().update(3);
                            },
                            child: state.user.imageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: state.user.imageUrl!,
                                    imageBuilder: (context, image) =>
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: image,
                                          backgroundColor: Colors.transparent,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: AssetImage(
                                            kUserAvatar,
                                          ),
                                          backgroundColor: Colors.transparent,
                                        ),
                                  )
                                : CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage(kUserAvatar),
                                    backgroundColor: Colors.transparent,
                                  ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                kAppLogo, // <-- Replace with your actual logo path
                                height: 50,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome,",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "K-Labs Delivery Services",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRouter.login);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
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
                const SizedBox(height: 20),

                BlocBuilder<PopularServicesBloc, PopularServicesState>(
                  builder: (context, state) {
                    if (state is PopularServicesLoading) {
                      return SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4, // Show 4 shimmer cards as placeholder
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.brown.shade100,
                              child:
                                  const PopularServiceCard(), // Make sure this supports empty state
                            );
                          },
                        ),
                      );
                    } else if (state is PopularServicesLoaded) {
                      return SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.services.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            return PopularServiceCard(
                              service: state.services[index],
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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
                const SizedBox(height: 20),
                BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (context, state) {
                    if (state is ServiceError && state.services.isEmpty) {
                      if (state.failure is NetworkFailure) {
                        return AlertCard(
                          image: kNoConnection,
                          message: "Network failure\n Try again",
                          onClick: () {
                            context.read<ServiceBloc>().add(
                              LoadAllServices(FilterServiceParams()),
                            );
                          },
                        );
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (state.failure is ServerFailure)
                              Image.asset(
                                kInternalServerError,
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            if (state.failure is CacheFailure)
                              Image.asset(
                                kNoConnection,
                                width: MediaQuery.of(context).size.width * 0.7,
                              ),
                            Text(
                              "Services not found",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ServiceBloc>().add(
                                  LoadAllServices(FilterServiceParams()),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8, // Adjust height/width ratio
                          ),
                      itemCount:
                          state.services.length +
                          ((state is ServiceLoading) ? 10 : 0),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (state.services.length > index) {
                          return ServiceCard(service: state.services[index]);
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.brown.shade50,
                            highlightColor: Colors.brown.shade100,
                            child: const ServiceCard(),
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
