import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Result'),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // 🔴 DANGEROUS CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.red.shade900, Colors.red.shade400],
                ),
              ),
              child: Column(
                children: const [
                  Icon(Icons.close, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Dangerous',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a confirmed phishing attempt.\nDo not proceed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📊 RISK SCORE
            Row(
              children: [
                _infoCard('Risk Score', '94 / 100', Colors.red),
                const SizedBox(width: 12),
                _infoCard('Confidence', '98 %', Colors.cyan),
              ],
            ),

            const SizedBox(height: 20),

            // 🔍 ANALYZED URL
            _sectionCard(
              title: 'Analyzed URL',
              child: const Text(
                'malicious-banking-login.com/secure/account',
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 20),

            // 🛡️ THREAT ANALYSIS
            _sectionCard(
              title: 'Threat Analysis',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Attack Type', style: TextStyle(color: Colors.white54)),
                  SizedBox(height: 4),
                  Text(
                    'Banking Phishing',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ⚠️ THREAT INDICATORS
            _sectionCard(
              title: 'Threat Indicators',
              child: Column(
                children: const [
                  _Indicator(text: 'Suspicious domain'),
                  _Indicator(text: 'SSL certificate invalid'),
                  _Indicator(text: 'Known phishing pattern'),
                  _Indicator(text: 'Mimics legitimate site'),
                  _Indicator(text: 'Requests sensitive data'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ℹ️ HOW WE DETECTED THIS
            _sectionCard(
              title: 'How we detected this',
              child: const Text(
                'Our AI analyzed the URL structure, SSL certificate, '
                'domain age, and phishing patterns. The site attempts '
                'to impersonate a legitimate banking portal.',
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ RECOMMENDED ACTIONS
            _sectionCard(
              title: 'Recommended Actions',
              child: Column(
                children: const [
                  _ActionTile('Do not click or visit this link'),
                  _ActionTile('Report this phishing attempt'),
                  _ActionTile('Warn others who received this'),
                  _ActionTile('Mark sender as spam'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                'Protected by PhishGuard',
                style: TextStyle(color: Colors.white38),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black26,
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white54)),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// 🔹 INDICATOR CHIP
class _Indicator extends StatelessWidget {
  final String text;
  const _Indicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.redAccent, size: 18),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// 🔹 ACTION TILE
class _ActionTile extends StatelessWidget {
  final String text;
  const _ActionTile(this.text);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_right, color: Colors.cyan),
      title: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
