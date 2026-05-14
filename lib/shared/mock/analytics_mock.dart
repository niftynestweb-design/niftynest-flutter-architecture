class ChartDataPoint {
  final double x;
  final double y;

  ChartDataPoint(this.x, this.y);
}

final List<ChartDataPoint> mockRevenueData = [
  ChartDataPoint(0, 45000),
  ChartDataPoint(1, 52000),
  ChartDataPoint(2, 48000),
  ChartDataPoint(3, 61000),
  ChartDataPoint(4, 55000),
  ChartDataPoint(5, 72000),
  ChartDataPoint(6, 68000),
  ChartDataPoint(7, 85000),
  ChartDataPoint(8, 79000),
  ChartDataPoint(9, 92000),
  ChartDataPoint(10, 88000),
  ChartDataPoint(11, 105000),
];

final List<String> mockMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];
