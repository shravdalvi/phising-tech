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
    final risk = result['risk']!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: child,
              );
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Risk Badge (main focus)
                RiskBadge(risk: risk),

                const SizedBox(height: 24),

                // Explanation heading
                Text(
                  'Why this message was flagged',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),

                // Explanation card
                ExplanationCard(
                  language: result['language']!,
                  tactic: result['tactic']!,
                  explanation: result['explanation']!,
                ),

                const SizedBox(height: 28),

                // Original message
                Text(
                  'Message analyzed:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

