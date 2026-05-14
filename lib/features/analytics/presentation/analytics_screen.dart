import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../dashboard/presentation/widgets/dashboard_card.dart';
import 'widgets/revenue_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business Intelligence',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildMetricCard('Total Revenue', '\$128,430', '+12.5%', true),
              const SizedBox(width: 16),
              _buildMetricCard('Gross Profit', '\$84,200', '+8.2%', true),
              const SizedBox(width: 16),
              _buildMetricCard('Avg. Order', '\$142.50', '-2.1%', false),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Revenue Performance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  const SizedBox(
                    height: 300,
                    child: RevenueChart(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSecondaryMetrics(),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String change, bool isPositive) {
    return Expanded(
      child: DashboardCard(
        title: title,
        value: value,
        change: change,
        isPositive: isPositive,
        icon: Icons.trending_up_rounded,
      ),
    );
  }

  Widget _buildSecondaryMetrics() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(24),
              child: const Center(
                child: Text('Customer Acquisition (Placeholder)', style: TextStyle(color: AppColors.textSecondary)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Card(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(24),
              child: const Center(
                child: Text('Regional Distribution (Placeholder)', style: TextStyle(color: AppColors.textSecondary)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
