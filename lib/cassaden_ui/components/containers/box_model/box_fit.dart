/// How a box's content should be inscribed into its parent's dimensions.
///
/// Mimics Flutter's [BoxFit] and maps to the CSS `object-fit` property.
class BoxFit {
  /// The CSS `object-fit` value for this BoxFit.
  final String value;

  const BoxFit._(this.value);

  /// The child is sized to be as large as possible while still being contained by the box.
  /// The aspect ratio of the child is respected.
  static const BoxFit contain = BoxFit._('contain');

  /// The child is sized to be as small as possible while still covering the box.
  /// The aspect ratio of the child is respected.
  static const BoxFit cover = BoxFit._('cover');

  /// The child is sized to fill the box. The aspect ratio of the child is not respected.
  static const BoxFit fill = BoxFit._('fill');

  /// The child is sized to fit the width of the box. The aspect ratio of the child is respected.
  /// Note: This doesn't directly map to a single `object-fit` value.
  /// For more precise control, you might need to adjust parent dimensions or use more complex CSS.
  /// However, for an `object-fit` context, `contain` is the closest general behavior.
  /// Or, you might use a combination of `width: 100%` and `object-fit: contain` on the image.
  /// For now, we'll map it to 'contain' as 'fitWidth' is not a direct `object-fit` value.
  static const BoxFit fitWidth = BoxFit._('contain');

  /// The child is sized to fit the height of the box. The aspect ratio of the child is respected.
  /// Similar to `fitWidth`, this doesn't map directly to a single `object-fit` value.
  /// We'll map it to 'contain' as 'fitHeight' is not a direct `object-fit` value.
  static const BoxFit fitHeight = BoxFit._('contain');

  /// The child is not resized.
  static const BoxFit none = BoxFit._('none');

  /// The child is sized to fill the box, but only if it would otherwise be
  /// larger than the box. The aspect ratio of the child is respected.
  static const BoxFit scaleDown = BoxFit._('scale-down');
}
