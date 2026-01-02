import 'package:flutter/material.dart';

class ReportPhishSheet extends StatefulWidget {
  const ReportPhishSheet({super.key});

  @override
  State<ReportPhishSheet> createState() => _ReportPhishSheetState();
}

class _ReportPhishSheetState extends State<ReportPhishSheet> {
  String source = 'SMS';
  String type = 'Phishing';
  bool submitted = false;

  final TextEditingController content = TextEditingController();
  final TextEditingController notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (submitted) {
      return _success();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Report a Threat",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),

            _section("Threat Type", [
              "Phishing",
              "Scam",
              "Impersonation",
              "Malware",
            ], type, (v) => setState(() => type = v)),

            _section("Source", [
              "SMS",
              "Email",
              "Website",
              "App",
            ], source, (v) => setState(() => source = v)),

            const SizedBox(height: 12),

            _input(
              controller: content,
              hint: "Paste the suspicious message or link",
              maxLines: 3,
            ),

            const SizedBox(height: 12),

            _input(
              controller: notes,
              hint: "Additional notes (optional)",
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => submitted = true),
                child: const Text("Submit Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<String> items, String selected,
      Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: items.map((e) {
            final active = e == selected;
            return ChoiceChip(
              label: Text(e),
              selected: active,
              onSelected: (_) => onSelect(e),
              selectedColor: Colors.cyan,
              backgroundColor: const Color(0xFF0B132B),
              labelStyle: TextStyle(
                color: active ? Colors.black : Colors.white,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF0B132B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _success() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, color: Colors.green, size: 48),
          SizedBox(height: 12),
          Text(
            "Report Submitted",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 6),
          Text(
            "Thank you for helping keep the community safe.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

