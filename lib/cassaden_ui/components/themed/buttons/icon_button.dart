// lib/components/icon_button.dart
import 'package:jaspr/jaspr.dart';

import '../../assets/icon.dart';
import '../../containers/align.dart';
import '../../extensions/extensions.dart';

/// A Jaspr component that creates a Material Design icon button.
///
/// Mimics Flutter's [IconButton] widget.
class IconButton extends StatelessComponent {
  /// Called when the button is tapped.
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// The icon to display inside the button.
  final Icon icon;

  /// Text that describes the action of the button for accessibility (tooltip).
  final String? tooltip;

  /// The color of the icon when the button is enabled.
  final Color? color;

  /// The color of the icon when the button is disabled.
  final Color? disabledColor;

  /// The splash radius of the button's ink splash.
  /// For web, this primarily influences the circular shape and padding.
  final Unit? splashRadius;

  /// The padding around the icon.
  final Unit? padding;

  /// How the icon is aligned within the button's bounds.
  final Alignment? alignment;

  /// Whether the button should be autofocused.
  final bool autofocus;

  /// Whether feedback (auditory or haptic) should be enabled for this button.
  /// (This property is kept for API consistency but has no effect in this web implementation).
  final bool enableFeedback;

  const IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.splashRadius, // This will influence padding and border-radius
    this.padding,
    this.alignment = Alignment.center, // Default to center alignment
    this.autofocus = false,
    this.enableFeedback = true, // No effect for now, but part of Flutter API
  });

  @override
  build(BuildContext context) sync* {
    final bool isDisabled = onPressed == null;
    final Color effectiveIconColor = isDisabled
        ? (disabledColor ?? Colors.black.withOpacity(0.38))
        : (color ?? Colors.black);

    // Calculate effective padding. Flutter's default icon button minimum touch target is 48px.
    // An icon of 24px with 12px padding on each side makes 48px.
    // If splashRadius is provided, it often defines the button's overall interactive area.
    final Unit defaultPadding =
        12.px; // Corresponds to a typical 48px touch target for 24px icon
    final Unit effectivePadding = padding ?? defaultPadding;
    final Unit effectiveMinSize =
        ((icon.size ?? 24.px) + (effectivePadding * 2).px)
            .px; // Icon size + 2*padding

    final Map<String, String> buttonCssProperties = {
      // --- Button Reset Styles ---
      'background-color': 'transparent',
      'border': 'none',
      'outline': 'none',
      'font-family':
          'inherit', // Inherit font for potential text labels (though we only have icons)
      'font-size': 'inherit', // Inherit font size
      'line-height': '1', // Ensure tight line height
      'appearance': 'none', // For cross-browser consistency in button styling

      // --- Sizing and Shape ---
      'min-width': effectiveMinSize.value,
      'min-height': effectiveMinSize.value,
      'width': effectiveMinSize.value, // Make it square by default
      'height': effectiveMinSize.value,
      'padding': effectivePadding.value, // Apply padding

      'border-radius': (splashRadius?.value ??
          (effectiveMinSize / 2)
              .toString()), // Make it circular (half of min-size)
      'display': 'inline-flex', // Use flexbox to center the icon
      'justify-content':
          alignment!.justifyContentCssString, // Apply horizontal alignment
      'align-items': alignment!.alignItemsCssString, // Apply vertical alignment
      'overflow':
          'hidden', // Hide any overflow from splash effects if added later

      // --- States ---2424
      'cursor': isDisabled ? Cursor.notAllowed.value : Cursor.pointer.value,
      'opacity':
          isDisabled ? '0.6' : '1.0', // Visual feedback for disabled state
      'transition': 'all 0.2s ease-in-out', // Smooth transitions for properties
      'box-sizing': 'border-box', // Include padding in width/height

      // --- Hover/Active/Focus States (basic implementation) ---
      // These are often handled with CSS pseudo-classes.
      // For more complex effects (like Flutter's splash), you'd need JavaScript
      // or more advanced CSS (e.g., using ::before pseudo-elements with transitions).
      '&:hover':
          'background-color: rgba(0, 0, 0, 0.08);', // Light overlay on hover
      '&:active':
          'background-color: rgba(0, 0, 0, 0.16);', // Darker overlay on active
      '&:focus':
          'box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.5);', // Simple focus ring
      // Apply different styles if disabled
      '&:disabled':
          'cursor: not-allowed; opacity: 0.5;', // More pronounced disabled state
    };

    // Create a new Icon instance with the effective color
    final styledIcon = Icon(
      icon.icon,
      size: icon.size,
      color: effectiveIconColor, // Apply calculated color
      semanticLabel: icon.semanticLabel,
    );

    yield button(
      styles: Styles(raw: buttonCssProperties),
      attributes: {
        if (tooltip != null)
          'title': tooltip!, // Tooltip for HTML title attribute
        if (isDisabled) 'disabled': 'true', // Disable the native button element
        if (autofocus) 'autofocus': 'true',
      },
      events: {
        'click': (e) {
          if (!isDisabled) {
            onPressed?.call();
          }
        },
        'contextmenu': (e) {
          // Right-click as a web equivalent for long press
          if (!isDisabled) {
            e.preventDefault(); // Prevent default browser context menu
            onLongPress?.call();
          }
        },
      },
      [styledIcon], // The Icon component is the child of the button
    );
  }
}
