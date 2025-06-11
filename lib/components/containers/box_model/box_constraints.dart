import 'package:jaspr/jaspr.dart';

/// Defines minimum and maximum dimensions for a box.
///
/// Mimics Flutter's [BoxConstraints].
class BoxConstraints {
  final Unit minWidth;
  final Unit maxWidth;
  final Unit minHeight;
  final Unit maxHeight;

  const BoxConstraints({
    this.minWidth = Unit.zero,
    this.maxWidth = Unit.auto,
    this.minHeight = Unit.zero,
    this.maxHeight = Unit.auto,
  });

  /// Creates box constraints that are as tight as possible.
  ///
  /// Requires a child to be exactly the given [width] and [height].
  const BoxConstraints.tight({
    required Unit width,
    required Unit height,
  })  : minWidth = width,
        maxWidth = width,
        minHeight = height,
        maxHeight = height;

  /// Creates box constraints that require the given width and height.
  ///
  /// This constructor is similar to [BoxConstraints.tight] but allows
  /// width and height to be `null` to represent unbounded dimensions.
  const BoxConstraints.tightFor({
    Unit? width,
    Unit? height,
  })  : minWidth = width ?? Unit.zero,
        maxWidth = width ?? Unit.auto,
        minHeight = height ?? Unit.zero,
        maxHeight = height ?? Unit.auto;

  /// Creates box constraints that forbid a dimension from being larger than a given value.
  ///
  /// The minimum width and height are Unit.zero.
  const BoxConstraints.loose({
    Unit? width,
    Unit? height,
  })  : minWidth = Unit.zero,
        maxWidth = width ?? Unit.auto,
        minHeight = Unit.zero,
        maxHeight = height ?? Unit.auto;

  @override
  String toString() {
    return 'BoxConstraints(minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)';
  }
}
