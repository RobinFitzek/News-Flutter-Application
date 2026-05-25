import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color gainColor = Colors.green;
  static const Color lossColor = Colors.red;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      cardTheme: CardThemeData(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      extensions: const [
        StockColors(
          gainColor: gainColor,
          lossColor: lossColor,
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      cardTheme: CardThemeData(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      extensions: const [
        StockColors(
          gainColor: gainColor,
          lossColor: lossColor,
        ),
      ],
    );
  }
}

class StockColors extends ThemeExtension<StockColors> {
  const StockColors({
    required this.gainColor,
    required this.lossColor,
  });

  final Color gainColor;
  final Color lossColor;

  @override
  StockColors copyWith({
    Color? gainColor,
    Color? lossColor,
  }) {
    return StockColors(
      gainColor: gainColor ?? this.gainColor,
      lossColor: lossColor ?? this.lossColor,
    );
  }

  @override
  StockColors lerp(ThemeExtension<StockColors>? other, double t) {
    if (other is! StockColors) return this;
    return StockColors(
      gainColor: Color.lerp(gainColor, other.gainColor, t)!,
      lossColor: Color.lerp(lossColor, other.lossColor, t)!,
    );
  }
}
