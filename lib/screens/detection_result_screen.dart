import 'package:flutter/material.dart';

class DetectionResultScreen extends StatelessWidget {
  const DetectionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.stretch, // 🔑 IMPORTANT FIX
          children: [
            _dangerCard(),
            const SizedBox(height: 18),
            _analyzedUrl(), // ✅ FIXED
            const SizedBox(height: 18),
            _threatAnalysis(),
            const SizedBox(height: 18),
            _threatIndicators(),
            const SizedBox(height: 18),
            _howDetected(),
            const SizedBox(height: 18),
            _recommendedActions(),
            const SizedBox(height: 28),
            _footer(),
          ],
        ),
      ),
    );
  }

  // 🔴 DANGEROUS CARD
  Widget _dangerCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A1324), Color(0xFF1A0B14)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x33FF4D6D),
            ),
            child: const Icon(Icons.close, color: Colors.redAccent, size: 36),
          ),
          const SizedBox(height: 16),
          const Text(
            "Dangerous",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "This is a confirmed phishing attempt.\nDo not proceed!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _metric("Risk Score", "94 / 100", Colors.redAccent),
              const SizedBox(width: 14),
              _metric("Confidence", "98%", Colors.cyan),
            ],
          ),
        ],
      ),
    );
  }

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
            Text(title, style: const TextStyle(color: Colors.white60)),
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

  // 🔗 ANALYZED URL — PROPER LEFT ALIGN (FIXED)
  Widget _analyzedUrl() {
    return Container(
      width: double.infinity, // 🔑 forces full-width
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 🔑 LEFT ALIGN
        children: const [
          Text(
            "Analyzed URL",
            style: TextStyle(color: Colors.white60),
          ),
          SizedBox(height: 8),
          Text(
            "malicious-banking-login.com/secure/account",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // 🛡️ THREAT ANALYSIS
  Widget _threatAnalysis() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Threat Analysis",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Attack Type",
                  style: TextStyle(color: Colors.white60)),
              Text(
                "Banking Phishing",
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ⚠️ THREAT INDICATORS
  Widget _threatIndicators() {
    final indicators = [
      "Suspicious domain",
      "SSL certificate invalid",
      "Known phishing pattern",
      "Mimics legitimate site",
      "Requests sensitive data",
    ];

    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Threat Indicators",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 14),
          ...indicators.map(
            (text) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🤖 HOW DETECTED
  Widget _howDetected() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "How we detected this",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 12),
          Text(
            "Our AI-powered system analyzed the URL structure, SSL certificate, "
            "domain age, and compared it against known phishing patterns. "
            "The site attempts to mimic a legitimate banking portal to steal credentials.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ✅ ACTIONS
  Widget _recommendedActions() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Actions",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _actionTile(Icons.block, "Do not click or visit this link"),
          _actionTile(Icons.flag, "Report this phishing attempt"),
          _actionTile(Icons.share, "Warn others who received this"),
          _actionTile(Icons.mark_email_read, "Mark sender as spam"),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.cyan),
      title: Text(text, style: const TextStyle(color: Colors.white)),
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
