import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/widgets/dashboard/fear_greed_dash_card.dart';

void main() {
  testWidgets('FearGreedDashCard reads score and sentiment from engine', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FearGreedDashCard(
            data: {
              'score': 82,
              'sentiment': 'Extreme Greed',
              'vix': 14.2,
            },
          ),
        ),
      ),
    );

    expect(find.text('82'), findsOneWidget);
    expect(find.text('Extreme Greed'), findsOneWidget);
    expect(find.text('VIX 14.2'), findsOneWidget);
  });
}
