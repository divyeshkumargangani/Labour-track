import 'package:equatable/equatable.dart';

class ActivityItem extends Equatable {
  final String id;
  final String workerId;
  final String workerName;
  final String action;
  final DateTime timestamp;
  final String iconName;
  final String color;

  const ActivityItem({
    required this.id,
    required this.workerId,
    required this.workerName,
    required this.action,
    required this.timestamp,
    required this.iconName,
    required this.color,
  });

  @override
  List<Object?> get props => [
    id, workerId, workerName, action, timestamp, iconName, color
  ];
}
