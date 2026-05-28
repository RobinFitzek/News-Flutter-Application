import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/stockholm_colors.dart';

/// Frosted glass card matching Stockholm design system.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: StockholmColors.glassTint,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: StockholmColors.borderPrimary),
          ),
          child: child,
        ),
      ),
    );

    return Padding(
      padding: margin,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: card,
            )
          : card,
    );
  }
}
