import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_design_system.dart';

class TableColumn<T> {
  final String title;
  final Widget Function(T) builder;
  final double? width;
  final dynamic sortValue;

  TableColumn({
    required this.title,
    required this.builder,
    this.width,
    this.sortValue,
  });
}

class EnterpriseTable<T> extends StatelessWidget {
  final List<T> items;
  final List<TableColumn<T>> columns;
  final Function(T)? onRowTap;
  final dynamic currentSortField;
  final bool isAscending;
  final Function(dynamic)? onSort;

  const EnterpriseTable({
    super.key,
    required this.items,
    required this.columns,
    this.onRowTap,
    this.currentSortField,
    this.isAscending = true,
    this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDesign.radiusL),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return _buildRow(context, items[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceM),
      child: Row(
        children: columns.map((col) {
          final isSortable = col.sortValue != null;
          final isCurrentSort = currentSortField == col.sortValue;

          Widget header = Text(
            col.title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              letterSpacing: 1.0,
            ),
          );

          if (isSortable) {
            header = InkWell(
              onTap: () => onSort?.call(col.sortValue),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  header,
                  const SizedBox(width: 4),
                  Icon(
                    isCurrentSort 
                      ? (isAscending ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded)
                      : Icons.unfold_more_rounded,
                    size: 12,
                    color: isCurrentSort ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.3),
                  ),
                ],
              ),
            );
          }

          if (col.width != null) {
            return SizedBox(width: col.width, child: header);
          }
          return Expanded(child: header);
        }).toList(),
      ),
    );
  }

  Widget _buildRow(BuildContext context, T item) {
    return InkWell(
      onTap: onRowTap != null ? () => onRowTap!(item) : null,
      hoverColor: AppColors.sidebarActive.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDesign.spaceL, vertical: AppDesign.spaceM),
        child: Row(
          children: columns.map((col) {
            final content = col.builder(item);
            if (col.width != null) {
              return SizedBox(width: col.width, child: content);
            }
            return Expanded(child: content);
          }).toList(),
        ),
      ),
    );
  }
}
