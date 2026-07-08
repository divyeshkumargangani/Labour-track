import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface.withOpacity(0.8),
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Settings & Preferences (Coming Soon)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
