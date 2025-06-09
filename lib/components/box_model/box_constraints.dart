/// Defines minimum and maximum dimensions for a box.
///
/// Mimics Flutter's [BoxConstraints].
class BoxConstraints {
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  const BoxConstraints({
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  });

  /// Creates box constraints that are as tight as possible.
  ///
  /// Requires a child to be exactly the given [width] and [height].
  const BoxConstraints.tight({
    required double width,
    required double height,
  })  : minWidth = width,
        maxWidth = width,
        minHeight = height,
        maxHeight = height;

  /// Creates box constraints that require the given width and height.
  ///
  /// This constructor is similar to [BoxConstraints.tight] but allows
  /// width and height to be `null` to represent unbounded dimensions.
  const BoxConstraints.tightFor({
    double? width,
    double? height,
  })  : minWidth = width ?? 0.0,
        maxWidth = width ?? double.infinity,
        minHeight = height ?? 0.0,
        maxHeight = height ?? double.infinity;

  /// Creates box constraints that forbid a dimension from being larger than a given value.
  ///
  /// The minimum width and height are 0.0.
  const BoxConstraints.loose({
    double? width,
    double? height,
  })  : minWidth = 0.0,
        maxWidth = width ?? double.infinity,
        minHeight = 0.0,
        maxHeight = height ?? double.infinity;

  @override
  String toString() {
    return 'BoxConstraints(minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)';
  }
}
