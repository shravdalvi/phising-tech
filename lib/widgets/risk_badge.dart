import 'package:flutter/material.dart';

class RiskBadge extends StatelessWidget {
  final String risk;
  final String language;
  final String tactic;
  final String explanation;

  const RiskBadge({
    super.key,
    required this.risk,
    required this.language,
    required this.tactic,
    required this.explanation,
  });

  Color get _riskColor {
    switch (risk.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _riskColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Level: $risk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _riskColor,
            ),
          ),
          const SizedBox(height: 8),
          Text('Language: $language'),
          Text('Tactic: $tactic'),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
