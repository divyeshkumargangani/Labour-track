import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class DashboardKpiRowWidget extends StatelessWidget {
  final double dailyWageDue;
  final double pendingAdvances;

  const DashboardKpiRowWidget({
    required this.dailyWageDue,
    required this.pendingAdvances,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            label: 'Daily Wage Due',
            value: '₹${dailyWageDue.toStringAsFixed(0)}',
            icon: Icons.currency_rupee_rounded,
            color: AppColors.info,
          ),
        ),
        SizedBox(width: 12.sp),
        Expanded(
          child: Stack(
            children: [
              _buildKpiCard(
                label: 'Pending Advances',
                value: '₹${pendingAdvances.toStringAsFixed(0)}',
                icon: Icons.account_balance_wallet_rounded,
                color: AppColors.warning,
              ),
              if (pendingAdvances > 5000)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceAlt,
        border: Border.all(color: AppColors.darkBorder, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(height: 8.sp),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.sp),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
