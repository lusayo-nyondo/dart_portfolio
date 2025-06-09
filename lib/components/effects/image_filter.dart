import 'package:universal_web/js_interop.dart';

// --- JS Interop Definitions ---
// @staticInterop classes are implicitly JSObjects
@JS()
@staticInterop
class HTMLElement {}

@JS()
@staticInterop
class SVGElement {}

@JS()
@staticInterop
class SVGFESpecularLightingElement {} // Example for more complex filters

@JS()
@staticInterop
class Document {
  external HTMLElement createElement(String tagName);
  external SVGElement createElementNS(
      String namespaceURI, String qualifiedName);
  external HTMLElement getElementById(String elementId);
}

@JS('document')
external Document get document;
// --- ImageFilter Implementation ---

/// An abstract base class for image filters.
abstract class ImageFilter {
  const ImageFilter._();

  /// Creates a blur filter.
  /// `sigmaX` and `sigmaY` correspond to the standard deviation of the blur in x and y directions.
  factory ImageFilter.blur({double sigmaX = 0.0, double sigmaY = 0.0}) {
    return _BlurImageFilter(sigmaX, sigmaY);
  }

  /// Creates a color matrix filter.
  /// The [matrix] is a list of 20 doubles in row-major order.
  /// The first 16 values are the 4x4 transform matrix, and the last 4
  /// are the translation vector.
  factory ImageFilter.matrix(List<double> matrix) {
    assert(matrix.length == 20);
    return _ColorMatrixImageFilter(List.unmodifiable(matrix));
  }

  /// Creates a morphological filter that dilates the image.
  /// `radiusX` and `radiusY` define the size of the dilation kernel.
  factory ImageFilter.dilate({double radiusX = 0.0, double radiusY = 0.0}) {
    return _MorphologyImageFilter(radiusX, radiusY, 'dilate');
  }

  /// Creates a morphological filter that erodes the image.
  /// `radiusX` and `radiusY` define the size of the erosion kernel.
  factory ImageFilter.erode({double radiusX = 0.0, double radiusY = 0.0}) {
    return _MorphologyImageFilter(radiusX, radiusY, 'erode');
  }

  /// Generates the SVG filter primitive string for this filter.
  /// `input` is the `in` attribute value for the filter primitive (e.g., "SourceGraphic").
  /// The result will be used inside an `<filter>` tag.
  String toSvgFilterPrimitive(String input, String resultId);

  /// Generates the CSS filter function string for this filter (e.g., "blur(5px)").
  String toCssFilter();

  // For combining multiple filters, a factory might create a _CompositeImageFilter
  // that generates a chain of SVG filter primitives.
}

/// Blur ImageFilter implementation.
class _BlurImageFilter extends ImageFilter {
  final double sigmaX;
  final double sigmaY;

  const _BlurImageFilter(this.sigmaX, this.sigmaY) : super._();

  @override
  String toSvgFilterPrimitive(String input, String resultId) {
    if (sigmaX == 0.0 && sigmaY == 0.0) {
      return ''; // No blur needed, return empty string
    }
    // SVG feGaussianBlur uses stdDeviation.
    return '<feGaussianBlur in="$input" stdDeviation="$sigmaX $sigmaY" result="$resultId" />';
  }

  @override
  String toCssFilter() {
    if (sigmaX == 0.0 && sigmaY == 0.0) {
      return ''; // No blur
    }
    // CSS blur() takes a single radius. We'll use an average or max.
    // Let's use an average for now.
    // Flutter's ImageFilter.blur sigma values are standard deviations.
    final cssBlurRadius = (sigmaX + sigmaY) / 2.0;
    return 'blur(${cssBlurRadius}px)';
  }

  @override
  bool operator ==(Object other) =>
      other is _BlurImageFilter &&
      sigmaX == other.sigmaX &&
      sigmaY == other.sigmaY;
  @override
  int get hashCode => Object.hash(sigmaX, sigmaY);
}

/// Color Matrix ImageFilter implementation.
class _ColorMatrixImageFilter extends ImageFilter {
  final List<double> matrix;

  const _ColorMatrixImageFilter(this.matrix) : super._();

  @override
  String toSvgFilterPrimitive(String input, String resultId) {
    final matrixString = matrix.map((e) => e.toString()).join(' ');
    return '<feColorMatrix type="matrix" in="$input" values="$matrixString" result="$resultId" />';
  }

  @override
  String toCssFilter() {
    // CSS backdrop-filter doesn't have a direct 'matrix()' function.
    // This would typically require an SVG filter referenced by url(), which is complex for direct CSS.
    return ''; // Not directly translatable to a simple CSS filter string
  }

  @override
  bool operator ==(Object other) =>
      other is _ColorMatrixImageFilter &&
      // List equality check
      (matrix.length == other.matrix.length &&
          matrix.asMap().entries.every((e) => e.value == other.matrix[e.key]));
  @override
  int get hashCode => Object.hashAll(matrix);
}

/// Morphology ImageFilter implementation (Dilate/Erode).
class _MorphologyImageFilter extends ImageFilter {
  final double radiusX;
  final double radiusY;
  final String operator; // 'dilate' or 'erode'

  const _MorphologyImageFilter(this.radiusX, this.radiusY, this.operator)
      : super._();

  @override
  String toSvgFilterPrimitive(String input, String resultId) {
    if (radiusX == 0.0 && radiusY == 0.0) {
      return ''; // No operation needed
    }
    // SVG feMorphology uses radius attribute.
    // If radiusX and radiusY are different, SVG uses "radiusX radiusY" format.
    final radius = (radiusX == radiusY) ? '$radiusX' : '$radiusX $radiusY';
    return '<feMorphology operator="$operator" in="$input" radius="$radius" result="$resultId" />';
  }

  @override
  String toCssFilter() {
    // CSS backdrop-filter doesn't have direct 'dilate()' or 'erode()' functions.
    // These are typically SVG operations.
    return ''; // Not directly translatable to a simple CSS filter string
  }

  @override
  bool operator ==(Object other) =>
      other is _MorphologyImageFilter &&
      radiusX == other.radiusX &&
      radiusY == other.radiusY &&
      operator == other.operator;
  @override
  int get hashCode => Object.hash(radiusX, radiusY, operator);
}
