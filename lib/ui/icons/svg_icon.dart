import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Icon widget using svg images
class SvgIcon extends StatelessWidget {
  /// The path for the icon
  final String icon;

  /// The text color for the icon
  final Color? color;

  /// Icon size
  final double size;

  /// Set this to true for colored icons
  final bool leaveUnaltered;

  const SvgIcon(
    this.icon, {
    super.key,
    this.color,
    this.size = 16,
    this.leaveUnaltered = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size,
      width: size,
      colorFilter: leaveUnaltered
          ? null
          : ColorFilter.mode(
              color ?? Theme.of(context).colorScheme.outline,
              BlendMode.srcIn,
            ),
      theme: SvgTheme(
        fontSize: size,
      ),
    );
  }
}
