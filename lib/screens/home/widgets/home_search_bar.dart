import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Buscar fiesta, pueblo o comarca...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: query.isNotEmpty
              ? IconButton(icon: const Icon(Icons.clear), onPressed: onClear)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
