import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

/// Class for managing themes
class AppTheme {
  /// Gets a color from a hexadecimal string value
  static Color hexToColor(String hexValue) {
    // Uses the HexColor extension to create a Color
    return HexColor.fromHex(hexValue);
  }
}
