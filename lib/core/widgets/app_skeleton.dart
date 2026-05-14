import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

class AppSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;

  const AppSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.card,
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSkeleton(height: 32, width: 200),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 768
                ? 1
                : (MediaQuery.of(context).size.width < 1200 ? 2 : 4),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: MediaQuery.of(context).size.width < 768
                ? 2.2
                : (MediaQuery.of(context).size.width < 1200 ? 1.8 : 1.5),
          ),
          itemCount: 4,
          itemBuilder: (context, index) => const AppSkeleton(),
        ),
        const SizedBox(height: 24),
        if (MediaQuery.of(context).size.width >= 1200)
          const Row(
            children: [
              Expanded(flex: 2, child: AppSkeleton(height: 400)),
              SizedBox(width: 24),
              Expanded(flex: 1, child: AppSkeleton(height: 400)),
            ],
          )
        else
          const Column(
            children: [
              AppSkeleton(height: 400),
              SizedBox(height: 24),
              AppSkeleton(height: 400),
            ],
          ),
      ],
    );
  }
}
