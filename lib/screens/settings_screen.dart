import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool alertsEnabled = true;
  bool crowdSourceEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Settings',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Enable Scam Alerts'),
            value: alertsEnabled,
            onChanged: (v) => setState(() => alertsEnabled = v),
          ),
          SwitchListTile(
            title: const Text('Crowd-source Scam Reports'),
            value: crowdSourceEnabled,
            onChanged: (v) => setState(() => crowdSourceEnabled = v),
          ),
        ],
      ),
    );
  }
}

