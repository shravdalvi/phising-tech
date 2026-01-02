import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalScans = StatsService.totalScans;
    final int threatsBlocked = StatsService.threatsDetected;
    final double protectionRate = StatsService.protectionRate;

    // ---- Derived breakdown (until backend exists) ----
    final int phishing = (threatsBlocked * 0.6).round();
    final int maliciousLinks = (threatsBlocked * 0.27).round();
    final int fakeLogins =
        threatsBlocked - phishing - maliciousLinks;

    return Scaffold(
      backgroundColor: const Color(0xFF050B1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== HEADER =====
              const Text(
                "Analytics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your security insights",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              // ===== TOP STATS CARDS =====
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.shield,
                      title: threatsBlocked.toString(),
                      subtitle: "Threats Blocked",
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F4C75), Color(0xFF3282B8)],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      icon: Icons.trending_up,
                      title:
                          "${protectionRate.toStringAsFixed(1)}%",
                      subtitle: "Protection Rate",
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0B8457), Color(0xFF2ECC71)],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== WEEKLY ACTIVITY =====
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Weekly Activity",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Last 7 days",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        "Activity chart placeholder",
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== THREAT BREAKDOWN =====
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Threat Breakdown",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _progressRow(
                      label: "Phishing Attempts",
                      value: phishing,
                      percent: threatsBlocked == 0
                          ? 0
                          : phishing / threatsBlocked,
                      color: Colors.redAccent,
                    ),
                    _progressRow(
                      label: "Malicious Links",
                      value: maliciousLinks,
                      percent: threatsBlocked == 0
                          ? 0
                          : maliciousLinks / threatsBlocked,
                      color: Colors.orangeAccent,
                    ),
                    _progressRow(
                      label: "Fake Login Pages",
                      value: fakeLogins,
                      percent: threatsBlocked == 0
                          ? 0
                          : fakeLogins / threatsBlocked,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== MOST ATTACKED APPS =====
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Most Attacked Apps",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _appTile("WhatsApp",
                        (phishing * 0.35).round()),
                    _appTile(
                        "Gmail", (phishing * 0.28).round()),
                    _appTile(
                        "Chrome", (maliciousLinks * 0.6).round()),
                    _appTile(
                        "Facebook", (fakeLogins * 0.5).round()),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // ===== STAT CARD =====
  static Widget _statCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ===== SECTION CARD =====
  static Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B132B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  // ===== PROGRESS ROW =====
  static Widget _progressRow({
    required String label,
    required int value,
    required double percent,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style:
                      const TextStyle(color: Colors.white70)),
              Text(value.toString(),
                  style:
                      const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.white12,
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  // ===== APP TILE =====
  static Widget _appTile(String name, int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111A2C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white12,
            child: Icon(Icons.apps, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.warning,
              color: Colors.amber, size: 18),
        ],
      ),
    );
  }
}
