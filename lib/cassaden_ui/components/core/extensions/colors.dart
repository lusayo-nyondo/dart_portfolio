// Place this in a file outside the jaspr library, e.g., 'lib/extensions/color_extensions.dart'

import 'package:jaspr/jaspr.dart'; // Import the main Color abstract class

// --- Helper Functions for Color String Parsing ---

// Regex patterns for different CSS color formats
final _rgbaRegex =
    RegExp(r'rgba\((\d+),\s*(\d+),\s*(\d+),\s*([0-9]*\.?[0-9]+)\)');
final _rgbRegex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
final _hslaRegex =
    RegExp(r'hsla\((\d+),\s*(\d+)%,\s*(\d+)%,\s*([0-9]*\.?[0-9]+)\)');
final _hslRegex = RegExp(r'hsl\((\d+),\s*(\d+)%,\s*(\d+)%\)');
final _hexShortRegex = RegExp(r'^#([0-9a-fA-F]{3})$'); // #RGB
final _hexMediumRegex = RegExp(r'^#([0-9a-fA-F]{6})$'); // #RRGGBB
final _hexLongRegex = RegExp(r'^#([0-9a-fA-F]{8})$'); // #RRGGBBAA

// Helper function to parse an integer from a regex match group
int? _parseIntGroup(Match match, int group) {
  final String? s = match.group(group);
  return s != null ? int.tryParse(s) : null;
}

// Minimal mapping for common named colors to their RGB values.
// A comprehensive solution would require mapping all CSS named colors.
// Note: This is an incomplete list and only for demonstration.
const Map<String, List<int>> _namedColorsRgb = {
  'black': [0, 0, 0],
  'white': [255, 255, 255],
  'red': [255, 0, 0],
  'green': [0, 128, 0],
  'blue': [0, 0, 255],
  'yellow': [255, 255, 0],
  'transparent': [0, 0, 0, 0], // Special case for transparent
};

// --- Color Extension Methods ---

extension ColorOpacityExtension on Color {
  /// Returns a new [Color] that matches this color, but with the given opacity.
  ///
  /// The [opacity] value must be a [double] between 0.0 (fully transparent) and 1.0 (fully opaque).
  ///
  /// This method attempts to parse the color's `value` (CSS string) to extract
  /// its components and then reconstructs it with the new opacity.
  ///
  /// **Limitations:**
  /// - Only common CSS color formats (RGB(A), HSL(A), hex codes) and a limited set
  ///   of CSS named colors are supported.
  /// - Colors defined by CSS variables (`Color.variable('...')`) or complex CSS
  ///   color functions (e.g., `linear-gradient()`, `color-mix()`) cannot be
  ///   parsed or modified by this extension. In such cases, the original color
  ///   will be returned unchanged.
  Color withOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0');

    final String normalizedValue = value.trim().toLowerCase();

    // 1. Try to parse RGBA format
    Match? match = _rgbaRegex.firstMatch(normalizedValue);
    if (match != null) {
      final r = _parseIntGroup(match, 1)!;
      final g = _parseIntGroup(match, 2)!;
      final b = _parseIntGroup(match, 3)!;
      return Color.rgba(r, g, b, opacity);
    }

    // 2. Try to parse RGB format (assume full opacity if no alpha in original)
    match = _rgbRegex.firstMatch(normalizedValue);
    if (match != null) {
      final r = _parseIntGroup(match, 1)!;
      final g = _parseIntGroup(match, 2)!;
      final b = _parseIntGroup(match, 3)!;
      return Color.rgba(r, g, b, opacity);
    }

    // 3. Try to parse HSLA format
    match = _hslaRegex.firstMatch(normalizedValue);
    if (match != null) {
      final h = _parseIntGroup(match, 1)!;
      final s = _parseIntGroup(match, 2)!;
      final l = _parseIntGroup(match, 3)!;
      return Color.hsla(h, s, l, opacity);
    }

    // 4. Try to parse HSL format (assume full opacity if no alpha in original)
    match = _hslRegex.firstMatch(normalizedValue);
    if (match != null) {
      final h = _parseIntGroup(match, 1)!;
      final s = _parseIntGroup(match, 2)!;
      final l = _parseIntGroup(match, 3)!;
      return Color.hsla(h, s, l, opacity);
    }

    // 5. Try to parse Hex formats
    Match? hexMatch;
    String? hexCode;

    hexMatch = _hexLongRegex.firstMatch(normalizedValue); // #RRGGBBAA
    if (hexMatch != null) {
      hexCode = hexMatch.group(1)!;
      // Original alpha is implied by AA, but we're setting a new opacity
      final int red = int.parse(hexCode.substring(0, 2), radix: 16);
      final int green = int.parse(hexCode.substring(2, 4), radix: 16);
      final int blue = int.parse(hexCode.substring(4, 6), radix: 16);
      return Color.rgba(red, green, blue, opacity);
    }

    hexMatch = _hexMediumRegex.firstMatch(normalizedValue); // #RRGGBB
    if (hexMatch != null) {
      hexCode = hexMatch.group(1)!;
      final int colorValue = int.parse(hexCode, radix: 16);
      final int red = (colorValue >> 16) & 0xFF;
      final int green = (colorValue >> 8) & 0xFF;
      final int blue = colorValue & 0xFF;
      return Color.rgba(
          red, green, blue, opacity); // Assume full original opacity
    }

    hexMatch = _hexShortRegex.firstMatch(normalizedValue); // #RGB
    if (hexMatch != null) {
      hexCode = hexMatch.group(1)!;
      final int red = int.parse('${hexCode[0]}${hexCode[0]}', radix: 16);
      final int green = int.parse('${hexCode[1]}${hexCode[1]}', radix: 16);
      final int blue = int.parse('${hexCode[2]}${hexCode[2]}', radix: 16);
      return Color.rgba(
          red, green, blue, opacity); // Assume full original opacity
    }

    // 6. Try to parse Named Colors
    if (_namedColorsRgb.containsKey(normalizedValue)) {
      final rgb = _namedColorsRgb[normalizedValue]!;
      if (rgb.length == 4) {
        // Handle "transparent" which has explicit alpha
        return Color.rgba(rgb[0], rgb[1], rgb[2], opacity);
      }
      return Color.rgba(rgb[0], rgb[1], rgb[2], opacity);
    }

    // 7. For CSS variables or other unparsable strings, return the original color.
    return this;
  }

  /// Returns a new [Color] that matches this color, but with the given alpha value.
  ///
  /// The [alpha] value must be an [int] between 0 (fully transparent) and 255 (fully opaque).
  /// This is equivalent to calling `withOpacity(alpha / 255.0)`.
  ///
  /// Refer to the `withOpacity` documentation for important limitations regarding
  /// parsing and unsupported color types.
  Color withAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255, 'Alpha must be between 0 and 255');
    return withOpacity(alpha / 255.0);
  }
}