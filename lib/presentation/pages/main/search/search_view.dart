import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/domain/usecases/service/get_service_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/service/service_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/alert_card.dart';
import 'package:flutter_delivery_app/presentation/widgets/service_card.dart';
import 'package:shimmer/shimmer.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String selectedFilter = 'All';
  ServiceSortOrder selectedSort = ServiceSortOrder.all;

  double _scrollProgress = 0.0;

  void _scrollListener() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double scrollPercentage = 0.7;

    setState(() {
      _scrollProgress = (currentScroll / maxScroll).clamp(0.0, 1.0);
    });

    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<ServiceBloc>().state is ServiceLoaded) {
        context.read<ServiceBloc>().add(const LoadMoreServices());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // ✅ Trigger service load when page first opens
    context.read<ServiceBloc>().add(LoadAllServices(FilterServiceParams()));
  }

  ServiceSortOrder mapFilterToSort(String filter) {
    switch (filter) {
      case 'Price Low-High':
        return ServiceSortOrder.priceLow;
      case 'Price High-Low':
        return ServiceSortOrder.priceHigh;
      case 'A-Z':
        return ServiceSortOrder.aToZ;
      case 'Z-A':
        return ServiceSortOrder.zToA;
      default:
        return ServiceSortOrder.all;
    }
  }

  Widget filterButton(String title) {
    final isSelected = selectedFilter == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(title),
        backgroundColor: Colors.brown.shade300,
        selectedColor: Colors.brown.shade500,
        checkmarkColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.white),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedFilter = title;
            selectedSort = mapFilterToSort(title);
          });

          context.read<ServiceBloc>().add(
            LoadAllServices(
              FilterServiceParams(
                keyword: _searchController.text,
                sort: selectedSort,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          children: [
            const SizedBox(height: 25),
            // 🔍 Search Field
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ServiceBloc>().add(
                      LoadAllServices(
                        FilterServiceParams(keyword: '', sort: selectedSort),
                      ),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<ServiceBloc>().add(
                  LoadAllServices(
                    FilterServiceParams(keyword: value, sort: selectedSort),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // 🧰 Filter Options + Scroll Progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      filterButton('All'),
                      filterButton('Price Low-High'),
                      filterButton('Price High-Low'),
                      filterButton('A-Z'),
                      filterButton('Z-A'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: _scrollProgress,
                  minHeight: 4,
                  backgroundColor: Colors.grey[300],
                  color: Colors.brown,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  if (state is ServiceLoaded && state.services.isEmpty) {
                    return AlertCard(
                      image: kEmpty,
                      message: "Services not found",
                    );
                  }

                  if (state is ServiceError && state.services.isEmpty) {
                    if (state.failure is NetworkFailure) {
                      return AlertCard(
                        image: kNoConnection,
                        message: "Network failure\n Try again",
                        onClick: () {
                          context.read<ServiceBloc>().add(
                            LoadAllServices(
                              FilterServiceParams(
                                keyword: context
                                    .read<FilterServiceCubit>()
                                    .searchController
                                    .text,
                              ),
                            ),
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
                                LoadAllServices(
                                  FilterServiceParams(
                                    keyword: context
                                        .read<FilterServiceCubit>()
                                        .searchController
                                        .text,
                                  ),
                                ),
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

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ServiceBloc>().add(
                        LoadAllServices(FilterServiceParams()),
                      );
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 80,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8, // Adjust height/width ratio
                          ),
                      controller: _scrollController,
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
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.white,
                            child: const ServiceCard(),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
