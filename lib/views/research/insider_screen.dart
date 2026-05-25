import 'package:flutter/material.dart';

class InsiderScreen extends StatelessWidget {
  const InsiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insider Trading')),
      body: const Center(
        child: Text('Insider trading data — coming soon'),
      ),
    );
  }
}
