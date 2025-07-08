import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/pages/main/home/home_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/order/order_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/other/profile_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/search/search_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  final List<Widget> pages = const [
    HomeView(), // Services List
    SearchView(),
    OrderView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: context.read<NavbarCubit>().controller,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),

              // ✅ Bottom Nav Bar floating above
              Positioned(
                bottom: 10,
                left: 18,
                right: 18,
                child: StylishBottomBar(
                  option: DotBarOptions(dotStyle: DotStyle.tile),
                  borderRadius: const BorderRadius.all(Radius.circular(48)),
                  currentIndex: state,
                  onTap: (index) {
                    context.read<NavbarCubit>().update(index);
                  },
                  items: [
                    BottomBarItem(
                      selectedColor: Colors.blueAccent,
                      icon: const Icon(Icons.home),
                      selectedIcon: const Icon(Icons.home_filled),
                      title: const Text('Home'),
                    ),
                    BottomBarItem(
                      selectedColor: Colors.deepOrange,
                      icon: const Icon(Icons.search),
                      selectedIcon: const Icon(Icons.search),
                      title: const Text('Search'),
                    ),
                    BottomBarItem(
                      selectedColor: Colors.green,
                      icon: const Icon(Icons.description_outlined),
                      selectedIcon: const Icon(Icons.description),
                      title: const Text('Orders'),
                    ),
                    BottomBarItem(
                      selectedColor: Colors.deepPurpleAccent,
                      icon: const Icon(Icons.person_outline),
                      selectedIcon: const Icon(Icons.person),
                      title: const Text('Profile'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
