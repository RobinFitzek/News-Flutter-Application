import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'stockholm_colors.dart';

class AppTheme {
  AppTheme._();

  static const Color gainColor = StockholmColors.signalPositive;
  static const Color lossColor = StockholmColors.signalNegative;

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = isDark ? StockholmColors.bgPrimary : const Color(0xFFF5F2EC);
    final surface = isDark ? StockholmColors.bgSecondary : Colors.white;
    final onSurface =
        isDark ? StockholmColors.textPrimary : const Color(0xFF1A1A22);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: StockholmColors.signalNeutral,
      onPrimary: Colors.white,
      secondary: StockholmColors.signalWarning,
      onSecondary: Colors.black,
      error: StockholmColors.signalNegative,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
    );

    final textTheme = GoogleFonts.ibmPlexSansTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: base,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: base.withValues(alpha: 0.85),
        foregroundColor: onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? StockholmColors.bgCard : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isDark
                ? StockholmColors.borderPrimary
                : const Color(0xFFE8E4DE),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? StockholmColors.borderPrimary
            : const Color(0xFFE8E4DE),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? StockholmColors.bgTertiary : const Color(0xFFF0ECE6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: StockholmColors.borderPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: StockholmColors.borderPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: StockholmColors.borderHighlight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: StockholmColors.signalNeutral,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? StockholmColors.bgSecondary : surface,
        indicatorColor: StockholmColors.glassTint,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
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
