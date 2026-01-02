import 'dart:collection';

class StatsService {
  // ================= BASIC COUNTS =================

  static int totalScans = 0;
  static int threatsDetected = 0;
  static int safeScans = 0;

  // ================= RISK LEVEL COUNTS =================

  static int highRiskCount = 0;
  static int mediumRiskCount = 0;
  static int lowRiskCount = 0;

  // ================= THREAT TYPE COUNTS =================

  static int phishingCount = 0;
  static int maliciousLinkCount = 0;
  static int fakeLoginCount = 0;
  static int otherThreatCount = 0;

  // ================= TARGETED APPS =================

  static final Map<String, int> attackedApps = {
    'WhatsApp': 0,
    'Gmail': 0,
    'Chrome': 0,
    'Facebook': 0,
    'Instagram': 0,
  };

  // ================= WEEKLY HISTORY =================
  // Key: weekday index (0–6), Value: scans count
  static final LinkedHashMap<int, int> weeklyScans =
      LinkedHashMap<int, int>.fromIterable(
    List.generate(7, (i) => i),
    key: (e) => e as int,
    value: (_) => 0,
  );

  // ================= PUBLIC API =================

  static void recordScan({
    required String riskLevel,
    required String tactic,
    String? targetedApp,
  }) {
    totalScans++;

    _updateWeeklyHistory();

    // ---------- Risk level ----------
    switch (riskLevel) {
      case 'High':
        highRiskCount++;
        threatsDetected++;
        break;
      case 'Medium':
        mediumRiskCount++;
        threatsDetected++;
        break;
      default:
        lowRiskCount++;
        safeScans++;
    }

    // ---------- Threat type ----------
    if (tactic.contains('Phishing')) {
      phishingCount++;
    } else if (tactic.contains('Link')) {
      maliciousLinkCount++;
    } else if (tactic.contains('Login')) {
      fakeLoginCount++;
    } else {
      otherThreatCount++;
    }

    // ---------- Targeted app ----------
    if (targetedApp != null &&
        attackedApps.containsKey(targetedApp)) {
      attackedApps[targetedApp] =
          attackedApps[targetedApp]! + 1;
    }
  }

  // ================= DERIVED METRICS =================

  static double get protectionRate {
    if (totalScans == 0) return 100;
    return (safeScans / totalScans) * 100;
  }

  static int get totalThreats =>
      phishingCount +
      maliciousLinkCount +
      fakeLoginCount +
      otherThreatCount;

  // ================= INTERNAL HELPERS =================

  static void _updateWeeklyHistory() {
    final int today =
        DateTime.now().weekday % 7; // 0–6

    weeklyScans.update(today, (v) => v + 1);

    // Keep map size stable (last 7 days)
    if (weeklyScans.length > 7) {
      weeklyScans.remove(weeklyScans.keys.first);
    }
  }

  // ================= RESET (OPTIONAL FOR TESTING) =================

  static void reset() {
    totalScans = 0;
    threatsDetected = 0;
    safeScans = 0;

    highRiskCount = 0;
    mediumRiskCount = 0;
    lowRiskCount = 0;

    phishingCount = 0;
    maliciousLinkCount = 0;
    fakeLoginCount = 0;
    otherThreatCount = 0;

    attackedApps.updateAll((key, value) => 0);
    weeklyScans.updateAll((key, value) => 0);
  }
}
