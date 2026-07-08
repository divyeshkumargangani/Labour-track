import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../config/mock_data.dart';
import '../../models/hive_models.dart';
import '../../theme/app_theme.dart';
import '../widgets/workers/worker_filter_chips_widget.dart';
import '../widgets/workers/worker_card_widget.dart';
import '../widgets/workers/worker_add_bottom_sheet_widget.dart';

class WorkerListScreen extends StatefulWidget {
  const WorkerListScreen({Key? key}) : super(key: key);

  @override
  State<WorkerListScreen> createState() => _WorkerListScreenState();
}

class _WorkerListScreenState extends State<WorkerListScreen> {
  late List<WorkerModel> _workers;
  late List<WorkerModel> _filteredWorkers;
  String _searchQuery = '';
  String _selectedRole = 'All';

  static const List<String> roles = [
    'All',
    'Mason',
    'Laborer',
    'Painter',
    'Electrician',
    'Carpenter',
    'Plumber',
  ];

  @override
  void initState() {
    super.initState();
    _workers = List.from(mockWorkers);
    _applyFilters();
  }

  void _applyFilters() {
    _filteredWorkers = _workers.where((worker) {
      final matchesSearch = _searchQuery.isEmpty ||
          worker.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          worker.phone.contains(_searchQuery) ||
          worker.role.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesRole = _selectedRole == 'All' || worker.role == _selectedRole;

      return matchesSearch && matchesRole && worker.isActive;
    }).toList();
  }

  void _addWorker(WorkerModel newWorker) {
    setState(() {
      _workers.add(newWorker);
      _applyFilters();
    });
  }

  void _deleteWorker(WorkerModel worker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: const Text('Delete Worker?', style: TextStyle(color: AppColors.textPrimary)),
        content: Text('Remove ${worker.name}?', style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workers.removeWhere((w) => w.id == worker.id);
                _applyFilters();
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface.withOpacity(0.8),
        title: const Text('Workers'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _applyFilters();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, phone, role...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.darkSurfaceAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.darkBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          WorkerFilterChipsWidget(
            roles: roles,
            selectedRole: _selectedRole,
            onRoleSelected: (role) {
              setState(() {
                _selectedRole = role;
                _applyFilters();
              });
            },
          ),
          Expanded(
            child: _filteredWorkers.isEmpty
                ? Center(
                    child: Text(
                      'No workers found',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                    itemCount: _filteredWorkers.length,
                    itemBuilder: (context, index) {
                      final worker = _filteredWorkers[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.sp),
                        child: Dismissible(
                          key: Key(worker.id),
                          background: Container(
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 16.sp),
                            child: const Icon(Icons.delete_rounded, color: AppColors.error),
                          ),
                          onDismissed: (direction) => _deleteWorker(worker),
                          child: WorkerCardWidget(
                            worker: worker,
                            onDelete: () => _deleteWorker(worker),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showAddWorkerSheet(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showAddWorkerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      builder: (context) => WorkerAddBottomSheetWidget(
        projectId: mockProjects[0].id,
        onWorkerAdded: _addWorker,
      ),
    );
  }
}
