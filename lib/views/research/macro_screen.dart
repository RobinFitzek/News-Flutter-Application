import 'package:flutter/material.dart';

class MacroScreen extends StatelessWidget {
  const MacroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Macro Dashboard')),
      body: const Center(
        child: Text('Macro economic data — coming soon'),
      ),
    );
  }
}
