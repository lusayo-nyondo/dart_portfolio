// lib/components/layout/clip.dart

/// Controls how a box's content is clipped.
///
/// Mimics Flutter's [Clip].
enum Clip {
  /// No clipping. The content is not restricted to the bounds of the box.
  none,

  /// The content is clipped to the bounds of the box using a hard edge.
  /// Corresponds to `overflow: hidden;` in CSS.
  hardEdge,

  /// The content is clipped to the bounds of the box and antialiased.
  /// (No direct CSS equivalent for antialiasing within `overflow` property,
  /// but we map this to `overflow: hidden` for basic functionality).
  antiAlias,

  /// The content is clipped to the bounds of the box and antialiased,
  /// with a save layer. (No direct CSS equivalent, treated as `overflow: hidden`).
  antiAliasWithSaveLayer,
}
