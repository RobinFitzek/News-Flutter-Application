import 'package:flutter/material.dart';
import '../../config/theme.dart';

class StockPriceDisplay extends StatelessWidget {
  const StockPriceDisplay({
    super.key,
    required this.price,
    required this.change,
    required this.changePercent,
    this.fontSize = 16,
    this.showIcon = true,
  });

  final double price;
  final double change;
  final double changePercent;
  final double fontSize;
  final bool showIcon;

  StockColors _colors(BuildContext context) {
    return Theme.of(context).extension<StockColors>() ?? const StockColors(
          gainColor: Colors.green,
          lossColor: Colors.red,
        );
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);
    final isPositive = change >= 0;
    final color = isPositive ? colors.gainColor : colors.lossColor;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            if (showIcon)
              Icon(
                icon,
                size: fontSize,
                color: color,
              ),
            const SizedBox(width: 2),
            Text(
              '${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${changePercent.toStringAsFixed(2)}%)',
              style: TextStyle(
                fontSize: fontSize - 2,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
