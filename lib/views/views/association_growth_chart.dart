import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class AssociationGrowthChart extends StatelessWidget {
  const AssociationGrowthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تطور أعمال الجمعية',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF293C48), // Dark Blue
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text('السنة'),
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final year = 2020 + value.toInt();
                        return Text(
                          '$year',
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                        );
                      },
                      reservedSize: 32,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text('الإنجاز (%)'),
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      reservedSize: 40,
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey[300],
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey[300],
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: Colors.black12),
                    left: BorderSide(color: Colors.black12),
                  ),
                ),
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: AppColors.pinkBeige, // Light Brown
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.pinkBeige,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.pinkBeige.withOpacity(0.3),
                          AppColors.pinkBeige.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    spots: const [
                      FlSpot(0, 40), // 2020
                      FlSpot(1, 100), // 2021
                      FlSpot(2, 30), // 2022
                      FlSpot(3, 50), // 2023
                      FlSpot(4, 60), // 2024
                       FlSpot(5, 30), // 2022
                      FlSpot(6, 50), // 2023
                      FlSpot(7, 60), // 2024
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
