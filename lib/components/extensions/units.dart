import 'package:jaspr/jaspr.dart';

extension UnitExtension on Unit {
  /// Defines an addition operation for two [Unit] objects,
  /// returning the sum of their numerical values as a [double].
  ///
  /// Example: (10.px + 5.px) would return 15.0.
  ///
  /// IMPORTANT: Due to Dart's extension method limitations for operators,
  /// you CANNOT use the `+` operator syntax directly (e.g., `10.px + 5.px`)
  /// unless the original `Unit` class itself defines `operator+`.
  ///
  /// To use this extension operator, you must explicitly call it:
  /// `UnitArithmetic(10.px) + 5.px`
  ///
  /// If you want to use the `+` syntax, `operator+` must be defined
  /// directly in the `Unit` class.
  double operator +(Unit other) {
    return double.parse(value) + double.parse(other.value);
  }

  double operator -(Unit other) {
    return double.parse(value) - double.parse(other.value);
  }

  double operator *(double factor) {
    return double.parse(value) * factor;
  }

  double operator /(double factor) {
    return double.parse(value) / factor;
  }

  /// The following method defines how to parse a Unit object
  /// from a String.
  static Unit parse(String cssValue) {
    final pxRegex = RegExp(r'^(\d+(?:\.\d+)?)px$');
    final percentRegex = RegExp(r'^(\d+(?:\.\d+)?)%$');
    final ptRegex = RegExp(r'^(\d+(?:\.\d+)?)pt$');
    final emRegex = RegExp(r'^(\d+(?:\.\d+)?)em$');
    final remRegex = RegExp(r'^(\d+(?:\.\d+)?)rem$');
    final vwRegex = RegExp(r'^(\d+(?:\.\d+)?)vw$');
    final vhRegex = RegExp(r'^(\d+(?:\.\d+)?)vh$');
    final variableRegex = RegExp(r'^var\((.+)\)$');

    Match? match;

    if ((match = pxRegex.firstMatch(cssValue)) != null) {
      return Unit.pixels(double.parse(match!.group(1)!));
    } else if ((match = percentRegex.firstMatch(cssValue)) != null) {
      return Unit.percent(double.parse(match!.group(1)!));
    } else if ((match = ptRegex.firstMatch(cssValue)) != null) {
      return Unit.points(double.parse(match!.group(1)!));
    } else if ((match = emRegex.firstMatch(cssValue)) != null) {
      return Unit.em(double.parse(match!.group(1)!));
    } else if ((match = remRegex.firstMatch(cssValue)) != null) {
      return Unit.rem(double.parse(match!.group(1)!));
    } else if ((match = variableRegex.firstMatch(cssValue)) != null) {
      return Unit.variable(match!.group(1)!);
    } else if ((match = ptRegex.firstMatch(cssValue)) != null) {
      return Unit.points(double.parse(match!.group(1)!));
    } else if ((match = vwRegex.firstMatch(cssValue)) != null) {
      return Unit.vw(double.parse(match!.group(1)!));
    } else if ((match = vhRegex.firstMatch(cssValue)) != null) {
      return Unit.vh(double.parse(match!.group(1)!));
    } else {
      // Assume it's a custom expression if it doesn't match known units
      switch (cssValue) {
        case '0':
          return Unit.zero;
        case 'auto':
          return Unit.auto;
        case 'max-content':
          return Unit.maxContent;
        case 'min-content':
          return Unit.minContent;
        case 'fit-content':
          return Unit.fitContent;
        case 'inherit':
          return Unit.inherit;
        case 'initial':
          return Unit.initial;
        case 'revert':
          return Unit.revert;
        case 'revert-layer':
          return Unit.revertLayer;
        case 'unset':
          return Unit.unset;
      }
      return Unit.expression(cssValue);
    }
  }
}
