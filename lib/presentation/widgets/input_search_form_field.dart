import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class SearchInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onSearchTap;

  const SearchInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search, color: Colors.brown),
        suffixIcon: GestureDetector(
          onTap: onSearchTap,
          child: const Icon(Icons.arrow_forward, color: Colors.brown),
        ),
        filled: true,
        fillColor: kBackgroundColorFront,
        hintStyle: TextStyle(color: Colors.brown),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
