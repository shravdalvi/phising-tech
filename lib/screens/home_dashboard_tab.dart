import 'package:flutter/material.dart';
import 'detection_result_screen.dart';
import 'report_phish_sheet.dart';
import 'diagnostics_sheet.dart';

class HomeDashboardTab extends StatefulWidget {
  const HomeDashboardTab({super.key});

  @override
  State<HomeDashboardTab> createState() => _HomeDashboardTabState();
}

class _HomeDashboardTabState extends State<HomeDashboardTab> {
  bool isProtectionActive = true;
  final TextEditingController _scanController = TextEditingController();

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Welcome back",
                          style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text(
                        "Security Dashboard",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyan.withOpacity(0.15),
                    ),
                    child: const Icon(Icons.shield, color: Colors.cyan),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // ===== PROTECTION STATUS =====
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F3C6E), Color(0xFF081A3A)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Protection Status",
                            style:
                                TextStyle(color: Colors.cyanAccent)),
                        const SizedBox(height: 6),
                        Text(
                          isProtectionActive
                              ? "You are protected"
                              : "Protection disabled",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: isProtectionActive
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isProtectionActive
                                  ? "Active"
                                  : "Inactive",
                              style: const TextStyle(
                                  color: Colors.white70),
                            ),
                          ],
                        )
                      ],
                    ),
                    Switch(
                      value: isProtectionActive,
                      activeColor: Colors.cyan,
                      onChanged: (v) =>
                          setState(() => isProtectionActive = v),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== QUICK SCAN =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B132B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Scan",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _scanController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText:
                            "Paste link or message to scan",
                        hintStyle:
                            const TextStyle(color: Colors.white38),
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.white38),
                        filled: true,
                        fillColor:
                            const Color(0xFF050B1E),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14),
                        ),
                        onPressed: () {
                          final text =
                              _scanController.text.trim();

                          if (text.length < 8) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please enter a valid message or link to scan",
                                ),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetectionResultScreen(
                                scannedText: text,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Scan Now",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== QUICK ACTIONS =====
              Row(
                children: [
                  _actionCard(
                    icon: Icons.report,
                    title: "Report Phish",
                    subtitle: "Help community",
                    color: Colors.redAccent,
                    onTap: () => _openReport(context),
                  ),
                  const SizedBox(width: 12),
                  _actionCard(
                    icon: Icons.security,
                    title: "Run Diagnostics",
                    subtitle: "System check",
                    color: Colors.cyan,
                    onTap: () => _openDiagnostics(context),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ===== RECENT ACTIVITY =====
              const Text(
                "Recent Activity",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _activity(
                  "Phishing Link",
                  "malicious-site.com",
                  "HIGH",
                  Colors.red),
              _activity(
                  "Suspicious Email",
                  "unknown@xyz.com",
                  "MEDIUM",
                  Colors.orange),
              _activity(
                  "Safe Link",
                  "google.com",
                  "LOW",
                  Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  // ===== HELPERS =====

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0B132B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(title,
                  style: const TextStyle(color: Colors.white)),
              Text(subtitle,
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activity(
      String title, String sub, String lvl, Color c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B132B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              Text(sub,
                  style:
                      const TextStyle(color: Colors.white38)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: c.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(lvl,
                style:
                    TextStyle(color: c, fontSize: 12)),
          )
        ],
      ),
    );
  }

  void _openReport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const ReportPhishSheet(),
    );
  }

  void _openDiagnostics(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const DiagnosticsSheet(),
    );
  }
}

