import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  List<Map<String, dynamic>> allServices = [
    {
      'title': 'Tailoring',
      'price': 100,
      'popularity': 5,
      'image': 'assets/images/tailoring.png',
      'subtitle': 'Custom tailoring and alterations',
    },
    {
      'title': 'Grocery Delivery',
      'price': 80,
      'popularity': 4,
      'image': 'assets/images/shoe-repair.png',
      'subtitle': 'Professional shoe repair',
    },
    {
      'title': 'Laundry Service',
      'price': 150,
      'popularity': 3,
      'image': 'assets/images/laundry.png',
      'subtitle': 'Same-day pickup and delivery',
    },
    {
      'title': 'Parcel Pickup',
      'price': 70,
      'popularity': 2,
      'image': 'assets/images/tailoring.png',
      'subtitle': 'Custom tailoring and alterations',
    },
    {
      'title': 'Dry Cleaning',
      'price': 60,
      'popularity': 1,
      'image': 'assets/images/dry-cleaning.png',
      'subtitle': 'Expert dry cleaning services',
    },
  ];

  List<Map<String, dynamic>> filteredServices = [];

  String selectedFilter = 'Popular';

  @override
  void initState() {
    super.initState();
    filteredServices = List.from(allServices);
    applyFilter();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      setState(() {
        _scrollProgress = maxScroll == 0
            ? 0
            : (currentScroll / maxScroll).clamp(0.0, 1.0);
      });
    });
  }

  void applyFilter() {
    List<Map<String, dynamic>> tempList = List.from(allServices);

    if (selectedFilter == 'Popular') {
      tempList.sort((a, b) => b['popularity'].compareTo(a['popularity']));
    } else if (selectedFilter == 'A-Z') {
      tempList.sort((a, b) => a['title'].compareTo(b['title']));
    } else if (selectedFilter == 'Z-A') {
      tempList.sort((a, b) => b['title'].compareTo(a['title']));
    } else if (selectedFilter == 'Price Low-High') {
      tempList.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (selectedFilter == 'Price High-Low') {
      tempList.sort((a, b) => b['price'].compareTo(a['price']));
    }

    setState(() {
      filteredServices = tempList
          .where(
            (service) => service['title'].toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Services',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                    applyFilter();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                applyFilter();
              },
            ),

            const SizedBox(height: 16),

            // 🧰 Filter Options + Scroll Progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      filterButton('Popular'),
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
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjust height/width ratio
                ),
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: Navigate to service details
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              service['image'],
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service['subtitle'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget filterButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(title),
        backgroundColor: Colors.brown.shade300,
        selectedColor: Colors.brown.shade500,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white),
        selected: selectedFilter == title,
        onSelected: (selected) {
          setState(() {
            selectedFilter = title;
            applyFilter();
          });
        },
      ),
    );
  }
}
