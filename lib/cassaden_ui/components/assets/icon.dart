import 'package:jaspr/jaspr.dart';

import 'material_icons.dart';

/// A Jaspr component that displays a graphical icon.
///
/// Mimics Flutter's [Icon] widget.
///
/// This implementation relies on the Material Icons font being loaded in your `web/index.html`.
/// Make sure to include the following line in your `web/index.html`'s `<head>` section:
/// `<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">`
class Icon extends StatelessComponent {
  final IconData icon; // Uses our custom IconData
  final Unit? size; // Jaspr's Unit for size (e.g., 24.px)
  final Color? color;
  final String?
      semanticLabel; // For accessibility (title attribute for hover tooltip)

  const Icon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
  });

  @override
  build(BuildContext context) sync* {
    final Map<String, String> iconCssProperties = {
      // Convert Unit and Color to their CSS string representations
      if (size != null) 'font-size': size!.value,
      if (color != null) 'color': color!.value,

      // Raw CSS properties often needed for font icons
      'display': Display.inlineBlock.value,
      'line-height': 1.toString(), // Ensure no extra space
      'user-select': 'none', // Prevent text selection on icon
      'text-rendering': 'optimizeLegibility', // Smoother rendering
      'word-wrap': 'normal', // Ensure icon ligature doesn't break
      'direction': 'ltr', // Standardize direction
      '-moz-osx-font-smoothing': 'grayscale', // For Firefox rendering
      '-webkit-font-smoothing': 'antialiased', // For Chrome/Safari rendering
    };

    yield i(
      classes:
          'material-icons', // This class is essential for Material Icons font
      styles: Styles(
        raw: iconCssProperties, // Pass the raw map here
      ),
      attributes: ({
        'title': semanticLabel ?? 'icon',
      }),
      [
        text(icon.name)
      ], // The text content is the icon's ligature name (e.g., 'home')
    );
  }
}
