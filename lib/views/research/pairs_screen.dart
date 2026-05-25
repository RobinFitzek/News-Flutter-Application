import 'package:flutter/material.dart';

class PairsScreen extends StatelessWidget {
  const PairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pairs Trading')),
      body: const Center(
        child: Text('Pairs trading signals — coming soon'),
      ),
    );
  }
}
