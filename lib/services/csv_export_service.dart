import 'package:csv/csv.dart';
import '../models/hive_models.dart';

class CsvExportService {
  static String generateAttendanceCsv(
    List<WorkerAttendance> attendanceList,
    String projectName,
  ) {
    final List<List<dynamic>> csvData = [];

    // Header
    csvData.add([
      'Project',
      'Worker Name',
      'Role',
      'Date',
      'Status',
      'Overtime Hours',
    ]);

    // Data
    for (var attendance in attendanceList) {
      csvData.add([
        projectName,
        attendance.workerName,
        attendance.role,
        attendance.date.toString().split(' ')[0],
        _getStatusString(attendance.status),
        attendance.overtimeHours,
      ]);
    }

    return const ListToCsvConverter().convert(csvData);
  }

  static String generatePayrollCsv(
    List<WorkerModel> workers,
    List<WorkerAttendance> attendanceList,
    String projectName,
  ) {
    final List<List<dynamic>> csvData = [];

    // Header
    csvData.add([
      'Project',
      'Worker Name',
      'Role',
      'Days Worked (Full)',
      'Half Days',
      'Overtime Hours',
      'Daily Wage',
      'Total Wage',
      'Overtime Wage',
      'Total with OT',
      'Cash Advance',
      'Net Due',
    ]);

    // Data
    for (var worker in workers) {
      final workerAttendance =
          attendanceList.where((a) => a.workerId == worker.id).toList();
      final presentDays =
          workerAttendance.where((a) => a.status == AttendanceStatus.present).length;
      final halfDays =
          workerAttendance.where((a) => a.status == AttendanceStatus.halfDay).length;
      final overtimeHours = workerAttendance.fold<double>(
          0.0, (sum, a) => sum + a.overtimeHours);

      final totalWage = (presentDays + (halfDays * 0.5)) * worker.dailyWage;
      final overtimeWage = (overtimeHours * (worker.dailyWage / 8));
      final totalInclOT = totalWage + overtimeWage;
      final netDue = totalInclOT - worker.totalAdvance;

      csvData.add([
        projectName,
        worker.name,
        worker.role,
        presentDays,
        halfDays,
        overtimeHours.toStringAsFixed(1),
        worker.dailyWage,
        totalWage.toStringAsFixed(0),
        overtimeWage.toStringAsFixed(0),
        totalInclOT.toStringAsFixed(0),
        worker.totalAdvance.toStringAsFixed(0),
        netDue.toStringAsFixed(0),
      ]);
    }

    return const ListToCsvConverter().convert(csvData);
  }

  static String _getStatusString(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.halfDay:
        return 'Half Day';
      case AttendanceStatus.overtime:
        return 'Overtime';
      case AttendanceStatus.unmarked:
        return 'Unmarked';
    }
  }
}
