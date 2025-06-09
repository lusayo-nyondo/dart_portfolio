/// An immutable 2D floating-point size.
///
/// Mimics Flutter's [Size] class.
class Size {
  /// The horizontal extent of this size.
  final double width;

  /// The vertical extent of this size.
  final double height;

  /// Creates a size with the given [width] and [height].
  const Size(this.width, this.height);

  /// A size whose [width] and [height] are both zero.
  static const Size zero = Size(0.0, 0.0);

  /// A size whose [width] and [height] are both `double.infinity`.
  static const Size infinite = Size(double.infinity, double.infinity);

  @override
  String toString() =>
      'Size(${width.toStringAsFixed(1)}, ${height.toStringAsFixed(1)})';
}
