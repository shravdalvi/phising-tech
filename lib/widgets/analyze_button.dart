import 'package:flutter/material.dart';

class AnalyzeButton extends StatefulWidget {
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
  State<AnalyzeButton> createState() => _AnalyzeButtonState();
}

class _AnalyzeButtonState extends State<AnalyzeButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _pressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.enabled && !widget.loading
              ? () async {
                  setState(() => _pressed = true);
                  await Future.delayed(const Duration(milliseconds: 80));
                  setState(() => _pressed = false);
                  widget.onPressed();
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: widget.loading
                ? const SizedBox(
                    key: ValueKey('loader'),
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Analyze Message',
                    key: ValueKey('text'),
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }
}


