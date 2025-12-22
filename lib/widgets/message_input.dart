import 'package:flutter/material.dart';
import '../core/constant.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  const MessageInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: AppConstants.inputHint,
      ),
    );
  }
}
