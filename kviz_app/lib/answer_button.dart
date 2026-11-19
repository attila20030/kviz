import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
    this.isDisabled = false,
  });

  final String answerText;
  final void Function() onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 31, 1, 95),
        disabledBackgroundColor: const Color.fromARGB(100, 31, 1, 95),
        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white38,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
