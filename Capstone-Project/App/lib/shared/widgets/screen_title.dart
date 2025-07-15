import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? fontSize;

  const ScreenTitle({
    super.key,
    required this.title,
    this.textAlign = TextAlign.center,
    this.padding,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 32.0, bottom: 0),
      child: Text(
        title,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: color ?? AppTheme.primaryGreen,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
