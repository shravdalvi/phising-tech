import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoScan = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // ===== HEADER =====
            Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon:
                      const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Expanded(
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),

            const SizedBox(height: 12),

            // ===== SCROLLABLE CONTENT =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    _sectionTitle("Security"),
                    _switchTile(
                      'Auto Scan',
                      'Automatically scan links',
                      autoScan,
                      (v) => setState(() => autoScan = v),
                    ),
                    _switchTile(
                      'Notifications',
                      'Threat alerts',
                      notifications,
                      (v) => setState(() => notifications = v),
                    ),

                    const SizedBox(height: 24),

                    _sectionTitle("Account"),
                    _actionTile(
                      icon: Icons.person,
                      title: "Edit Profile",
                      subtitle: "Update personal details",
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfileScreen(),
                          ),
                        );
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: 24),

                    _sectionTitle("About"),
                    _actionTile(
                      icon: Icons.privacy_tip,
                      title: "Privacy Policy",
                      subtitle: "How we handle your data",
                      onTap: () => _simplePage(
                        context,
                        "Privacy Policy",
                        "PhishGuard respects your privacy. No personal data is sold or misused.",
                      ),
                    ),
                    _actionTile(
                      icon: Icons.info_outline,
                      title: "About PhishGuard",
                      subtitle: "App version & details",
                      onTap: () => _simplePage(
                        context,
                        "About PhishGuard",
                        "PhishGuard helps detect phishing and scam attempts.",
                      ),
                    ),

                    const SizedBox(height: 24),

                    _actionTile(
                      icon: Icons.logout,
                      title: "Log Out",
                      subtitle: "Sign out of your account",
                      isDestructive: true,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (_) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== UI HELPERS =====

  Widget _sectionTitle(String title) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _switchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return _card(
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.cyan,
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return _card(
      GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon,
                color:
                    isDestructive ? Colors.redAccent : Colors.cyan),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: isDestructive
                            ? Colors.redAccent
                            : Colors.white,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Colors.white38),
          ],
        ),
      ),
    );
  }

  Widget _card(Widget child) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0f172a),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }

  void _simplePage(BuildContext context, String title, String body) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xFF020617),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(body,
                style:
                    const TextStyle(color: Colors.white70)),
          ),
        ),
      ),
    );
  }
}

