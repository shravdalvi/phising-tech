import 'package:flutter/material.dart';

class AnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final bool loading;

  const AnalyzeButton({
    super.key,
    required this.onPressed,
    required this.enabled,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled && !loading ? onPressed : null,
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Padding(
                padding: EdgeInsets.all(14),
                child: Text('Analyze Message'),
              ),
      ),
    );
  }
}


