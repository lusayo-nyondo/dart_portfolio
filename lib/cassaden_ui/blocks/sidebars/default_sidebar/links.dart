part of 'sidebar.dart';

/// A component that acts as a navigation panel link, automatically applying
/// styles and/or classes based on its active state.
class SidebarLink extends StatelessComponent {
  /// The path the link navigates to. This should match a route defined in Jaspr Router.
  final String path;

  /// The text or content to display inside the link.
  final Component child;

  /// Whether this link is currently active.
  /// This can be determined automatically by the router or controlled externally.
  final bool isActive;

  /// An optional CSS class to apply when this link's [path] is the currently
  /// active route or a descendant of the active route.
  final String? activeClass;

  /// An optional CSS class to apply when this link's [path] is NOT the currently
  /// active route.
  final String? inactiveClass;

  /// Optional [Styles] to apply when this link is active.
  final Styles? activeStyles;

  /// Optional [Styles] to apply when this link is not active.
  final Styles? inactiveStyles;

  /// Additional classes to apply to the link, regardless of active state.
  /// These are prepended to any `activeClass` or `inactiveClass`.
  final String? classes;

  /// Optional base [Styles] to apply to the link, which will be merged with
  /// active/inactive styles.
  final Styles? styles;

  const SidebarLink({
    required this.path,
    required this.child,
    this.isActive = false, // Now an explicit parameter
    this.activeClass,
    this.inactiveClass,
    this.activeStyles,
    this.inactiveStyles,
    // Removed 'exact' as the active state is now explicitly passed in.
    // If auto-detection based on path is needed, that logic would be outside this component.
    this.classes,
    this.styles,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // --- Material 3 inspired sensible defaults for base styles (using Tailwind classes) ---
    // These are simplified Material 3 text button/tab styles adapted for Tailwind.
    // Full Material 3 theming would involve a more comprehensive system.
    // Instead of Jaspr's Colors.black.withOpacity(0.8), we'll use a Tailwind class.
    // The Jaspr Styles are for specific properties not covered by Tailwind classes,
    // or for direct pixel values.

    final defaultBaseStyles = Styles(
      fontWeight: FontWeight.w500, // Medium weight
      textDecoration: TextDecoration.none,
      fontSize: 16.px,
      padding: Padding.symmetric(horizontal: 16.px, vertical: 8.px),
      radius: BorderRadius.all(Radius.circular(8.px)),
    );

    // --- Material 3 inspired sensible defaults for active/inactive styles (using Tailwind classes) ---
    // We'll define base classes for colors and backgrounds, then use Jaspr Styles for other properties.

    // Merge provided base styles with defaults
    final effectiveBaseStyles = (styles ?? Styles()).combine(defaultBaseStyles);

    // Determine the effective active/inactive styles, merging with defaults
    // Note: We'll primarily use classes for colors and backgrounds for Tailwind consistency.
    final Styles effectiveActiveStyles =
        (activeStyles ?? Styles()).combine(Styles(
      fontWeight: FontWeight.w700, // Make active text bolder
      // Other active-specific Jaspr styles can go here
    ));

    final Styles effectiveInactiveStyles =
        (inactiveStyles ?? Styles()).combine(Styles(
            // Inactive-specific Jaspr styles can go here, e.g., opacity if not handled by Tailwind
            ));

    // --- Determine the combined classes (including Tailwind for colors) ---
    String? combinedClasses;
    // Base Tailwind classes for text and background color if not overridden
    final defaultTailwindClasses =
        'text-gray-800 hover:bg-gray-100 inline-block w-full'; // Default text color and hover state
    final activeTailwindClasses =
        'text-blue-700 bg-blue-400 font-bold'; // Active text color and background
    final inactiveTailwindClasses = 'text-gray-600'; // Inactive text color

    // Start with default classes if not explicitly provided
    combinedClasses = classes ?? defaultTailwindClasses;

    if (isActive) {
      // Add active-specific classes
      combinedClasses = '$combinedClasses $activeTailwindClasses';
      if (activeClass != null) {
        combinedClasses = '$combinedClasses $activeClass';
      }
    } else {
      // Add inactive-specific classes
      combinedClasses = '$combinedClasses $inactiveTailwindClasses';
      if (inactiveClass != null) {
        combinedClasses = '$combinedClasses $inactiveClass';
      }
    }

    // Determine the final styles to apply
    Styles finalStyles = effectiveBaseStyles;
    if (isActive) {
      finalStyles = finalStyles.combine(effectiveActiveStyles);
    } else {
      finalStyles = finalStyles.combine(effectiveInactiveStyles);
    }

    yield Link(
      to: path,
      classes: combinedClasses,
      styles: finalStyles,
      child: child,
    );
  }
}
