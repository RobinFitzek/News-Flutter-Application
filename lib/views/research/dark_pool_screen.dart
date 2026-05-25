import 'package:flutter/material.dart';

class DarkPoolScreen extends StatelessWidget {
  const DarkPoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dark Pool')),
      body: const Center(
        child: Text('Dark pool signals — coming soon'),
      ),
    );
  }
}
