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

    int riskScore = 0;

    if (hasUrl) riskScore += 1;
    if (hasUrgencyWords) riskScore += 2;
    if (hasAuthorityWords) riskScore += 2;
    if (hasOtpRequest) riskScore += 3;

    if (language != 'English') riskScore += 1;

    if (riskScore <= 1) {
      return _result(
        risk: 'No Risk',
        language: language,
        tactic: 'None',
        explanation:
            'This message does not show common scam indicators such as urgency, impersonation, or sensitive data requests.',
      );
    }

    if (riskScore == 2) {
      return _result(
        risk: 'Low',
        language: language,
        tactic: 'Mild Persuasion',
        explanation:
            'The message contains some persuasive language but does not strongly indicate malicious intent.',
      );
    }

    if (riskScore <= 4) {
      return _result(
        risk: 'Medium',
        language: language,
        tactic: 'Urgency / Authority',
        explanation:
            'This message uses urgency or authority cues commonly seen in scam attempts.',
      );
    }

    if (riskScore <= 6) {
      return _result(
        risk: 'Potential Threat',
        language: language,
        tactic: 'Social Engineering',
        explanation:
            'Multiple social engineering indicators are present, including urgency, impersonation, or suspicious links.',
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

  // -----------------------
  // Helper methods
  // -----------------------

  static bool _containsAny(String text, List<String> keywords) {
    return keywords.any((word) => text.contains(word));
  }

  static String _detectLanguage(String text) {
    if (RegExp(r'[ऀ-ॿ]').hasMatch(text)) {
      return 'Hindi / Marathi (Devanagari)';
    }
    if (RegExp(r'[அ-௿]').hasMatch(text)) {
      return 'Tamil';
    }
    if (RegExp(r'[ఀ-౿]').hasMatch(text)) {
      return 'Telugu';
    }
    if (RegExp(r'[ಀ-೿]').hasMatch(text)) {
      return 'Kannada';
    }
    if (RegExp(r'[অ-৿]').hasMatch(text)) {
      return 'Bengali';
    }
    if (RegExp(r'[ਗ-੿]').hasMatch(text)) {
      return 'Punjabi (Gurmukhi)';
    }
    if (RegExp(r'[઀-૿]').hasMatch(text)) {
      return 'Gujarati';
    }

    if (_containsAny(text.toLowerCase(), [
      'hai',
      'karna',
      'aap',
      'kripya',
      'turant',
    ])) {
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


