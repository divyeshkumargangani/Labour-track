import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../config/translations.dart';
import '../models/hive_models.dart';

class PdfExportService {
  static Future<void> exportAttendanceReport(
    List<WorkerAttendance> attendanceList,
    String projectName,
    String language,
  ) async {
    final pdf = pw.Document();

    // Group by worker
    final Map<String, List<WorkerAttendance>> groupedByWorker = {};
    for (var attendance in attendanceList) {
      groupedByWorker.putIfAbsent(attendance.workerName, () => []).add(attendance);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  t('attendance_report', language: language),
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  '$projectName • ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Summary Statistics
          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _buildStatBox(
                  t('present', language: language),
                  attendanceList.where((a) => a.status == AttendanceStatus.present).length.toString(),
                ),
                _buildStatBox(
                  t('absent', language: language),
                  attendanceList.where((a) => a.status == AttendanceStatus.absent).length.toString(),
                ),
                _buildStatBox(
                  t('half_day', language: language),
                  attendanceList.where((a) => a.status == AttendanceStatus.halfDay).length.toString(),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Table
          pw.TableHelper.fromTextArray(
            headers: [
              t('worker', language: language),
              t('role', language: language),
              t('present', language: language),
              t('absent', language: language),
              t('half_day', language: language),
            ],
            data: groupedByWorker.entries.map((entry) {
              final workerName = entry.key;
              final records = entry.value;
              final presentCount = records.where((r) => r.status == AttendanceStatus.present).length;
              final absentCount = records.where((r) => r.status == AttendanceStatus.absent).length;
              final halfDayCount = records.where((r) => r.status == AttendanceStatus.halfDay).length;
              final role = records.first.role;

              return [workerName, role, presentCount.toString(), absentCount.toString(), halfDayCount.toString()];
            }).toList(),
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.center,
            rowDecoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static Future<void> exportPayrollReport(
    List<WorkerModel> workers,
    List<WorkerAttendance> attendanceList,
    String projectName,
    String language,
  ) async {
    final pdf = pw.Document();

    // Calculate payroll data
    final payrollData = <String, Map<String, dynamic>>{};
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

      payrollData[worker.id] = {
        'name': worker.name,
        'role': worker.role,
        'presentDays': presentDays,
        'halfDays': halfDays,
        'overtimeHours': overtimeHours,
        'totalWage': totalWage,
        'overtimeWage': overtimeWage,
        'totalInclOT': totalInclOT,
        'advance': worker.totalAdvance,
        'netDue': netDue,
      };
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  t('payroll', language: language),
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  '$projectName • ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Payroll Table
          pw.TableHelper.fromTextArray(
            headers: [
              t('worker', language: language),
              t('role', language: language),
              t('days_worked', language: language),
              'OT (hrs)',
              t('total_wage', language: language),
              'OT Wage',
              'Total',
              t('total_advance', language: language),
              t('net_due', language: language),
            ],
            data: payrollData.entries.map((entry) {
              final data = entry.value;
              return [
                data['name'],
                data['role'],
                '${data['presentDays']} + ${data['halfDays']}',
                data['overtimeHours'].toStringAsFixed(1),
                '₹${data['totalWage'].toStringAsFixed(0)}',
                '₹${data['overtimeWage'].toStringAsFixed(0)}',
                '₹${data['totalInclOT'].toStringAsFixed(0)}',
                '₹${data['advance'].toStringAsFixed(0)}',
                '₹${data['netDue'].toStringAsFixed(0)}',
              ];
            }).toList(),
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellAlignment: pw.Alignment.center,
            cellPadding: const pw.EdgeInsets.all(8),
            rowDecoration: pw.BoxDecoration(border: pw.Border.all()),
          ),

          // Total Summary
          pw.SizedBox(height: 20),
          pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Total Net Due: ₹${payrollData.values.fold<double>(0, (sum, data) => sum + data['netDue']).toStringAsFixed(0)}',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static pw.Widget _buildStatBox(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
      ],
    );
  }
}
