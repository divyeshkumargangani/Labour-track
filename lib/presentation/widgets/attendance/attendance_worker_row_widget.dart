import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/hive_models.dart';
import '../../theme/app_theme.dart';

class AttendanceWorkerRowWidget extends StatelessWidget {
  final WorkerModel worker;
  final AttendanceStatus status;
  final double overtimeHours;
  final Function(AttendanceStatus) onStatusChanged;
  final Function(double) onOvertimeChanged;

  const AttendanceWorkerRowWidget({
    required this.worker,
    required this.status,
    required this.overtimeHours,
    required this.onStatusChanged,
    required this.onOvertimeChanged,
    Key? key,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case AttendanceStatus.present:
        return AppColors.secondary;
      case AttendanceStatus.absent:
        return AppColors.error;
      case AttendanceStatus.halfDay:
        return AppColors.warning;
      case AttendanceStatus.overtime:
        return AppColors.info;
      default:
        return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceAlt,
        border: Border.all(color: AppColors.darkBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.sp,
            backgroundColor: _getStatusColor().withOpacity(0.2),
            child: Text(
              worker.avatarInitials,
              style: TextStyle(
                color: _getStatusColor(),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  worker.role,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<AttendanceStatus>(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: AttendanceStatus.present,
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.secondary, size: 16.sp),
                    SizedBox(width: 8.sp),
                    const Text('Present'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AttendanceStatus.absent,
                child: Row(
                  children: [
                    Icon(Icons.cancel, color: AppColors.error, size: 16.sp),
                    SizedBox(width: 8.sp),
                    const Text('Absent'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AttendanceStatus.halfDay,
                child: Row(
                  children: [
                    Icon(Icons.schedule, color: AppColors.warning, size: 16.sp),
                    SizedBox(width: 8.sp),
                    const Text('Half-Day'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AttendanceStatus.overtime,
                child: Row(
                  children: [
                    Icon(Icons.timer, color: AppColors.info, size: 16.sp),
                    SizedBox(width: 8.sp),
                    const Text('OT'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AttendanceStatus.unmarked,
                child: Row(
                  children: [
                    Icon(Icons.radio_button_unchecked, color: AppColors.textTertiary, size: 16.sp),
                    SizedBox(width: 8.sp),
                    const Text('Unmarked'),
                  ],
                ),
              ),
            ],
            onSelected: onStatusChanged,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 6.sp),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                border: Border.all(color: _getStatusColor().withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getStatusLabel(),
                style: TextStyle(
                  color: _getStatusColor(),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel() {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.halfDay:
        return 'Half';
      case AttendanceStatus.overtime:
        return 'OT';
      default:
        return 'Mark';
    }
  }
}
