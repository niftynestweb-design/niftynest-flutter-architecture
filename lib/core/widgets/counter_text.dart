import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  final num value;
  final String prefix;
  final String suffix;
  final TextStyle? style;
  final Duration duration;

  const CounterText({
    super.key,
    required this.value,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        String displayValue;
        if (value >= 1000) {
          displayValue = '${(value / 1000).toStringAsFixed(1)}k';
        } else {
          displayValue = value.toInt().toString();
        }
        
        if (prefix == '\$') {
          // Manual comma formatting for simple numbers
          final intVal = value.toInt();
          final buffer = StringBuffer();
          final s = intVal.toString();
          for (int i = 0; i < s.length; i++) {
            if (i > 0 && (s.length - i) % 3 == 0) {
              buffer.write(',');
            }
            buffer.write(s[i]);
          }
          displayValue = buffer.toString();
        }

        return Text(
          '$prefix$displayValue$suffix',
          style: style,
        );
      },
    );
  }
}
