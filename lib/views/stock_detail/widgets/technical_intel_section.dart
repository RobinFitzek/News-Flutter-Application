import 'package:flutter/material.dart';
import '../../../engine/pattern_recognition.dart';
import '../../../config/stockholm_colors.dart';
import '../../../widgets/glass_card.dart';

class TechnicalIntelSection extends StatefulWidget {
  const TechnicalIntelSection({super.key, required this.symbol});

  final String symbol;

  @override
  State<TechnicalIntelSection> createState() => _TechnicalIntelSectionState();
}

class _TechnicalIntelSectionState extends State<TechnicalIntelSection> {
  List<Map<String, dynamic>> _patterns = [];
  Map<String, dynamic>? _mtf;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final patterns = await PatternRecognizer().detectPatterns(widget.symbol);
    final mtf = await MultiTimeframeAnalyzer().analyze(widget.symbol);
    if (mounted) {
      setState(() {
        _patterns = patterns;
        _mtf = mtf;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
    }

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Technical Intelligence',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 8),
            Text(
              'MTF alignment: ${_mtf?['alignment'] ?? '—'}',
              style: const TextStyle(fontSize: 13),
            ),
            if (_mtf?['timeframes'] != null) ...[
              const SizedBox(height: 4),
              Text(
                (_mtf!['timeframes'] as Map)
                    .entries
                    .map((e) => '${e.key}: ${e.value}')
                    .join(' · '),
                style: const TextStyle(
                    fontSize: 12, color: StockholmColors.textSecondary),
              ),
            ],
            if (_patterns.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._patterns.map((p) => Text(
                    '• ${p['pattern']} (${p['confidence']}% ${p['direction']})',
                    style: const TextStyle(fontSize: 13),
                  )),
            ] else
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('No chart patterns detected',
                    style: TextStyle(
                        fontSize: 12, color: StockholmColors.textSecondary)),
              ),
          ],
        ),
      ),
    );
  }
}
