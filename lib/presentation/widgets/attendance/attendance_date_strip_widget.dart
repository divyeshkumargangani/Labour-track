import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class AttendanceDateStripWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const AttendanceDateStripWidget({
    required this.selectedDate,
    required this.onDateSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceDateStripWidget> createState() => _AttendanceDateStripWidgetState();
}

class _AttendanceDateStripWidgetState extends State<AttendanceDateStripWidget> {
  late List<DateTime> _dateList;

  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  void _generateDateList() {
    _dateList = [];
    for (int i = -7; i <= 7; i++) {
      _dateList.add(DateTime.now().add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dateList.length,
        itemBuilder: (context, index) {
          final date = _dateList[index];
          final isSelected = date.year == widget.selectedDate.year &&
              date.month == widget.selectedDate.month &&
              date.day == widget.selectedDate.day;
          final isToday = date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.sp),
            child: GestureDetector(
              onTap: () => widget.onDateSelected(date),
              child: Container(
                width: 60.sp,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.darkSurfaceAlt,
                  border: isSelected ? null : Border.all(color: AppColors.darkBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday % 7],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isToday)
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(top: 4.sp),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
