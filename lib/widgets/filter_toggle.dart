import 'package:flutter/material.dart';

class FilterToggle extends StatelessWidget {
  final bool showOnlyPending;
  final void Function(bool) onToggle;

  const FilterToggle({
    super.key,
    required this.showOnlyPending,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [!showOnlyPending, showOnlyPending],
      onPressed: (index) {
        onToggle(index == 1);
      },
      borderRadius: BorderRadius.circular(12),
      selectedColor: Colors.white,
      fillColor: Colors.blueGrey,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('كل الطلبات'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('قيد المراجعة'),
        ),
      ],
    );
  }
}
