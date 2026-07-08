import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../config/mock_data.dart';
import '../../models/hive_models.dart';
import '../../theme/app_theme.dart';
import '../widgets/attendance/attendance_date_strip_widget.dart';
import '../widgets/attendance/attendance_summary_banner_widget.dart';
import '../widgets/attendance/attendance_worker_row_widget.dart';

class QuickAttendanceScreen extends StatefulWidget {
  const QuickAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<QuickAttendanceScreen> createState() => _QuickAttendanceScreenState();
}

class _QuickAttendanceScreenState extends State<QuickAttendanceScreen> {
  late DateTime _selectedDate;
  late Map<String, AttendanceStatus> _attendanceStatus;
  late Map<String, double> _overtimeHours;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _attendanceStatus = {};
    _overtimeHours = {};
    
    _attendanceStatus['${mockWorkers[0].id}'] = AttendanceStatus.present;
    _attendanceStatus['${mockWorkers[1].id}'] = AttendanceStatus.absent;
    _attendanceStatus['${mockWorkers[2].id}'] = AttendanceStatus.halfDay;
    _attendanceStatus['${mockWorkers[3].id}'] = AttendanceStatus.present;
    _attendanceStatus['${mockWorkers[4].id}'] = AttendanceStatus.overtime;
    _overtimeHours['${mockWorkers[4].id}'] = 3.0;
    
    for (int i = 5; i < mockWorkers.length; i++) {
      _attendanceStatus['${mockWorkers[i].id}'] = AttendanceStatus.unmarked;
    }
  }

  void _updateAttendanceStatus(String workerId, AttendanceStatus status) {
    HapticFeedback.mediumImpact();
    setState(() {
      _attendanceStatus[workerId] = status;
      if (status != AttendanceStatus.overtime) {
        _overtimeHours[workerId] = 0.0;
      }
    });
  }

  void _markAllPresent() {
    HapticFeedback.heavyImpact();
    setState(() {
      for (var worker in mockWorkers) {
        _attendanceStatus['${worker.id}'] = AttendanceStatus.present;
        _overtimeHours['${worker.id}'] = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final markedCount = _attendanceStatus.values
        .where((status) => status != AttendanceStatus.unmarked)
        .length;
    final totalCount = mockWorkers.length;
    final isAllMarked = markedCount == totalCount;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface.withOpacity(0.8),
        title: const Text('Quick Attendance'),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(12.sp),
        children: [
          AttendanceDateStripWidget(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() => _selectedDate = date);
            },
          ),
          SizedBox(height: 16.sp),
          AttendanceSummaryBannerWidget(
            markedCount: markedCount,
            totalCount: totalCount,
            isAllMarked: isAllMarked,
          ),
          SizedBox(height: 16.sp),
          ...mockWorkers.map((worker) {
            final status = _attendanceStatus['${worker.id}'] ?? AttendanceStatus.unmarked;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.sp),
              child: AttendanceWorkerRowWidget(
                worker: worker,
                status: status,
                overtimeHours: _overtimeHours['${worker.id}'] ?? 0.0,
                onStatusChanged: (newStatus) {
                  _updateAttendanceStatus(worker.id, newStatus);
                },
                onOvertimeChanged: (hours) {
                  setState(() {
                    _overtimeHours['${worker.id}'] = hours;
                  });
                },
              ),
            );
          }).toList(),
          SizedBox(height: 80.sp),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _markAllPresent,
        backgroundColor: AppColors.secondary,
        label: const Text('Mark All Present'),
        icon: const Icon(Icons.check_circle_rounded),
      ),
    );
  }
}
