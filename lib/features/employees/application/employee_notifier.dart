import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/mock/employee_mock.dart';
import '../../../shared/models/employee.dart';

enum EmployeeSortField { name, role, department, status }

class EmployeeTableState {
  final List<Employee> employees;
  final bool isLoading;
  final String searchQuery;
  final EmployeeSortField? sortField;
  final bool isAscending;

  EmployeeTableState({
    required this.employees,
    this.isLoading = false,
    this.searchQuery = '',
    this.sortField,
    this.isAscending = true,
  });

  EmployeeTableState copyWith({
    List<Employee>? employees,
    bool? isLoading,
    String? searchQuery,
    EmployeeSortField? sortField,
    bool? isAscending,
  }) {
    return EmployeeTableState(
      employees: employees ?? this.employees,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      sortField: sortField ?? this.sortField,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}

class EmployeeNotifier extends Notifier<EmployeeTableState> {
  @override
  EmployeeTableState build() {
    return EmployeeTableState(employees: mockEmployees);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void sortBy(EmployeeSortField field) {
    final bool ascending = state.sortField == field ? !state.isAscending : true;
    state = state.copyWith(sortField: field, isAscending: ascending);
    _applyFilters();
  }

  void _applyFilters() {
    List<Employee> filtered = mockEmployees.where((e) {
      final query = state.searchQuery.toLowerCase();
      return e.name.toLowerCase().contains(query) ||
             e.email.toLowerCase().contains(query) ||
             e.role.toLowerCase().contains(query);
    }).toList();

    if (state.sortField != null) {
      filtered.sort((a, b) {
        int result = 0;
        switch (state.sortField!) {
          case EmployeeSortField.name:
            result = a.name.compareTo(b.name);
            break;
          case EmployeeSortField.role:
            result = a.role.compareTo(b.role);
            break;
          case EmployeeSortField.department:
            result = a.department.compareTo(b.department);
            break;
          case EmployeeSortField.status:
            result = a.status.index.compareTo(b.status.index);
            break;
        }
        return state.isAscending ? result : -result;
      });
    }

    state = state.copyWith(employees: filtered);
  }
}

final employeeTableControllerProvider = NotifierProvider<EmployeeNotifier, EmployeeTableState>(() {
  return EmployeeNotifier();
});
