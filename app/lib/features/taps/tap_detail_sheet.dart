import 'dart:io';
import 'package:flutter/material.dart';

import 'tap.dart';

class TapDetailSheet extends StatelessWidget {
  final Tap tap;

  const TapDetailSheet({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tap.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (tap.description.isNotEmpty)
            Text(
              tap.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 16),
          if (tap.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(tap.imagePath!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  // TODO: Bearbeiten implementieren
                },
                icon: const Icon(Icons.edit),
                label: const Text("Bearbeiten"),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Löschen implementieren
                },
                icon: const Icon(Icons.delete),
                label: const Text("Löschen"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
