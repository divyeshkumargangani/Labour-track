import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../theme/app_theme.dart';

class DashboardAttendanceChartWidget extends StatelessWidget {
  const DashboardAttendanceChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceAlt,
        border: Border.all(color: AppColors.darkBorder, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7-Day Attendance Trend',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.sp),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: [
                  _buildBarGroup(0, 18, 4),
                  _buildBarGroup(1, 19, 3),
                  _buildBarGroup(2, 17, 5),
                  _buildBarGroup(3, 20, 2),
                  _buildBarGroup(4, 19, 3),
                  _buildBarGroup(5, 18, 4),
                  _buildBarGroup(6, 19, 3),
                ],
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.darkBorder.withOpacity(0.3),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text(
                        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value.toInt()],
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double presentValue, double absentValue) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: presentValue,
          color: AppColors.secondary,
          width: 6.sp,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: absentValue,
          color: AppColors.error,
          width: 6.sp,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
      groupVertically: false,
    );
  }
}
