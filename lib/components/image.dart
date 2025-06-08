import 'package:jaspr/jaspr.dart';

import 'box_fit.dart';
import 'asset_bundle.dart';

/// How a child is aligned within its parent.
///
/// Mimics Flutter's [Alignment] for image placement, mapping to CSS `object-position`.
class ImageAlignment {
  final String horizontal;
  final String vertical;
  const ImageAlignment._(this.horizontal, this.vertical);

  /// Align the center of the child with the center of the parent.
  static const ImageAlignment center = ImageAlignment._('center', 'center');

  /// Align the left of the child with the left of the parent.
  static const ImageAlignment topLeft = ImageAlignment._('left', 'top');
  static const ImageAlignment topCenter = ImageAlignment._('center', 'top');
  static const ImageAlignment topRight = ImageAlignment._('right', 'top');

  static const ImageAlignment bottomLeft = ImageAlignment._('left', 'bottom');
  static const ImageAlignment bottomCenter =
      ImageAlignment._('center', 'bottom');
  static const ImageAlignment bottomRight = ImageAlignment._('right', 'bottom');

  static const ImageAlignment centerLeft = ImageAlignment._('left', 'center');
  static const ImageAlignment centerRight = ImageAlignment._('right', 'center');

  String get value => '$horizontal $vertical';
}

/// A Jaspr component that displays an image.
///
/// This widget handles displaying images from various sources, similar to Flutter's [Image].
/// It primarily renders an HTML `<img>` tag and uses CSS for fitting and alignment.
class Image extends StatelessComponent {
  /// The image source URL.
  final String src;

  /// The width of the image.
  final Unit? width;

  /// The height of the image.
  final Unit? height;

  /// How the image should be inscribed into the box. Maps to CSS `object-fit`.
  final BoxFit? fit;

  /// How to align the image within its bounds. Maps to CSS `object-position`.
  final ImageAlignment? alignment;

  /// Alternative text for the image, for accessibility.
  final String? semanticLabel;

  /// A component to display if the image fails to load.
  final Component? errorBuilder;

  /// A component to display while the image is loading.
  /// (Simplified for web, typically a placeholder before `src` is loaded)
  final Component? frameBuilder;

  /// Whether to use native lazy loading for the image.
  final bool lazyLoad;

  /// Private constructor for common properties.
  const Image._({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.semanticLabel,
    this.errorBuilder,
    this.frameBuilder,
    this.lazyLoad = false, // Default to false
  });

  /// Creates an image from an asset.
  ///
  /// The [name] is the asset key (e.g., 'images/logo.png').
  /// Ensure you have placed the asset in your `web/assets/` directory.
  factory Image.asset(
    String name, {
    Key? key,
    Unit? width,
    Unit? height,
    BoxFit? fit,
    ImageAlignment? alignment,
    String? semanticLabel,
    Component? errorBuilder,
    Component? frameBuilder,
    bool lazyLoad = false,
  }) {
    final String assetUrl = RootAssetBundle.instance.getAssetUrl(name);
    return Image._(
      key: key,
      src: assetUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      semanticLabel:
          semanticLabel ?? name, // Use asset name as label if not provided
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      lazyLoad: lazyLoad,
    );
  }

  /// Creates an image from a network URL.
  factory Image.network(
    String src, {
    Key? key,
    Unit? width,
    Unit? height,
    BoxFit? fit,
    ImageAlignment? alignment,
    String? semanticLabel,
    Component? errorBuilder,
    Component? frameBuilder,
    bool lazyLoad = false,
  }) {
    return Image._(
      key: key,
      src: src,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      semanticLabel: semanticLabel,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      lazyLoad: lazyLoad,
    );
  }

  @override
  build(BuildContext context) sync* {
    final Map<String, String> cssProperties = {};

    if (width != null) cssProperties['width'] = width!.value;
    if (height != null) cssProperties['height'] = height!.value;
    if (fit != null) cssProperties['object-fit'] = fit!.value;
    if (alignment != null) cssProperties['object-position'] = alignment!.value;

    // Set display to block for images to better control dimensions,
    // though inline-block is also common for images.
    cssProperties['display'] = 'block';

    yield img(
      src: src,
      styles: Styles(raw: cssProperties),
      attributes: {
        if (semanticLabel != null) 'alt': semanticLabel!,
        if (lazyLoad) 'loading': 'lazy', // Native browser lazy loading
      },
      events: {
        // Simple error handling: replace with errorBuilder if provided
        'error': (e) {
          print(e);
        },
        // frameBuilder is harder to implement purely with img tag.
        // It generally implies showing content *before* the image loads.
        // For a simple img tag, the browser handles this.
        // If complex, it might require a StatefulComponent that observes load state.
      },
      // If errorBuilder is provided, it can be yielded conditionally based on state.
      // For a simple StatelessComponent, we can't easily swap out on error.
      // So, the error event listener above is a basic interaction.
    );

    // If an errorBuilder is provided, we can conceptually show it if the
    // image fails, but this usually involves managing state (e.g., in a StatefulComponent).
    // For a StatelessComponent, the errorBuilder is more of a suggestion.
    // A true Flutter-like error/frame builder would likely require a custom
    // image loading mechanism with more granular state reporting.
    // For now, the img element's `error` event listener is the most direct web approach.
  }
}
