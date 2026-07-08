import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class AttendanceSummaryBannerWidget extends StatelessWidget {
  final int markedCount;
  final int totalCount;
  final bool isAllMarked;

  const AttendanceSummaryBannerWidget({
    required this.markedCount,
    required this.totalCount,
    required this.isAllMarked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = totalCount > 0 ? (markedCount / totalCount) : 0.0;

    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mark Progress',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                decoration: BoxDecoration(
                  color: isAllMarked ? AppColors.secondary : AppColors.warning,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$markedCount/$totalCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.sp,
              backgroundColor: AppColors.darkBorder,
              valueColor: AlwaysStoppedAnimation(
                isAllMarked ? AppColors.secondary : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
