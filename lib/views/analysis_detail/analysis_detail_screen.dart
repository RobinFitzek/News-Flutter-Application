import 'package:flutter/material.dart';

class AnalysisDetailScreen extends StatelessWidget {
  const AnalysisDetailScreen({super.key, required this.analysisId});

  final int analysisId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis #$analysisId'),
      ),
      body: const Center(
        child: Text('Analysis details — coming soon'),
      ),
    );
  }
}
