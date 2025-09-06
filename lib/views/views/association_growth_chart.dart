import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/StatisticsController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class StatisticsChartView extends StatelessWidget {
  final _controller = Get.put(StatisticsController());

  StatisticsChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (_controller.errorMessage.isNotEmpty) {
        return Center(child: Text(_controller.errorMessage.value));
      }
      if (_controller.statistics.isEmpty) {
        return const Center(child: Text("لا توجد بيانات حالياً"));
      }

      final stats = _controller.statistics;
      final spots = <FlSpot>[];
      for (int i = 0; i < stats.length; i++) {
        final value = double.tryParse(stats[i].value) ?? 0.0;
        spots.add(FlSpot(i.toDouble(), value));
      }

      return SizedBox(
        height: r.hp(35), // ارتفاع الرسم يتناسب مع الشاشة
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: r.hp(12), // مساحة أكبر تحت العناوين
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= stats.length) {
                      return const SizedBox.shrink();
                    }
                    return Transform.rotate(
                      angle: -0.8, // ميلان أكبر (حوالي 55°)
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: r.hp(1.7),
                        ), 
                        child: Text(
                          stats[index].title,
                          style: TextStyle(
                            fontSize: r.sp(8.5),
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: r.wp(8),
                  interval:
                      (spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) /
                              5)
                          .ceilToDouble(), // تقسيم ذكي
                  getTitlesWidget:
                      (val, meta) => Text(
                        val.toInt().toString(),
                        style: TextStyle(
                          fontSize: r.sp(9),
                          color: Colors.grey[700],
                        ),
                      ),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine:
                  (value) => FlLine(color: Colors.grey[300], strokeWidth: 1),
              getDrawingVerticalLine:
                  (value) => FlLine(color: Colors.grey[300], strokeWidth: 1),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.black26),
                left: BorderSide(color: Colors.black26),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: spots,
                color: AppColors.pinkBeige,
                barWidth: 3,
                dotData: FlDotData(show: true),
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
