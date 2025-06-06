import 'package:flutter/material.dart';
import '../models/section_model.dart';
import 'jelly_button.dart';

class SectionWidget extends StatelessWidget {
  final SectionModel section;

  const SectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];

    final offsets = [
      0.0,
      40.0,
      80.0,
      40.0,
      0.0,
      -40.0,
      -80.0,
      -40.0,
    ]; // Sine-style wave

    for (int i = 0; i < section.buttonCount; i++) {
      double offset = (i == 0 || i == section.buttonCount - 1)
          ? 0
          : offsets[i % offsets.length];
      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment(offset / 100, 0),
            child: JellyButton(label: 'Item ${i + 1}', color: section.color),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          Text(
            section.title,
            style: TextStyle(
              color: section.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...buttons,
        ],
      ),
    );
  }
}
