import 'package:flutter/material.dart';

class ExplanationCard extends StatelessWidget {
  final String language;
  final String tactic;
  final String explanation;

  const ExplanationCard({
    super.key,
    required this.language,
    required this.tactic,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detected Language: $language'),
            const SizedBox(height: 8),
            Text('Manipulation Tactic: $tactic'),
            const SizedBox(height: 12),
            Text(explanation),
          ],
        ),
      ),
    );
  }
}
