import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/error/exceptions.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:flutter_delivery_app/presentation/pages/authentication/sign_in_view.dart';
import 'package:flutter_delivery_app/presentation/pages/authentication/sign_up_view.dart';
import 'package:flutter_delivery_app/presentation/pages/delivery/delivery_info_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/main_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/order/order_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/other/profile_view.dart';
import 'package:flutter_delivery_app/presentation/pages/main/search/search_view.dart';
import 'package:flutter_delivery_app/presentation/pages/order/order_details_view.dart';
import 'package:flutter_delivery_app/presentation/pages/order/order_history_view.dart';
import 'package:flutter_delivery_app/presentation/pages/payment/payment_method_view.dart';
import 'package:flutter_delivery_app/presentation/pages/service/rating_service_view.dart';
import 'package:flutter_delivery_app/presentation/pages/service/schedule_service_view.dart';
import 'package:flutter_delivery_app/presentation/pages/service/service_details_view.dart';

class AppRouter {
  // Main menu
  static const String home = '/';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String orders = '/orders';

  // Authentication
  static const String register = '/sign-up';
  static const String login = '/sign-in';

  // Services
  static const String serviceDetails = '/service-details';
  static const String ratings = '/ratings';
  static const String schedule = '/schedule';

  // Other
  static const String deliveryInfo = '/delivery-details';
  static const String payment = '/payment-details';

  // Order
  static const String orderDetails = '/order-details';
  static const String orderHistory = '/order-history';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderView());
      case register:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case login:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case serviceDetails:
        Service service = routeSettings.arguments as Service;
        return MaterialPageRoute(
          builder: (_) => ServiceDetailsView(service: service),
        );
      case ratings:
        return MaterialPageRoute(builder: (_) => const RatingServiceView());
      case schedule:
        Service service = routeSettings.arguments as Service;
        return MaterialPageRoute(
          builder: (_) => ScheduleServiceView(service: service),
        );
      case deliveryInfo:
        return MaterialPageRoute(builder: (_) => const DeliveryInfoView());
      case payment:
        return MaterialPageRoute(builder: (_) => const PaymentMethodView());
      case orderDetails:
        return MaterialPageRoute(builder: (_) => const OrderDetailsView());
      case orderHistory:
        return MaterialPageRoute(builder: (_) => const OrderHistoryView());
      default:
        throw RouterException("Route not found");
    }
  }
}
