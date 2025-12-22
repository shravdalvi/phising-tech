import 'package:flutter/material.dart';

class RiskBadge extends StatelessWidget {
  final String risk;
  const RiskBadge({super.key, required this.risk});

  Color get _color {
    switch (risk) {
      case 'No Risk':
        return Colors.green;
      case 'Low':
        return Colors.lightGreen;
      case 'Medium':
        return Colors.orange;
      case 'Potential Threat':
        return Colors.deepOrange;
      case 'High Risk':
      default:
        return Colors.red;
    }
  }

  IconData get _icon {
    switch (risk) {
      case 'No Risk':
        return Icons.check_circle_outline;
      case 'Low':
        return Icons.info_outline;
      case 'Medium':
        return Icons.warning_amber_outlined;
      case 'Potential Threat':
        return Icons.error_outline;
      case 'High Risk':
      default:
        return Icons.dangerous_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: _color,
            width: 6,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Risk Level: $risk',
              style: TextStyle(
                color: _color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}