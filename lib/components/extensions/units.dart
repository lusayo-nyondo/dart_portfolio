import 'package:jaspr/jaspr.dart';

extension UnitExtension on Unit {
  /// Defines an addition operation for two [Unit] objects,
  /// returning the sum of their numerical values as a [double].
  ///
  /// Example: (10.px + 5.px) would return 15.0.
  ///
  /// The reason why it returns a [double] is because Jaspr's [Unit]
  /// class API doesn't expose the subclasses of [Unit]
  /// that could tell us what kind specific kind of [Unit] we're
  /// working with i.e. pixel, rem, em, etc.
  ///
  double operator +(Unit other) {
    return double.parse(value) + double.parse(other.value);
  }

  /// Defines a subtraction operation for two [Unit] objects,
  /// returning the difference of their numerical values as a [double].
  ///
  /// Example: (10.px - 5.px) would return 5.0.
  ///
  /// The reason why it returns a [double] is because Jaspr's [Unit]
  /// class API doesn't expose the subclasses of [Unit]
  /// that could tell us what kind specific kind of [Unit] we're
  /// working with i.e. pixel, rem, em, etc.
  ///
  double operator -(Unit other) {
    return double.parse(value) - double.parse(other.value);
  }

  /// Defines a multiplication operation between a [Unit] object,
  /// and a [double], returning the result as a [double].
  ///
  /// Example: (10.px * 2) would return 20.0.
  ///
  /// The reason why it returns a [double] is because Jaspr's [Unit]
  /// class API doesn't expose the subclasses of [Unit]
  /// that could tell us what kind specific kind of [Unit] we're
  /// working with i.e. pixel, rem, em, etc.
  ///
  double operator *(double factor) {
    return double.parse(value) * factor;
  }

  /// Defines a division operation between a [Unit] object,
  /// and a [double], returning the result as a [double].
  ///
  /// Example: (10.px * 2) would return 20.0.
  ///
  /// The reason why it returns a [double] is because Jaspr's [Unit]
  /// class API doesn't expose the subclasses of [Unit]
  /// that could tell us what kind specific kind of [Unit] we're
  /// working with i.e. pixel, rem, em, etc.
  ///
  double operator /(double factor) {
    return double.parse(value) / factor;
  }

  /// The following method defines how to parse a [Unit] object
  /// from an arbitrary [String].
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
