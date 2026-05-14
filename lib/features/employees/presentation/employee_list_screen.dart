import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../shared/components/tables/enterprise_table.dart';
import '../application/employee_notifier.dart';
import '../../../shared/models/employee.dart';

class EmployeeListScreen extends ConsumerWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employeeTableControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Personnel Management',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            AppButton(
              label: 'Add Employee',
              onPressed: () {},
              icon: Icons.person_add_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AppSearchBar(
                hintText: 'Search employees...',
                onChanged: (val) => ref.read(employeeTableControllerProvider.notifier).setSearchQuery(val),
              ),
            ),
            const SizedBox(width: 16),
            AppButton(
              label: 'Filter',
              variant: ButtonVariant.secondary,
              onPressed: () {},
              icon: Icons.filter_list_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (state.employees.isEmpty)
          const Expanded(
            child: AppEmptyState(
              title: 'No employees found',
              description: 'Try adjusting your search or filters to find what you are looking for.',
              icon: Icons.people_outline_rounded,
            ),
          )
        else
          Responsive(
            mobile: _buildMobileList(state.employees),
            desktop: _buildDesktopTable(ref, state),
          ),
      ],
    );
  }

  Widget _buildDesktopTable(WidgetRef ref, EmployeeTableState state) {
    return EnterpriseTable<Employee>(
      items: state.employees,
      currentSortField: state.sortField,
      isAscending: state.isAscending,
      onSort: (val) => ref.read(employeeTableControllerProvider.notifier).sortBy(val as EmployeeSortField),
      columns: [
        TableColumn(
          title: 'EMPLOYEE',
          width: 300,
          sortValue: EmployeeSortField.name,
          builder: (e) => Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(e.avatarUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    e.email,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        TableColumn(
          title: 'DEPARTMENT',
          sortValue: EmployeeSortField.department,
          builder: (e) => Text(
            e.department,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
        TableColumn(
          title: 'ROLE',
          sortValue: EmployeeSortField.role,
          builder: (e) => Text(
            e.role,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
        TableColumn(
          title: 'STATUS',
          sortValue: EmployeeSortField.status,
          builder: (e) => AppBadge(
            label: e.status.name,
            status: e.status,
          ),
        ),
        TableColumn(
          title: '',
          width: 50,
          builder: (e) => IconButton(
            icon: const Icon(Icons.more_vert_rounded, size: 18),
            onPressed: () {},
            color: AppColors.textSecondary,
          ),
        ),
      ],
      onRowTap: (e) {},
    );
  }

  Widget _buildMobileList(List<Employee> employees) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final e = employees[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(e.avatarUrl),
            ),
            title: Text(e.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(e.role, style: const TextStyle(fontSize: 12)),
            trailing: AppBadge(label: e.status.name, status: e.status),
            onTap: () {},
          ),
        );
      },
    );
  }
}
