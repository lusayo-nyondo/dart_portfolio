import 'package:jaspr/jaspr.dart';

/// A widget that lays its child out as if it was in the tree, but without painting it.
///
/// Mimics Flutter's [Offstage] widget.
///
/// In web development, the most direct equivalent is `visibility: hidden` or `display: none`.
/// `visibility: hidden` keeps the element in the layout flow, taking up space,
/// while `display: none` removes it from the layout flow.
///
/// Flutter's [Offstage] defaults to `visibility: hidden` behavior.
///
/// **Note:** `Offstage` in Flutter can also prevent the child from receiving
/// input events. This behavior is automatically handled by both `visibility: hidden`
/// and `display: none` in CSS.
class Offstage extends StatelessComponent {
  final Component child;
  final bool
      offstage; // If true, the child is hidden. If false, the child is visible.

  const Offstage({
    super.key,
    required this.child,
    this.offstage = true, // Default to hidden (like Flutter's Offstage)
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        // Use visibility: hidden to hide the child but still keep it in the layout.
        // Use display: none to completely remove the child from the layout.
        visibility: offstage ? Visibility.hidden : Visibility.visible,
        // If you want display: none behavior, use this instead of visibility:
        // display: offstage ? Display.none : Display.block, // Or Display.inline, etc.
      ),
      [child],
    );
  }
}
