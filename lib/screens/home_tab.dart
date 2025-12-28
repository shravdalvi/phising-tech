import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF020B1F),
            Color(0xFF081A3A),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Welcome back",
                style: TextStyle(color: Colors.white70),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Security Dashboard",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.shield_outlined, color: Colors.cyan, size: 28),
                ],
              ),

              const SizedBox(height: 20),

              // Protection Status Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF003B64),
                      Color(0xFF001C3A),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Protection Status",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "You are protected",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.circle, color: Colors.green, size: 10),
                            SizedBox(width: 6),
                            Text("Active"),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan,
                      ),
                      child: const Icon(Icons.shield, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _activityCard(
                icon: Icons.cancel,
                title: "Phishing Link",
                subtitle: "malicious-site.com/login",
                time: "2 min ago",
                level: "HIGH",
                color: Colors.red,
              ),

              _activityCard(
                icon: Icons.warning_amber,
                title: "Suspicious Email",
                subtitle: "unknown-sender@xyz.com",
                time: "1 hour ago",
                level: "MEDIUM",
                color: Colors.orange,
              ),

              _activityCard(
                icon: Icons.check_circle,
                title: "Safe Link",
                subtitle: "google.com/search",
                time: "3 hours ago",
                level: "LOW",
                color: Colors.green,
              ),

              _activityCard(
                icon: Icons.block,
                title: "Blocked Scam",
                subtitle: "fake-payment.net",
                time: "5 hours ago",
                level: "HIGH",
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required String level,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
                Text(time, style: const TextStyle(color: Colors.white38)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(level, style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}
