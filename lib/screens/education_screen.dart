import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn About Scams')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '• Urgency scams\n'
          '• Fake KYC updates\n'
          '• Bank impersonation\n'
          '• OTP fraud\n\n'
          'Always verify before acting.',
        ),
      ),
    );
  }
}
