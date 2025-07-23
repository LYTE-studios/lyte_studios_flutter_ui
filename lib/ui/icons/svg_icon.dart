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

  // Uses the raw SVG code instead of an asset
  final bool useRawCode;

  final BoxFit boxFit;

  const SvgIcon(
    this.icon, {
    super.key,
    this.color,
    this.size = 16,
    this.leaveUnaltered = false,
    this.useRawCode = false,
    this.boxFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (useRawCode) {
      return SvgPicture.string(
        icon,
        height: size,
        width: size,
        fit: boxFit,
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
