import 'package:flutter/material.dart';

import '../services/analysis_service.dart';
import '../widgets/risk_badge.dart';
import '../widgets/explanation_card.dart';

class ResultScreen extends StatelessWidget {
  final String analyzedText;
  final AnalysisResult result;

  const ResultScreen({
    super.key,
    required this.analyzedText,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Analysis Result'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(analyzedText),
            ),

            const SizedBox(height: 24),

            RiskBadge(
              risk: result.risk,
              language: result.language,
              tactic: result.tactic,
              explanation: result.explanation,
            ),

            const SizedBox(height: 24),

            ExplanationCard(
              explanation: result.explanation,
            ),
          ],
        ),
      ),
    );
  }
}

