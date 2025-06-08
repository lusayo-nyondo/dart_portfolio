/// How a box's content should be inscribed into its parent's dimensions.
///
/// Mimics Flutter's [BoxFit] enum.
enum BoxFit {
  /// The child is sized to be as large as possible while still being contained by the box.
  /// The aspect ratio of the child is respected.
  contain,

  /// The child is sized to be as small as possible while still covering the box.
  /// The aspect ratio of the child is respected.
  cover,

  /// The child is sized to fill the box. The aspect ratio of the child is not respected.
  fill,

  /// The child is sized to fit the width of the box. The aspect ratio of the child is respected.
  fitWidth,

  /// The child is sized to fit the height of the box. The aspect ratio of the child is respected.
  fitHeight,

  /// The child is not resized.
  none,

  /// The child is sized to fill the box, but only if it would otherwise be
  /// larger than the box. The aspect ratio of the child is respected.
  scaleDown,
}
