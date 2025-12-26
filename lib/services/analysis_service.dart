class AnalysisResult {
  final String language;
  final String risk;
  final String tactic;
  final String explanation;

  AnalysisResult({
    required this.language,
    required this.risk,
    required this.tactic,
    required this.explanation,
  });
}

class AnalysisService {
  AnalysisResult analyze(String text) {
    final lower = text.toLowerCase();

    // ---------- LANGUAGE DETECTION (RULE-BASED) ----------
    String language = _detectLanguage(text);

    // ---------- SCAM TACTIC DETECTION ----------
    String tactic = _detectTactic(lower);

    // ---------- RISK LEVEL ----------
    String risk = _detectRisk(lower);

    // ---------- EXPLANATION ----------
    String explanation =
        'Detected $tactic patterns in $language language.';

    return AnalysisResult(
      language: language,
      risk: risk,
      tactic: tactic,
      explanation: explanation,
    );
  }

  // ---------------- HELPERS ----------------

  String _detectLanguage(String text) {
    if (RegExp(r'[ऀ-ॿ]').hasMatch(text)) return 'Hindi';
    if (RegExp(r'[அ-௺]').hasMatch(text)) return 'Tamil';
    if (RegExp(r'[ক-৿]').hasMatch(text)) return 'Bengali';
    if (RegExp(r'[అ-౿]').hasMatch(text)) return 'Telugu';
    return 'English / Hinglish';
  }

  String _detectTactic(String text) {
    if (text.contains('otp') ||
        text.contains('verify') ||
        text.contains('account')) {
      return 'Credential Harvesting';
    }

    if (text.contains('urgent') ||
        text.contains('immediately') ||
        text.contains('act now')) {
      return 'Urgency / Pressure';
    }

    if (text.contains('won') ||
        text.contains('lottery') ||
        text.contains('reward')) {
      return 'Prize / Lottery Scam';
    }

    if (text.contains('bank') ||
        text.contains('upi') ||
        text.contains('payment')) {
      return 'Financial Fraud';
    }

    return 'Unknown / Benign';
  }

  String _detectRisk(String text) {
    int score = 0;

    if (text.contains('otp')) score += 2;
    if (text.contains('urgent')) score += 2;
    if (text.contains('bank') || text.contains('upi')) score += 2;
    if (text.contains('click')) score += 1;

    if (score >= 5) return 'High';
    if (score >= 3) return 'Medium';
    return 'Low';
  }
}


