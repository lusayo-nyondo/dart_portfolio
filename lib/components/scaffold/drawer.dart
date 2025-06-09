part of 'scaffold.dart';

/// Mimics Flutter's Drawer widget for Jaspr.
/// A side panel that slides in and out of the Scaffold.
class Drawer extends StatelessComponent {
  final Component child;
  final double width; // Width of the drawer in pixels
  final Color? backgroundColor;

  // Internal properties managed by Scaffold to control state and position
  final bool isOpen;
  final VoidCallback? onClose;
  final bool isEndDrawer; // True if it's the right-side drawer

  const Drawer({
    super.key,
    required this.child,
    this.width = 250.0, // Default width for a drawer
    this.backgroundColor,
    this.isOpen = false, // Default state: closed
    this.onClose, // Callback to tell Scaffold to close
    this.isEndDrawer = false, // Default: left-side drawer
  });

  // Helper method to create a new Drawer instance with updated internal properties.
  // This is used by `Scaffold` to update the drawer's open/close state.
  Drawer copyWith({
    bool? isOpen,
    VoidCallback? onClose,
    bool? isEndDrawer,
  }) {
    return Drawer(
      key: key, // Preserve the original key if any
      child: child,
      width: width,
      backgroundColor: backgroundColor,
      isOpen: isOpen ?? this.isOpen,
      onClose: onClose ?? this.onClose,
      isEndDrawer: isEndDrawer ?? this.isEndDrawer,
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      // Drawer container styling: fixed, full height, animated slide in/out
      classes: [
        'fixed',
        'top-0',
        'h-full', // Full height of the viewport
        'shadow-lg', // Shadow for visual depth
        'z-50', // Very high z-index to be on top of everything, including overlay
        'transition-transform', // Enable CSS transitions for 'transform'
        'duration-300', // Transition duration
        'ease-in-out', // Easing function
        if (isEndDrawer) 'right-0' else 'left-0', // Position on left or right
        // Apply transform to slide in/out based on isOpen state and isEndDrawer
        if (isOpen)
          'translate-x-0' // Drawer is open: no translation
        else if (isEndDrawer)
          'translate-x-full' // End Drawer is closed: translate full width to the right
        else
          '-translate-x-full', // Left Drawer is closed: translate full width to the left
      ].join(' '),
      styles: Styles(
          width: width.px,
          backgroundColor:
              backgroundColor), // Set explicit width using inline style
      [
        child, // The content of the drawer
      ],
    );
  }
}
