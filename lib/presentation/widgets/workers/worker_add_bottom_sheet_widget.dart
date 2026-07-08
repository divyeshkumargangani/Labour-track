import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../models/hive_models.dart';
import '../../theme/app_theme.dart';

class WorkerAddBottomSheetWidget extends StatefulWidget {
  final String projectId;
  final Function(WorkerModel) onWorkerAdded;

  const WorkerAddBottomSheetWidget({
    required this.projectId,
    required this.onWorkerAdded,
    Key? key,
  }) : super(key: key);

  @override
  State<WorkerAddBottomSheetWidget> createState() => _WorkerAddBottomSheetWidgetState();
}

class _WorkerAddBottomSheetWidgetState extends State<WorkerAddBottomSheetWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _wageController = TextEditingController();
  String _selectedRole = 'Mason';
  bool _isHourly = false;

  final List<String> roles = ['Mason', 'Laborer', 'Painter', 'Electrician', 'Carpenter', 'Plumber'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _wageController.dispose();
    super.dispose();
  }

  void _addWorker() {
    if (_nameController.text.isEmpty || _wageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newWorker = WorkerModel(
      id: const Uuid().v4(),
      projectId: widget.projectId,
      name: _nameController.text,
      phone: _phoneController.text,
      role: _selectedRole,
      dailyWage: double.parse(_wageController.text),
      isHourly: _isHourly,
      avatarInitials: _getInitials(_nameController.text),
      daysWorkedThisMonth: 0,
      totalAdvance: 0.0,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    widget.onWorkerAdded(newWorker);
    Navigator.pop(context);
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Worker',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.sp),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Worker Name',
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            SizedBox(height: 12.sp),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 12.sp),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                hintText: 'Select Role',
                prefixIcon: const Icon(Icons.work),
              ),
              items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
              onChanged: (value) => setState(() => _selectedRole = value ?? 'Mason'),
            ),
            SizedBox(height: 12.sp),
            TextField(
              controller: _wageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Daily Wage (₹)',
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
            SizedBox(height: 12.sp),
            CheckboxListTile(
              value: _isHourly,
              onChanged: (value) => setState(() => _isHourly = value ?? false),
              title: const Text('Hourly Rate', style: TextStyle(color: AppColors.textPrimary)),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 16.sp),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addWorker,
                child: const Text('Add Worker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
