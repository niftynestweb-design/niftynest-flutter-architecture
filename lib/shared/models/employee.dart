import '../../core/widgets/app_badge.dart';

class Employee {
  final String id;
  final String name;
  final String email;
  final String role;
  final String department;
  final String avatarUrl;
  final BadgeStatus status;
  final DateTime joinDate;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.avatarUrl,
    required this.status,
    required this.joinDate,
  });
}
