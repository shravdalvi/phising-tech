import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B1E),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== HEADER =====
              const Text(
                "Reports",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Activity timeline",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),

              // ===== FILTER CHIPS (HORIZONTAL SCROLL) =====
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _FilterChip(title: "All", selected: true),
                    _FilterChip(title: "High Risk"),
                    _FilterChip(title: "Blocked"),
                    _FilterChip(title: "This week"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== REPORT ITEMS =====
              _reportCard(
                icon: Icons.email,
                title: "Phishing Email",
                time: "Today, 10:34 AM",
                source: "unknown@fake-bank.com",
                risk: "HIGH",
                riskColor: Colors.redAccent,
              ),

              _reportCard(
                icon: Icons.login,
                title: "Fake Login Page",
                time: "Today, 08:15 AM",
                source: "secure-login-verify.xyz",
                risk: "HIGH",
                riskColor: Colors.redAccent,
              ),

              _reportCard(
                icon: Icons.link,
                title: "Suspicious Link",
                time: "Yesterday, 6:42 PM",
                source: "bit.ly/3xK92jF",
                risk: "MEDIUM",
                riskColor: Colors.orangeAccent,
              ),

              _reportCard(
                icon: Icons.sms_failed,
                title: "Scam Message",
                time: "Yesterday, 2:18 PM",
                source: "+1 (555) 123-4567",
                risk: "HIGH",
                riskColor: Colors.redAccent,
              ),

              _reportCard(
                icon: Icons.ad_units,
                title: "Malicious Ad",
                time: "2 days ago",
                source: "ads.tracker-network.com",
                risk: "MEDIUM",
                riskColor: Colors.orangeAccent,
              ),

              _reportCard(
                icon: Icons.verified,
                title: "Safe Link",
                time: "2 days ago",
                source: "github.com/security",
                risk: "LOW",
                riskColor: Colors.greenAccent,
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // ===== REPORT CARD =====
  static Widget _reportCard({
    required IconData icon,
    required String title,
    required String time,
    required String source,
    required String risk,
    required Color riskColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B132B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // TITLE ROW
          Row(
            children: [
              Icon(icon, color: riskColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  risk,
                  style: TextStyle(
                    color: riskColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // TIME
          Text(
            time,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),

          const SizedBox(height: 10),

          // SOURCE BOX
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF111A2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Source:",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  source,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== FILTER CHIP =====
class _FilterChip extends StatelessWidget {
  final String title;
  final bool selected;

  const _FilterChip({
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.cyanAccent : const Color(0xFF111A2C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
