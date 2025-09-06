import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class TopBarChart extends StatelessWidget {
  final List<String> names;
  final List<int> ids;
  final List<double> hours;
  final Map<String, dynamic>? volunteerOfWeek;
  final Map<String, dynamic>? volunteerOfMonth; // 🆕 متطوع الشهر

  TopBarChart({
    super.key,
    required this.names,
    required this.ids,
    required this.hours,
    this.volunteerOfWeek,
    this.volunteerOfMonth,
  });

  final List<IconData> cupIcons = [
    Icons.emoji_events_outlined, // الثاني
    Icons.emoji_events, // الأول
    Icons.military_tech, // الثالث
  ];

  final List<List<Color>> gradientColors = [
    [Color.fromARGB(255, 35, 177, 205), AppColors.bluishGray], // برونزي
    [Color.fromARGB(255, 223, 196, 42), AppColors.bluishGray], // ذهبي
    [Color.fromARGB(255, 223, 93, 93), AppColors.bluishGray], // فضي
  ];

  @override
  Widget build(BuildContext context) {
    // ترتيب الأعمدة: ثالث – أول – ثاني
    List<int> order = [2, 0, 1];

    return SizedBox(
      height: 320,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 110, // 🟢 وسّع المساحة لتفادي overflow
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index > 2) return const SizedBox();

                      final actualIndex = order[index];
                      final actualName = names[actualIndex];
                      final actualId = ids[actualIndex];

                      final isVolunteerOfWeek =
                          volunteerOfWeek != null &&
                          volunteerOfWeek!['user_id'].toString() ==
                              actualId.toString();

                      final isVolunteerOfMonth =
                          volunteerOfMonth != null &&
                          volunteerOfMonth!['user_id'].toString() ==
                              actualId.toString();

                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                          width: 90,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 👤 الاسم
                              Text(
                                actualName,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              const SizedBox(height: 2),

                              // ⏱️ عدد الساعات
                              Text(
                                '${hours[actualIndex]} ساعة',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.bluishGray,
                                ),
                              ),

                              // ⭐ متطوع الأسبوع
                              if (isVolunteerOfWeek)
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                ),

                              // 📅 متطوع الشهر
                              if (isVolunteerOfMonth)
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              maxY: (hours.reduce((a, b) => a > b ? a : b)) + 12,
              barGroups: List.generate(3, (i) {
                final actualIndex = order[i];
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: hours[actualIndex],
                      width: 36,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: gradientColors[i],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                );
              }),
            ),
          ),

          // 🏆 الكؤوس فوق الأعمدة
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(3, (i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 1),
                    Icon(cupIcons[i], size: 30, color: gradientColors[i].first),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
