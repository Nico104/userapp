import 'package:flutter/material.dart';

import '../pet_color/hex_color.dart';
import '../styles/text_styles.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    this.onTap,
    required this.label,
  });

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: HexColor("8F8FFF"),
          border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.16),
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Center(
            child: Text(
          label,
          style: loginButton,
        )),
      ),
    );
  }
}
