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

      bool isMaxOffset = offset.abs() == 30.0;

      Widget buttonContent = Container(
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
      );

      if (isMaxOffset) {
        buttonContent = Stack(
          clipBehavior: Clip.none,
          children: [
            buttonContent,
            Positioned(
              top: -40,
              bottom: -40,
              right: offset > 0 ? -60 : null,
              left: offset < 0 ? -60 : null,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber[700]!.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'BONUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }

      buttons.add(buttonContent);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: section.color,
                border: Border.all(color: Colors.green, width: 1),
              ),
              height: 180.0,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Text(
                section.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // const SizedBox(height: 20),
            ...buttons,
          ],
        ),
      ),
    );
  }
}
