part of 'scaffold.dart';

/// Mimics Flutter's FloatingActionButton widget for Jaspr.
/// A circular icon button that floats above the content.
class FloatingActionButton extends StatelessComponent {
  final Component child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor; // For icon/text color inside the FAB

  const FloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield button(
      // FAB container styling: fixed, circular, positioned at bottom-right
      classes: [
        'fixed', 'bottom-8',
        'right-8', // Fixed position (8 units from bottom/right)
        'w-14', 'h-14',
        'rounded-full', // Circular shape (w-14, h-14, rounded-full)
        'shadow-lg', // Shadow for floating effect
        'flex', 'items-center', 'justify-center', // Flexbox for centering child
        'hover:bg-opacity-80',
        'transition-colors', // Hover effect and smooth transition
        'focus:outline-none', 'focus:ring-2', 'focus:ring-pink-400',
        'focus:ring-opacity-75', // Focus styles
        'z-30', // Z-index to be above most content but below drawers/overlay
      ].join(' '),
      styles: Styles(
        backgroundColor: backgroundColor,
        color: foregroundColor,
      ),
      events: {
        'click': (e) => onPressed?.call(), // Attach onPressed callback
      },
      [
        child, // The content of the FAB (e.g., an icon or a '+' text)
      ],
    );
  }
}
