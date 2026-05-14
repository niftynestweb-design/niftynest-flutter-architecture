import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardTimeframe { sevenDays, thirtyDays, ninetyDays, oneYear }

class DashboardState {
  final DashboardTimeframe timeframe;
  final bool isLoading;
  final Map<String, double> metrics;

  DashboardState({
    required this.timeframe,
    this.isLoading = false,
    this.metrics = const {},
  });

  DashboardState copyWith({
    DashboardTimeframe? timeframe,
    bool? isLoading,
    Map<String, double>? metrics,
  }) {
    return DashboardState(
      timeframe: timeframe ?? this.timeframe,
      isLoading: isLoading ?? this.isLoading,
      metrics: metrics ?? this.metrics,
    );
  }
}

class DashboardNotifier extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    return DashboardState(timeframe: DashboardTimeframe.thirtyDays);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));
    
    state = state.copyWith(isLoading: false);
  }

  void setTimeframe(DashboardTimeframe timeframe) {
    if (state.timeframe == timeframe) return;
    
    state = state.copyWith(timeframe: timeframe);
    refresh();
  }
}

final dashboardControllerProvider = NotifierProvider<DashboardNotifier, DashboardState>(() {
  return DashboardNotifier();
});
