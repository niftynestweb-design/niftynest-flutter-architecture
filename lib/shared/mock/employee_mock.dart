import '../../core/widgets/app_badge.dart';
import '../models/employee.dart';

final List<Employee> mockEmployees = [
  Employee(
    id: '1',
    name: 'Moaz Aamir',
    email: 'moaz@niftynest.com',
    role: 'Senior Software Architect',
    department: 'Engineering',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Moaz',
    status: BadgeStatus.success,
    joinDate: DateTime(2023, 1, 15),
  ),
  Employee(
    id: '2',
    name: 'Sarah Chen',
    email: 'sarah.c@niftynest.com',
    role: 'Product Designer',
    department: 'Design',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah',
    status: BadgeStatus.success,
    joinDate: DateTime(2023, 3, 10),
  ),
  Employee(
    id: '3',
    name: 'James Wilson',
    email: 'j.wilson@niftynest.com',
    role: 'Frontend Developer',
    department: 'Engineering',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=James',
    status: BadgeStatus.warning,
    joinDate: DateTime(2023, 5, 20),
  ),
  Employee(
    id: '4',
    name: 'Elena Rodriguez',
    email: 'elena.r@niftynest.com',
    role: 'HR Manager',
    department: 'Operations',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Elena',
    status: BadgeStatus.info,
    joinDate: DateTime(2022, 11, 05),
  ),
  Employee(
    id: '5',
    name: 'David Kim',
    email: 'd.kim@niftynest.com',
    role: 'DevOps Engineer',
    department: 'Engineering',
    avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=David',
    status: BadgeStatus.error,
    joinDate: DateTime(2023, 8, 12),
  ),
  // Add more as needed for scrolling/pagination demos
];
