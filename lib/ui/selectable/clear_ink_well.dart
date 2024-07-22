import 'package:flutter/material.dart';

class ClearInkWell extends StatelessWidget {
  final Widget child;

  // This value is not nullable to prevent not clickable areas
  final Function() onTap;

  const ClearInkWell({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStateColor.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: child,
    );
  }
}
