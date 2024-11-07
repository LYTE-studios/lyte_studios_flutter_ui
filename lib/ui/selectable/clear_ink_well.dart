import 'package:flutter/material.dart';

class ClearInkWell extends StatelessWidget {
  final Widget child;

  // This value is not nullable to prevent not clickable areas
  final Function() onTap;

  final Function()? onLongTap;

  final bool enabled;

  const ClearInkWell({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: enabled,
      onTap: !enabled ? null : onTap,
      onLongPress: onLongTap,
      overlayColor: WidgetStateColor.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: child,
    );
  }
}
