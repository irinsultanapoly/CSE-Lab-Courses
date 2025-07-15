import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final double top;
  final double left;
  final double elevation;
  final double size;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.top = 24,
    this.left = 16,
    this.elevation = 3,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultIconColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final defaultBackgroundColor = theme.cardColor;

    return Positioned(
      top: top,
      left: left,
      child: SafeArea(
        child: Material(
          color: backgroundColor ?? defaultBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          elevation: elevation,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: size,
                color: iconColor ?? defaultIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
