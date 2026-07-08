import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/mock_data.dart';
import '../../theme/app_theme.dart';
import '../widgets/dashboard/dashboard_project_header_widget.dart';
import '../widgets/dashboard/dashboard_summary_card_widget.dart';
import '../widgets/dashboard/dashboard_kpi_row_widget.dart';
import '../widgets/dashboard/dashboard_attendance_chart_widget.dart';
import '../widgets/dashboard/dashboard_activity_feed_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _selectedProjectIndex;
  late dynamic _selectedProject;

  @override
  void initState() {
    super.initState();
    _selectedProjectIndex = 0;
    _selectedProject = mockProjects[0];
  }

  void _onProjectChanged(int index) {
    setState(() {
      _selectedProjectIndex = index;
      _selectedProject = mockProjects[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final workers = mockWorkers.where((w) => w.projectId == _selectedProject.id).toList();

    final presentCount = 19;
    final absentCount = 3;
    final halfDayCount = 2;
    final dailyWageDue = 28750.0;
    final pendingAdvances = 6500.0;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            pinned: true,
            backgroundColor: AppColors.darkSurface.withOpacity(0.8),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      DateTime.now().toString().split(' ')[0],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_rounded),
                          color: AppColors.textPrimary,
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 16.sp,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'CS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DashboardProjectHeaderWidget(
                  project: _selectedProject,
                  onSwitch: () => _showProjectPicker(context),
                ),
                SizedBox(height: 16.sp),
                DashboardSummaryCardWidget(
                  presentCount: presentCount,
                  absentCount: absentCount,
                  halfDayCount: halfDayCount,
                  totalWorkers: workers.length,
                ),
                SizedBox(height: 16.sp),
                DashboardKpiRowWidget(
                  dailyWageDue: dailyWageDue,
                  pendingAdvances: pendingAdvances,
                ),
                SizedBox(height: 16.sp),
                const DashboardAttendanceChartWidget(),
                SizedBox(height: 16.sp),
                const DashboardActivityFeedWidget(),
                SizedBox(height: 20.sp),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showProjectPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Project',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.sp),
            ...mockProjects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;
              return ListTile(
                title: Text(project.name, style: const TextStyle(color: AppColors.textPrimary)),
                subtitle: Text(project.location, style: const TextStyle(color: AppColors.textSecondary)),
                trailing: _selectedProjectIndex == index ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  _onProjectChanged(index);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
