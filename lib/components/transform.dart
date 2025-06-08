import 'package:jaspr/jaspr.dart';

/// Applies a transformation to its child.
///
/// Mimics Flutter's [Transform] widget.
///
/// In Flutter, transformations are done via `Matrix4`. In CSS, transformations
/// are strings like `'rotate(45deg) scale(1.2)'`.
///
/// This component accepts a raw CSS transform string.
///
/// **Note:** This component only handles *visual* transformations.
/// It does *not* affect layout. The child still occupies its original space.
class TransformComponent extends StatelessComponent {
  final Component child;
  final Transform transform; // Raw CSS transform string

  const TransformComponent({
    super.key,
    required this.child,
    required this.transform,
  });

  @override
  build(BuildContext context) sync* {
    yield div(
      styles: Styles(
        transform: transform,
      ),
      [child],
    );
  }
}
