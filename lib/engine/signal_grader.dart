import 'package:drift/drift.dart';

import '../data/database/app_database.dart';
import '../data/datasources/remote/yahoo_finance_client.dart';

/// Grades past signals by 30/60/90d forward returns — mirrors signal_grader.py.
class SignalGrader {
  SignalGrader(this._db, {YahooFinanceClient? yahoo})
      : _yahoo = yahoo ?? YahooFinanceClient();

  final AppDatabase _db;
  final YahooFinanceClient _yahoo;

  Future<int> syncNewSignals() async {
    final analyses = await _db.select(_db.analysisResults).get();
    var count = 0;
    for (final a in analyses) {
      final existing = await (_db.select(_db.signalGrades)
            ..where((t) => t.analysisId.equals(a.id)))
          .getSingleOrNull();
      if (existing != null) continue;

      await _db.into(_db.signalGrades).insert(
            SignalGradesCompanion.insert(
              analysisId: a.id,
              symbol: a.symbol,
              signal: a.signal,
              confidence: Value((a.confidence * 100).round()),
              quantScore: Value(a.quantScore),
              signalDate: a.createdAt,
              priceAtSignal: Value(a.currentPrice),
              grade: const Value('pending'),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      count++;
    }
    return count;
  }

  Future<int> gradePendingSignals() async {
    await syncNewSignals();
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    final pending = await (_db.select(_db.signalGrades)
          ..where((t) =>
              t.signalDate.isSmallerOrEqualValue(cutoff) &
              (t.grade.equals('pending') |
                  t.grade.equals('partially_correct') |
                  t.price90d.isNull())))
        .get();

    var graded = 0;
    for (final rec in pending.take(50)) {
      final result = await _gradeRecord(rec);
      if (result) graded++;
    }
    return graded;
  }

  Future<bool> _gradeRecord(SignalGradeData rec) async {
    try {
      final bars = await _yahoo.getOhlcvHistory(rec.symbol, range: '6mo');
      if (bars.length < 10) return false;

      double? priceAtSignal = rec.priceAtSignal;
      priceAtSignal ??= _priceNear(bars, rec.signalDate);

      if (priceAtSignal == null || priceAtSignal <= 0) return false;

      final dt30 = rec.signalDate.add(const Duration(days: 30));
      final dt60 = rec.signalDate.add(const Duration(days: 60));
      final dt90 = rec.signalDate.add(const Duration(days: 90));

      final p30 = rec.price30d ?? _priceNear(bars, dt30);
      final p60 = rec.price60d ?? _priceNear(bars, dt60);
      final p90 = rec.price90d ?? _priceNear(bars, dt90);

      final r30 = p30 != null ? (p30 - priceAtSignal) / priceAtSignal : null;
      final r60 = p60 != null ? (p60 - priceAtSignal) / priceAtSignal : null;
      final r90 = p90 != null ? (p90 - priceAtSignal) / priceAtSignal : null;

      final grade = _computeGrade(rec.signal, r30, r60, r90);

      await (_db.update(_db.signalGrades)..where((t) => t.id.equals(rec.id)))
          .write(SignalGradesCompanion(
        priceAtSignal: Value(priceAtSignal),
        price30d: Value(p30),
        price60d: Value(p60),
        price90d: Value(p90),
        return30d: Value(r30),
        return60d: Value(r60),
        return90d: Value(r90),
        grade: Value(grade),
        gradedAt: Value(DateTime.now()),
      ));
      return true;
    } catch (_) {
      return false;
    }
  }

  double? _priceNear(List<Map<String, dynamic>> bars, DateTime target) {
    Map<String, dynamic>? closest;
    var minDiff = 999999;
    for (final bar in bars) {
      final ts = DateTime.tryParse(bar['timestamp']?.toString() ?? '');
      if (ts == null) continue;
      final diff = (ts.difference(target).inDays).abs();
      if (diff < minDiff && diff <= 5) {
        minDiff = diff;
        closest = bar;
      }
    }
    return closest != null ? (closest['close'] as num).toDouble() : null;
  }

  String _computeGrade(
    String signal,
    double? r30,
    double? r60,
    double? r90,
  ) {
    if (r30 == null) return 'pending';

    final bullish = signal == 'Opportunity' || signal.contains('Buy');
    final bearish = signal == 'Caution' || signal.contains('Sell');

    if (bullish) {
      if (r30 > 0.02) return 'correct';
      if (r60 != null && r60 > 0.04) return 'partially_correct';
      if (r90 != null && r90 > 0.05) return 'partially_correct';
      return 'incorrect';
    }
    if (bearish) {
      if (r30 < -0.02) return 'correct';
      if (r60 != null && r60 < -0.04) return 'partially_correct';
      if (r90 != null && r90 < -0.05) return 'partially_correct';
      return 'incorrect';
    }
    if (r30.abs() < 0.03) return 'correct';
    return 'incorrect';
  }

  Future<Map<String, dynamic>> getGradeStats() async {
    final all = await _db.select(_db.signalGrades).get();
    final graded = all.where((g) => g.grade != 'pending').toList();
    if (graded.isEmpty) {
      return {'total': 0, 'correct': 0, 'hit_rate': 0.0, 'pending': all.length};
    }
    final correct = graded.where((g) => g.grade == 'correct').length;
    final partial =
        graded.where((g) => g.grade == 'partially_correct').length;
    return {
      'total': graded.length,
      'correct': correct,
      'partially_correct': partial,
      'incorrect': graded.where((g) => g.grade == 'incorrect').length,
      'hit_rate': double.parse(
          ((correct + partial * 0.5) / graded.length * 100).toStringAsFixed(1)),
      'pending': all.where((g) => g.grade == 'pending').length,
    };
  }
}
