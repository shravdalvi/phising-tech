import 'package:flutter/material.dart';
import '../services/analysis_service.dart';
import '../services/stats_service.dart';

class DetectionResultScreen extends StatelessWidget {
  final String scannedText;

  const DetectionResultScreen({
    super.key,
    required this.scannedText,
  });

  @override
  Widget build(BuildContext context) {
    final result = AnalysisService.analyze(scannedText);

    final bool isHigh = result.risk == 'High';
    final bool isMedium = result.risk == 'Medium';

    // 🔑 RECORD STATISTICS (once per scan)
    StatsService.recordScan(
  riskLevel: result.risk,
  tactic: result.tactic,
);


    return Scaffold(
      backgroundColor: const Color(0xFF0A1020),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detection Result",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _statusCard(result, isHigh, isMedium),
            const SizedBox(height: 18),
            _analyzedText(scannedText),
            const SizedBox(height: 18),
            _threatAnalysis(result),
            const SizedBox(height: 18),
            _threatIndicators(result.indicators),
            const SizedBox(height: 18),
            _howDetected(result.explanation),
            const SizedBox(height: 18),
            _recommendedActions(),
            const SizedBox(height: 28),
            _footer(),
          ],
        ),
      ),
    );
  }

  // ================= STATUS CARD =================

  Widget _statusCard(
      AnalysisResult r, bool high, bool medium) {
    final Color accentColor =
        high ? Colors.redAccent : medium ? Colors.orange : Colors.cyan;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: high
              ? [const Color(0xFF4A1324), const Color(0xFF1A0B14)]
              : medium
                  ? [const Color(0xFF4A3A13), const Color(0xFF1A160B)]
                  : [const Color(0xFF13324A), const Color(0xFF0B1A2A)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withOpacity(0.2),
            ),
            child: Icon(
              high
                  ? Icons.close
                  : medium
                      ? Icons.warning
                      : Icons.check,
              color: accentColor,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            high
                ? "Dangerous"
                : medium
                    ? "Suspicious"
                    : "No Immediate Threat",
            style: TextStyle(
              color: accentColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            r.explanation,
            textAlign: TextAlign.center,
            style:
                const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _metric(
                "Risk Score",
                "${r.riskScore} / 100",
                accentColor,
              ),
              const SizedBox(width: 14),
              _metric(
                "Confidence",
                "${r.confidence}%",
                accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================

  Widget _metric(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF111A2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(color: Colors.white60)),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _analyzedText(String text) {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Analyzed Content",
              style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 8),
          Text(text,
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _threatAnalysis(AnalysisResult r) {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Threat Analysis",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 12),
          _row("Attack Type", r.tactic),
          _row("Detected Language", r.language),
          _row("Risk Level", r.risk),
        ],
      ),
    );
  }

  Widget _row(String a, String b) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(a, style: const TextStyle(color: Colors.white60)),
        Text(
          b,
          style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _threatIndicators(List<String> list) {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Threat Indicators",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 14),
          ...list.map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1020),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.close,
                      color: Colors.redAccent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(e,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _howDetected(String text) {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("How we detected this",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 12),
          Text(text,
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _recommendedActions() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Recommended Actions",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.block, color: Colors.cyan),
            title: Text("Do not click or visit this link",
                style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.flag, color: Colors.cyan),
            title: Text("Report this phishing attempt",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shield, color: Colors.cyan, size: 16),
        SizedBox(width: 6),
        Text(
          "Protected by PhishGuard",
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  Widget _sectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}


