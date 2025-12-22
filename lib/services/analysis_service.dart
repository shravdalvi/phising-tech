class AnalysisService {
  static Map<String, String> analyze(String message) {
    final text = message.toLowerCase();

    final bool hasUrl =
        text.contains('http://') || text.contains('https://') || text.contains('www.');

    final bool hasUrgencyWords = _containsAny(text, [
      'urgent',
      'immediately',
      'within 24 hours',
      'account blocked',
      'last warning',
      'final notice',
      'act now',
      'verify now',
      'suspend',
    ]);

    final bool hasAuthorityWords = _containsAny(text, [
      'bank',
      'upi',
      'kyc',
      'income tax',
      'government',
      'official',
      'customer care',
      'support team',
    ]);

    final bool hasOtpRequest = _containsAny(text, [
      'otp',
      'one time password',
      'verification code',
    ]);

    final String language = _detectLanguage(message);

    // -------------------------------
    // RISK SCORING LOGIC
    // -------------------------------

    int riskScore = 0;

    if (hasUrl) riskScore += 1;
    if (hasUrgencyWords) riskScore += 2;
    if (hasAuthorityWords) riskScore += 2;
    if (hasOtpRequest) riskScore += 3;

    // Regional language scams often target trust
    if (language != 'English') riskScore += 1;

    // -------------------------------
    // RISK CLASSIFICATION
    // -------------------------------

    if (riskScore <= 1) {
      return _result(
        risk: 'No Risk',
        language: language,
        tactic: 'None',
        explanation:
            'This message does not show common scam patterns such as urgency, impersonation, or sensitive data requests.',
      );
    }

    if (riskScore == 2) {
      return _result(
        risk: 'Low',
        language: language,
        tactic: 'Mild Persuasion',
        explanation:
            'The message contains mild persuasive language but does not strongly indicate malicious intent.',
      );
    }

    if (riskScore <= 4) {
      return _result(
        risk: 'Medium',
        language: language,
        tactic: 'Urgency / Authority',
        explanation:
            'This message uses urgency or authority cues commonly seen in scam attempts. Caution is advised.',
      );
    }

    if (riskScore <= 6) {
      return _result(
        risk: 'Potential Threat',
        language: language,
        tactic: 'Social Engineering',
        explanation:
            'The message shows multiple social engineering indicators such as urgency, impersonation, or suspicious links.',
      );
    }

    return _result(
      risk: 'High Risk',
      language: language,
      tactic: 'Phishing / Scam',
      explanation:
          'This message strongly resembles known scam or phishing attempts. Do not click links or share personal details.',
    );
  }

  // -------------------------------
  // HELPER FUNCTIONS
  // -------------------------------

  static bool _containsAny(String text, List<String> keywords) {
    return keywords.any((word) => text.contains(word));
  }

  static String _detectLanguage(String text) {
    // Devanagari (Hindi, Marathi, etc.)
    final devanagariRegex = RegExp(r'[ऀ-ॿ]');
    if (devanagariRegex.hasMatch(text)) {
      return 'Hindi / Regional (Devanagari)';
    }

    // Simple Hinglish heuristic
    if (_containsAny(text, ['hai', 'karna', 'aap', 'kripya', 'turant'])) {
      return 'Hinglish';
    }

    return 'English';
  }

  static Map<String, String> _result({
    required String risk,
    required String language,
    required String tactic,
    required String explanation,
  }) {
    return {
      'risk': risk,
      'language': language,
      'tactic': tactic,
      'explanation': explanation,
    };
  }
}

