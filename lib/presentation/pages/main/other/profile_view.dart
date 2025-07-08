import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          children: [
            const Icon(
              Icons.person,
              size: 30,
              color: Colors.black, // ✅ Adjust icon color if needed
            ),
            const SizedBox(width: 24),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color:
                    Colors.black, // ✅ Optional: Ensure text color matches theme
              ),
            ),
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👤 Profile Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLogged) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRouter.profile, arguments: state.user);
                      },
                      child: Column(
                        children: [
                          state.user.imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: state.user.imageUrl!,
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                        radius: 35.sp,
                                        backgroundImage: image,
                                        backgroundColor: Colors.transparent,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        radius: 35.sp,
                                        backgroundImage: AssetImage(
                                          kUserAvatar,
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                )
                              : CircleAvatar(
                                  radius: 35.sp,
                                  backgroundImage: AssetImage(kUserAvatar),
                                  backgroundColor: Colors.transparent,
                                ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${state.user.firstName} ${state.user.lastName}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                state.user.email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.login);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35.sp,
                            backgroundImage: AssetImage(kUserAvatar),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login to your account",
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            // 💳 Payment Method (Clickable)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.payment, color: Colors.blueAccent),
                  title: const Text('Payment Method'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    if (state is UserLogged) {
                      Navigator.of(context).pushNamed(AppRouter.payment);
                    } else {
                      Navigator.of(context).pushNamed(AppRouter.login);
                    }
                  },
                );
              },
            ),

            const Divider(height: 30),

            // 📋 Personal Details
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.send, color: Colors.amberAccent),
                  title: const Text('Delivery Info'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    if (state is UserLogged) {
                      Navigator.of(context).pushNamed(AppRouter.deliveryInfo);
                    } else {
                      Navigator.of(context).pushNamed(AppRouter.login);
                    }
                  },
                );
              },
            ),

            const Divider(height: 30),

            // 📖 View Booking History (Clickable)
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "History",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // BlocBuilder<UserBloc, UserState>(
            //   builder: (context, state) {
            //     return ListTile(
            //       leading: const Icon(Icons.history, color: Colors.deepPurple),
            //       title: const Text('View Booking History'),
            //       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            //       onTap: () {
            //         if (state is UserLogged) {
            //           Navigator.of(context).pushNamed(AppRouter.orderHistory);
            //         } else {
            //           Navigator.of(context).pushNamed(AppRouter.login);
            //         }
            //       },
            //     );
            //   },
            // ),
            // const Divider(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              title: const Text('Sign Out'),
              onTap: () async {
                await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: kBackgroundColor,
                    title: const Text(
                      'Confirm Logout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // This creates space between buttons
                        children: [
                          Expanded(
                            // Makes buttons share available space equally
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ), // Adds spacing between buttons
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<UserBloc>().add(LogoutUserEvent());
                                Navigator.of(context).pop(true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kSecondaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}
