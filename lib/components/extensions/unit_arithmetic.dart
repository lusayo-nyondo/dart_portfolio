import 'package:jaspr/jaspr.dart';

extension UnitArithmetic on Unit {
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
}
