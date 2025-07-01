import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static OverlayEntry? _overlayEntry;

  static void show() {
    if (_overlayEntry != null) return; // Prevent multiple overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: Center(
          child: LoadingAnimationWidget.beat(color: kSecondaryColor, size: 80),
        ),
      ),
    );

    navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
