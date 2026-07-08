import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'hive_models.g.dart';

// ============ Attendance Status Enum ============
@HiveType(typeId: 0)
enum AttendanceStatus {
  @HiveField(0)
  unmarked,
  @HiveField(1)
  present,
  @HiveField(2)
  absent,
  @HiveField(3)
  halfDay,
  @HiveField(4)
  overtime,
}

// ============ Project Model ============
@HiveType(typeId: 1)
class ProjectModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String location;
  
  @HiveField(3)
  final int workerCount;
  
  @HiveField(4)
  final bool isActive;
  
  @HiveField(5)
  final DateTime createdAt;
  
  @HiveField(6)
  final DateTime updatedAt;

  ProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.workerCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  ProjectModel copyWith({
    String? id,
    String? name,
    String? location,
    int? workerCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      workerCount: workerCount ?? this.workerCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, location, workerCount, isActive, createdAt, updatedAt];
}

// ============ Worker Model ============
@HiveType(typeId: 2)
class WorkerModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String projectId;
  
  @HiveField(2)
  final String name;
  
  @HiveField(3)
  final String phone;
  
  @HiveField(4)
  final String role;
  
  @HiveField(5)
  final double dailyWage;
  
  @HiveField(6)
  final bool isHourly;
  
  @HiveField(7)
  final String avatarInitials;
  
  @HiveField(8)
  final int daysWorkedThisMonth;
  
  @HiveField(9)
  final double totalAdvance;
  
  @HiveField(10)
  final bool isActive;
  
  @HiveField(11)
  final DateTime createdAt;
  
  @HiveField(12)
  final DateTime updatedAt;

  WorkerModel({
    required this.id,
    required this.projectId,
    required this.name,
    required this.phone,
    required this.role,
    required this.dailyWage,
    required this.isHourly,
    required this.avatarInitials,
    required this.daysWorkedThisMonth,
    required this.totalAdvance,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  WorkerModel copyWith({
    String? id,
    String? projectId,
    String? name,
    String? phone,
    String? role,
    double? dailyWage,
    bool? isHourly,
    String? avatarInitials,
    int? daysWorkedThisMonth,
    double? totalAdvance,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      dailyWage: dailyWage ?? this.dailyWage,
      isHourly: isHourly ?? this.isHourly,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      daysWorkedThisMonth: daysWorkedThisMonth ?? this.daysWorkedThisMonth,
      totalAdvance: totalAdvance ?? this.totalAdvance,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, projectId, name, phone, role, dailyWage, isHourly,
    avatarInitials, daysWorkedThisMonth, totalAdvance, isActive, createdAt, updatedAt
  ];
}

// ============ Worker Attendance Model ============
@HiveType(typeId: 3)
class WorkerAttendance extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String workerId;
  
  @HiveField(2)
  final String projectId;
  
  @HiveField(3)
  final String workerName;
  
  @HiveField(4)
  final String role;
  
  @HiveField(5)
  final double wage;
  
  @HiveField(6)
  final AttendanceStatus status;
  
  @HiveField(7)
  final DateTime date;
  
  @HiveField(8)
  final double overtimeHours;
  
  @HiveField(9)
  final DateTime createdAt;

  WorkerAttendance({
    required this.id,
    required this.workerId,
    required this.projectId,
    required this.workerName,
    required this.role,
    required this.wage,
    required this.status,
    required this.date,
    this.overtimeHours = 0.0,
    required this.createdAt,
  });

  WorkerAttendance copyWith({
    String? id,
    String? workerId,
    String? projectId,
    String? workerName,
    String? role,
    double? wage,
    AttendanceStatus? status,
    DateTime? date,
    double? overtimeHours,
    DateTime? createdAt,
  }) {
    return WorkerAttendance(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      projectId: projectId ?? this.projectId,
      workerName: workerName ?? this.workerName,
      role: role ?? this.role,
      wage: wage ?? this.wage,
      status: status ?? this.status,
      date: date ?? this.date,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id, workerId, projectId, workerName, role, wage, status, date, overtimeHours, createdAt
  ];
}

// ============ Cash Advance Model ============
@HiveType(typeId: 4)
class CashAdvance extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String workerId;
  
  @HiveField(2)
  final String projectId;
  
  @HiveField(3)
  final double amount;
  
  @HiveField(4)
  final String description;
  
  @HiveField(5)
  final DateTime givenDate;
  
  @HiveField(6)
  final DateTime? adjustedDate;
  
  @HiveField(7)
  final DateTime createdAt;

  CashAdvance({
    required this.id,
    required this.workerId,
    required this.projectId,
    required this.amount,
    required this.description,
    required this.givenDate,
    this.adjustedDate,
    required this.createdAt,
  });

  CashAdvance copyWith({
    String? id,
    String? workerId,
    String? projectId,
    double? amount,
    String? description,
    DateTime? givenDate,
    DateTime? adjustedDate,
    DateTime? createdAt,
  }) {
    return CashAdvance(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      givenDate: givenDate ?? this.givenDate,
      adjustedDate: adjustedDate ?? this.adjustedDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id, workerId, projectId, amount, description, givenDate, adjustedDate, createdAt
  ];
}
