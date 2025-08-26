import 'package:flutter/material.dart';
import 'tap.dart';
import 'dart:io';

class TapDetail extends StatelessWidget {
  final Tap tap;

  const TapDetail({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tap.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (tap.description.isNotEmpty) Text(tap.description),
          const SizedBox(height: 8),
          if (tap.imagePath != null && tap.imagePath!.isNotEmpty)
            Image.file(File(tap.imagePath!), height: 150),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Schließen'),
          ),
        ],
      ),
    );
  }
}
