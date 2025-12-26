import 'package:flutter/material.dart';

class ExplanationCard extends StatelessWidget {
  final String explanation;

  const ExplanationCard({
    super.key,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        explanation,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

