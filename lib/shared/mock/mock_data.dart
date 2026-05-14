class DashboardStats {
  final String title;
  final String value;
  final String change;
  final bool isPositive;

  DashboardStats({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
  });
}

final List<DashboardStats> mockDashboardStats = [
  DashboardStats(
    title: 'Total Revenue',
    value: '\$142,380',
    change: '+14.2%',
    isPositive: true,
  ),
  DashboardStats(
    title: 'Active Nodes',
    value: '1,240',
    change: '+5.4%',
    isPositive: true,
  ),
  DashboardStats(
    title: 'System Latency',
    value: '24ms',
    change: '-12.5%',
    isPositive: true,
  ),
  DashboardStats(
    title: 'Resource Usage',
    value: '68.4%',
    change: '+2.1%',
    isPositive: false,
  ),
];

class Employee {
  final String id;
  final String name;
  final String email;
  final String role;
  final String department;
  final EmployeeStatus status;
  final String avatarUrl;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.status,
    required this.avatarUrl,
  });
}

enum EmployeeStatus { active, inactive, onboarding }

final List<Employee> mockEmployees = [
  Employee(
    id: '1',
    name: 'Alexander Sterling',
    email: 'a.sterling@niftynest.io',
    role: 'Lead Systems Architect',
    department: 'Engineering',
    status: EmployeeStatus.active,
    avatarUrl: 'https://i.pravatar.cc/150?u=1',
  ),
  Employee(
    id: '2',
    name: 'Elena Rodriguez',
    email: 'e.rodriguez@niftynest.io',
    role: 'Senior Product Designer',
    department: 'Design',
    status: EmployeeStatus.active,
    avatarUrl: 'https://i.pravatar.cc/150?u=2',
  ),
  Employee(
    id: '3',
    name: 'Marcus Thorne',
    email: 'm.thorne@niftynest.io',
    role: 'DevOps Engineer',
    department: 'Infrastructure',
    status: EmployeeStatus.onboarding,
    avatarUrl: 'https://i.pravatar.cc/150?u=3',
  ),
  Employee(
    id: '4',
    name: 'Sophia Vanderbilt',
    email: 's.vanderbilt@niftynest.io',
    role: 'Head of Operations',
    department: 'Management',
    status: EmployeeStatus.active,
    avatarUrl: 'https://i.pravatar.cc/150?u=4',
  ),
  Employee(
    id: '5',
    name: 'Julian Blackwood',
    email: 'j.blackwood@niftynest.io',
    role: 'Security Analyst',
    department: 'Engineering',
    status: EmployeeStatus.inactive,
    avatarUrl: 'https://i.pravatar.cc/150?u=5',
  ),
  Employee(
    id: '6',
    name: 'Isabella Grant',
    email: 'i.grant@niftynest.io',
    role: 'QA Automation Lead',
    department: 'Engineering',
    status: EmployeeStatus.active,
    avatarUrl: 'https://i.pravatar.cc/150?u=6',
  ),
];
