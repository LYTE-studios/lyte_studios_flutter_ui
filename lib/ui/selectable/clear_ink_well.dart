import 'package:flutter/material.dart';

class ClearInkWell extends StatelessWidget {
  final Widget child;

  const ClearInkWell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateColor.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: child,
    );
  }
}
