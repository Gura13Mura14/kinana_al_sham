import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class UserTypeSelector extends StatefulWidget {
  final Function(String) onChanged;
  final String initialValue;

  const UserTypeSelector({
    super.key,
    required this.onChanged,
    this.initialValue = 'مستفيد',
  });

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  late String selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildOption('مستفيد')),
        const SizedBox(width: 10),
        Expanded(child: _buildOption('متطوع')),
      ],
    );
  }

  Widget _buildOption(String type) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
        });
        widget.onChanged(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.symmetric(
            vertical: BorderSide(color: isSelected ? AppColors.darkBlue : Colors.grey.shade400,
            width: 0.5,),
            
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
