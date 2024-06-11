import 'package:flutter/material.dart';

// This class can stay private to this package

/// Extension for turning hexadecimals into a color
extension HexColor on Color {
  /// String hex -> Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');

    buffer.write(hexString.replaceFirst('#', ''));

    return Color(
      int.parse(
        buffer.toString(),
        radix: 16,
      ),
    );
  }

  /// Color -> String hex
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
