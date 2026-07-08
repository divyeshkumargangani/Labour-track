import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/hive_models.dart';
import '../../theme/app_theme.dart';

class WorkerCardWidget extends StatelessWidget {
  final WorkerModel worker;
  final VoidCallback onDelete;

  const WorkerCardWidget({
    required this.worker,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

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
            radius: 20.sp,
            backgroundColor: AppColors.primary.withOpacity(0.2),
            child: Text(
              worker.avatarInitials,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
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
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.sp),
                Row(
                  children: [
                    Icon(Icons.currency_rupee, size: 12.sp, color: AppColors.textTertiary),
                    Text(
                      '${worker.dailyWage.toStringAsFixed(0)}/day',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 2.sp),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Adv: ₹${worker.totalAdvance.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: AppColors.warning,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.darkSurface,
                builder: (context) => Container(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit, color: AppColors.primary),
                        title: const Text('Edit Worker', style: TextStyle(color: AppColors.textPrimary)),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete, color: AppColors.error),
                        title: const Text('Delete Worker', style: TextStyle(color: AppColors.error)),
                        onTap: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
