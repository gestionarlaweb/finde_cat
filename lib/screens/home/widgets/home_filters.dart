import 'package:flutter/material.dart';

class HomeFilters extends StatelessWidget {
  final int filtroTemporal;
  final Function(int) onFilterSelected;

  const HomeFilters({
    super.key,
    required this.filtroTemporal,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip(0, "Todos"),
          const SizedBox(width: 8),
          _buildChip(1, "Próximos 15 días"),
          const SizedBox(width: 8),
          _buildChip(2, "Próximo mes"),
        ],
      ),
    );
  }

  Widget _buildChip(int index, String label) {
    return ChoiceChip(
      label: Text(label),
      labelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
        return TextStyle(
          color: Colors.black,
          fontWeight: filtroTemporal == index
              ? FontWeight.bold
              : FontWeight.normal,
        );
      }),
      selected: filtroTemporal == index,
      onSelected: (selected) => onFilterSelected(index),
      selectedColor: Colors.deepOrange.withOpacity(0.4),
      backgroundColor: Colors.grey[200],
      showCheckmark: false,
    );
  }
}
