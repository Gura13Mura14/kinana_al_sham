import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

enum SortOption { nameAZ, nameZA, dateNewest, dateOldest }

class SearchAndFilterWidget extends StatefulWidget {
  final void Function(String searchText, SortOption? sortOption)
  onFilterChanged;

  const SearchAndFilterWidget({super.key, required this.onFilterChanged});

  @override
  State<SearchAndFilterWidget> createState() => _SearchAndFilterWidgetState();
}

class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
  String searchText = '';
  SortOption? selectedSort;

  void _openFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.grayWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "رتّب حسب",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...SortOption.values.map((option) {
                    String text;
                    switch (option) {
                      case SortOption.nameAZ:
                        text = 'الاسم A → Z';
                        break;
                      case SortOption.nameZA:
                        text = 'الاسم Z → A';
                        break;
                      case SortOption.dateNewest:
                        text = 'الأحدث أولًا';
                        break;
                      case SortOption.dateOldest:
                        text = 'الأقدم أولًا';
                        break;
                    }
                    return RadioListTile<SortOption>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      activeColor: AppColors.pinkBeige,
                      value: option,
                      groupValue: selectedSort,
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value;
                          widget.onFilterChanged(searchText, selectedSort);
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // زر الفلترة
            IconButton(
              icon: const Icon(Icons.filter_list, color: AppColors.darkBlue),
              onPressed: _openFilterDialog,
              tooltip: 'فلترة',
            ),
            const SizedBox(width: 8),
            // مربع البحث
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                    widget.onFilterChanged(searchText, selectedSort);
                  });
                },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'بحث ...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.bluishGray,
                  ),
                  filled: true,
                  fillColor: AppColors.grayWhite,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.bluishGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.pinkBeige,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
