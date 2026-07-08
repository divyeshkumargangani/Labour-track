import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class WorkerFilterChipsWidget extends StatelessWidget {
  final List<String> roles;
  final String selectedRole;
  final Function(String) onRoleSelected;

  const WorkerFilterChipsWidget({
    required this.roles,
    required this.selectedRole,
    required this.onRoleSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Row(
        children: roles.map((role) {
          final isSelected = role == selectedRole;
          return Padding(
            padding: EdgeInsets.only(right: 8.sp),
            child: FilterChip(
              label: Text(role),
              selected: isSelected,
              backgroundColor: AppColors.darkSurfaceAlt,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              onSelected: (_) => onRoleSelected(role),
            ),
          );
        }).toList(),
      ),
    );
  }
}
