import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class TopBarChart extends StatelessWidget {
  final List<String> names;
  final List<double> hours;

  TopBarChart({required this.names, required this.hours});

  final List<IconData> cupIcons = [
     
    Icons.emoji_events_outlined, // الثاني
    Icons.emoji_events, // الأول
     Icons.military_tech,
  ];

  final List<List<Color>> gradientColors = [
    [Color(0xFFCD7F32), AppColors.bluishGray], 
    [Color(0xFFFFD700), AppColors.bluishGray],
    [Color(0xFFC0C0C0), AppColors.bluishGray], 
   
  ];

  final List<String> orderedNames = [];
  final List<double> orderedHours = [];

  @override
  Widget build(BuildContext context) {
    // ترتيب الأعمدة: ثالث – أول – ثاني
    List<int> order = [2, 0, 1];

    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BarChart(
            BarChartData(
              gridData: FlGridData(show: false), // إلغاء الشبكة
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          names[order[index]],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              maxY: (hours.reduce((a, b) => a > b ? a : b)) + 8,
              barGroups: List.generate(3, (i) {
                final actualIndex = order[i];
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: hours[actualIndex],
                      width: 32,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: gradientColors[i],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      rodStackItems: [],
                    ),
                  ],
                );
              }),
            ),
          ),
          // الكؤوس والساعات
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(3, (i) {
                final actualIndex = order[i];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cupIcons[i],
                      size: 32,
                      color: gradientColors[i].first,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${hours[actualIndex]} ساعة',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.bluishGray,
                      ),
                    ),
                    const SizedBox(height: 4),
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
