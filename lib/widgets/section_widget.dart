import 'package:flutter/material.dart';
import '../models/section_model.dart';
import 'jelly_button.dart';

class SectionWidget extends StatelessWidget {
  final SectionModel section;
  final int sectionIndex;

  const SectionWidget({
    super.key,
    required this.section,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];

    final offsets = [0.0, 20.0, 30.0, 20.0, 0.0, -20.0, -30.0, -20.0];

    final reverseOffsets = offsets.map((offset) => -offset).toList();

    final adjustedOffsets = (sectionIndex % 2 == 1) ? reverseOffsets : offsets;

    for (int i = 0; i < section.buttonCount; i++) {
      double offset = (i == 0 || i == section.buttonCount - 1)
          ? 0
          : adjustedOffsets[i % adjustedOffsets.length];
      buttons.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Align(
              alignment: Alignment(offset / 100, 0),
              child: JellyButton(label: 'Item ${i + 1}', color: section.color),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: Text(
                section.title,
                style: TextStyle(
                  color: section.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...buttons,
          ],
        ),
      ),
    );
  }
}
