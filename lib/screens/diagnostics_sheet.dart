import 'dart:math';
import 'package:flutter/material.dart';

class DiagnosticsSheet extends StatefulWidget {
  const DiagnosticsSheet({super.key});

  @override
  State<DiagnosticsSheet> createState() => _DiagnosticsSheetState();
}

class _DiagnosticsSheetState extends State<DiagnosticsSheet> {
  final Random _rand = Random();
  int step = 0;

  late List<_DiagItem> items;
  bool completed = false;
  int healthScore = 0;

  @override
  void initState() {
    super.initState();

    items = [
      _DiagItem("Protection engine", _randomStatus()),
      _DiagItem("Link scanner", _randomStatus()),
      _DiagItem("Threat database", _randomStatus()),
      _DiagItem("System integrity", _randomStatus()),
    ];

    _runScan();
  }

  void _runScan() async {
    for (int i = 0; i < items.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => step = i + 1);
    }

    healthScore = items
        .map((e) => e.ok ? 25 : 15)
        .reduce((a, b) => a + b);

    setState(() => completed = true);
  }

  bool _randomStatus() => _rand.nextInt(10) > 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Running Diagnostics",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 16),

          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;

            if (i >= step) {
              return _pending(item.title);
            } else {
              return _result(item.title, item.ok);
            }
          }),

          const SizedBox(height: 20),

          if (!completed)
            const Center(
              child: CircularProgressIndicator(color: Colors.cyan),
            )
          else ...[
            Text(
              "System Health: $healthScore%",
              style: TextStyle(
                color: healthScore > 80
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _pending(String text) {
    return ListTile(
      leading: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      title: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _result(String text, bool ok) {
    return ListTile(
      leading: Icon(
        ok ? Icons.check_circle : Icons.warning,
        color: ok ? Colors.green : Colors.orange,
      ),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        ok ? "Operational" : "Needs attention",
        style: const TextStyle(color: Colors.white38),
      ),
    );
  }
}

class _DiagItem {
  final String title;
  final bool ok;
  _DiagItem(this.title, this.ok);
}
