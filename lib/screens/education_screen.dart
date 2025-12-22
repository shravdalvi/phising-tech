import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Learn About Scams',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Understand how scams work and how to protect yourself.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              _InfoCard(
                icon: Icons.warning_amber_outlined,
                title: 'Phishing Scams',
                content:
                    'Scammers impersonate trusted organizations like banks or government bodies to steal sensitive information such as passwords, OTPs, or card details.',
              ),

              _InfoCard(
                icon: Icons.language,
                title: 'Regional Language Scams',
                content:
                    'Many scams use local or mixed languages (e.g., Hinglish) to gain trust, especially targeting elderly or non-English speakers.',
              ),

              _InfoCard(
                icon: Icons.schedule,
                title: 'Urgency Tactics',
                content:
                    'Messages that pressure you to act quickly (e.g., “account will be blocked today”) are designed to bypass rational thinking.',
              ),

              _InfoCard(
                icon: Icons.link,
                title: 'Suspicious Links',
                content:
                    'Shortened or unfamiliar links often redirect users to fake websites that look real but steal credentials.',
              ),

              const SizedBox(height: 28),

              Text(
                'What You Should Do',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              _ActionTile(
                icon: Icons.cancel_outlined,
                text: 'Do not click suspicious links or download unknown files.',
              ),
              _ActionTile(
                icon: Icons.lock_outline,
                text: 'Never share OTPs, passwords, or banking details.',
              ),
              _ActionTile(
                icon: Icons.verified_user_outlined,
                text: 'Verify messages by contacting the organization directly.',
              ),
              _ActionTile(
                icon: Icons.report_outlined,
                text: 'Report scam messages to authorities or within the app.',
              ),

              const SizedBox(height: 32),

              Card(
                elevation: 0,
                color: Colors.black.withOpacity(0.04),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'VernacuGuard helps you analyze suspicious messages, '
                    'but your awareness is the strongest protection.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------
// Reusable Widgets
// ------------------

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ActionTile({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
