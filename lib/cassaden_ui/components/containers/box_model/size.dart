import 'package:jaspr/jaspr.dart';

/// An immutable 2D floating-point size.
///
/// Mimics Flutter's [Size] class.
class Size {
  /// The horizontal extent of this size.
  final Unit width;

  /// The vertical extent of this size.
  final Unit height;

  /// Creates a size with the given [width] and [height].
  const Size(this.width, this.height);

  /// A size whose [width] and [height] are both zero.
  static const Size zero = Size(Unit.zero, Unit.zero);

  /// A size whose [width] and [height] are both `Unit.infinity`.
  static const Size infinite = Size(Unit.auto, Unit.auto);

  @override
  String toString() => 'Size(${width.toString()}, ${height.toString()})';
}
