import 'package:flutter/material.dart';

class RiskBadge extends StatelessWidget {
  final String risk;
  const RiskBadge({super.key, required this.risk});

  Color _color() {
    switch (risk) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('Risk Level: $risk'),
      backgroundColor: _color().withOpacity(0.15),
      labelStyle: TextStyle(color: _color()),
    );
  }
}
