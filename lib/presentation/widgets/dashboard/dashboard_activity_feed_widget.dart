import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../config/mock_data.dart';
import '../../theme/app_theme.dart';

class DashboardActivityFeedWidget extends StatelessWidget {
  const DashboardActivityFeedWidget({Key? key}) : super(key: key);

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
            'Recent Activity',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.sp),
          ...mockActivityItems.map((item) {
            final timeAgo = _formatTimeAgo(item.timestamp);
            return Padding(
              padding: EdgeInsets.only(bottom: 10.sp),
              child: Row(
                children: [
                  Container(
                    width: 32.sp,
                    height: 32.sp,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xff${item.color.replaceFirst('#', '')}')).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _mapIconName(item.iconName),
                      color: Color(int.parse('0xff${item.color.replaceFirst('#', '')}')),
                      size: 14.sp,
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.workerName,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          item.action,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  IconData _mapIconName(String iconName) {
    switch (iconName) {
      case 'check_circle':
        return Icons.check_circle_rounded;
      case 'close_circle':
        return Icons.close_circle_rounded;
      case 'schedule':
        return Icons.schedule_rounded;
      case 'timer':
        return Icons.timer_rounded;
      case 'currency_rupee':
        return Icons.currency_rupee_rounded;
      default:
        return Icons.info_rounded;
    }
  }
}
