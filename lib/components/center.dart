import 'package:jaspr/jaspr.dart';

/// A widget that centers its child within itself.
///
/// Mimics Flutter's [Center] widget.
///
/// By default, it expands to take up all available space.
///
/// **Note on `widthFactor` and `heightFactor`:**
/// Flutter's [Center] widget can size itself to a multiple of its child's size
/// using `widthFactor` and `heightFactor`. This functionality is complex
/// to replicate precisely with pure CSS without JavaScript to measure the child's
/// intrinsic dimensions dynamically.
///
/// In this Jaspr implementation, if `widthFactor` or `heightFactor` are provided,
/// the [Center] component will attempt to shrink-wrap its content (becoming
/// only as large as its child) and then center the child. The direct
/// multiplication/scaling behavior based on the factor is not applied purely
/// via CSS, as it requires knowledge of the child's exact rendered size.
class Center extends StatelessComponent {
  final Component child;
  final double? widthFactor;
  final double? heightFactor;

  const Center({
    super.key,
    required this.child,
    this.widthFactor,
    this.heightFactor,
  });

  @override
  build(BuildContext context) sync* {
    final List<String> classes = [
      'flex', // Enable flexbox
      'justify-center', // Center horizontally
      'items-center', // Center vertically
    ];

    // If factors are provided, try to make the Center container shrink-wrap its child.
    // Otherwise, it expands to fill available space.
    if (widthFactor != null || heightFactor != null) {
      classes
          .add('inline-flex'); // Makes the flex container shrink-wrap content
      classes.add('max-w-max'); // Ensure it shrinks horizontally
      classes.add('max-h-max'); // Ensure it shrinks vertically
    } else {
      classes.add('w-full'); // Expands to fill parent horizontally
      classes.add('h-full'); // Expands to fill parent vertically
    }

    yield div(
      classes: classes.join(' '),
      [child],
    );
  }
}
