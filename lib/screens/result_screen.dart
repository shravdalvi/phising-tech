import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/risk_badge.dart';
import '../widgets/explanation_card.dart';
import '../services/analysis_service.dart';

class ResultScreen extends StatelessWidget {
  final String message;
  const ResultScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final result = AnalysisService.analyze(message);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RiskBadge(risk: result['risk']!),
              const SizedBox(height: 16),
              ExplanationCard(
                language: result['language']!,
                tactic: result['tactic']!,
                explanation: result['explanation']!,
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(message),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

