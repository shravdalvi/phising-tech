import 'package:flutter/material.dart';

enum RiskSensitivity { low, medium, high }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool alertsEnabled = true;
  bool crowdSourceEnabled = true;
  RiskSensitivity sensitivity = RiskSensitivity.medium;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          // Alerts toggle
          SwitchListTile(
            title: const Text('Enable Scam Alerts'),
            subtitle: const Text('Show warnings for risky messages'),
            value: alertsEnabled,
            onChanged: (value) {
              setState(() => alertsEnabled = value);
            },
          ),

          // Crowd-source toggle
          SwitchListTile(
            title: const Text('Crowd-source Scam Reports'),
            subtitle: const Text(
                'Help improve detection by sharing anonymized patterns'),
            value: crowdSourceEnabled,
            onChanged: (value) {
              setState(() => crowdSourceEnabled = value);
            },
          ),

          const Divider(height: 32),

          // Risk Sensitivity
          Text(
            'Risk Sensitivity',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          RadioListTile<RiskSensitivity>(
            title: const Text('Low'),
            subtitle: const Text('Only flag very clear scams'),
            value: RiskSensitivity.low,
            groupValue: sensitivity,
            onChanged: (value) {
              setState(() => sensitivity = value!);
            },
          ),
          RadioListTile<RiskSensitivity>(
            title: const Text('Medium'),
            subtitle: const Text('Balanced detection (recommended)'),
            value: RiskSensitivity.medium,
            groupValue: sensitivity,
            onChanged: (value) {
              setState(() => sensitivity = value!);
            },
          ),
          RadioListTile<RiskSensitivity>(
            title: const Text('High'),
            subtitle: const Text('Flag even slightly suspicious messages'),
            value: RiskSensitivity.high,
            groupValue: sensitivity,
            onChanged: (value) {
              setState(() => sensitivity = value!);
            },
          ),

          const Divider(height: 32),

          // Language info
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language Detection'),
            subtitle: const Text(
              'Automatically detects English and major Indian languages',
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 0,
            color: Colors.black.withOpacity(0.04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Your data is analyzed locally or securely via AI. '
                'Messages are never stored without your consent.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

