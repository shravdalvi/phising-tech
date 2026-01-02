import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'upgrade_pro_screen.dart';
import 'settings_screen.dart';
import '../services/user_profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ===== USER CARD =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B132B),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFF00C2FF),
                      child: Icon(Icons.person,
                          color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserProfileService.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            UserProfileService.email,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ===== OPTIONS =====
              _tile(
                context,
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                  setState(() {}); // 🔑 refresh after edit
                },
              ),

              _tile(
                context,
                icon: Icons.settings,
                title: "Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(
                        onBack: () => Navigator.pop(context),
                      ),
                    ),
                  );
                },
              ),

              _tile(
                context,
                icon: Icons.workspace_premium,
                title: "Upgrade to Pro",
                gradient: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UpgradeProScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              const Center(
                child: Text(
                  "PhishGuard Version 2.1.0\n© 2025 PhishGuard Security",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== TILE =====
  static Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool gradient = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: gradient
              ? const LinearGradient(
                  colors: [Color(0xFF3A0CA3), Color(0xFF7209B7)],
                )
              : null,
          color: gradient ? null : const Color(0xFF0B132B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}


