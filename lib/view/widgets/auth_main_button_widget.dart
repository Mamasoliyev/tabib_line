import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.color,
    required this.text,
    required this.textColor,
    this.rasm,
    required this.onPressed,
  });

  final Color color;
  final String text;
  final Color textColor;
  final SvgPicture? rasm;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (rasm != null) rasm!,
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: textColor, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
