part of 'scaffold.dart';

/// Mimics Flutter's AppBar widget for Jaspr.
/// Provides a top bar for the Scaffold.
class AppBar extends StatelessComponent {
  final Component? title;
  final Component? leading;
  final List<Component>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor; // For text/icon color within the AppBar

  // Callbacks to communicate with the Scaffold to open drawers
  final VoidCallback? onDrawerOpen;
  final VoidCallback? onEndDrawerOpen;

  const AppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.onDrawerOpen, // These are passed by Scaffold
    this.onEndDrawerOpen, // These are passed by Scaffold
  });

  // Helper method to create a new AppBar instance with updated callbacks.
  // This is crucial because `Scaffold` will get an AppBar instance
  // and needs to "inject" its state-managing callbacks into it.
  AppBar copyWith({
    VoidCallback? onDrawerOpen,
    VoidCallback? onEndDrawerOpen,
  }) {
    return AppBar(
      key: key, // Preserve the original key if any
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onDrawerOpen: onDrawerOpen ??
          this.onDrawerOpen, // Use new callback if provided, else keep existing
      onEndDrawerOpen: onEndDrawerOpen ?? this.onEndDrawerOpen,
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield nav(
      // AppBar container styling: fixed at top, flexible content arrangement
      classes: [
        //'w-full', 'fixed', 'top-0', 'left-0',
        //'z-30', // Fixed positioning on top
        'flex', 'items-center', 'justify-between',
        'p-4', // Flex container for alignment
        'shadow-md', // Colors and shadow
        'h-14', // Fixed height for AppBar
      ].join(' '),
      styles: Styles(
        backgroundColor: backgroundColor,
        color: foregroundColor,
      ),
      attributes: {
        if (foregroundColor != null)
          'background-color': 'var($surfaceColorVariable)',
      },

      [
        // Leading widget (e.g., custom icon or default hamburger icon)
        div(
          classes: ['flex', 'items-center', 'gap-2'].join(' '),
          [
            if (leading != null) leading!,
            // If no custom leading and drawer is available, show default hamburger menu icon
            if (leading == null && onDrawerOpen != null)
              button(
                classes: [
                  'p-2',
                  'rounded-md',
                  'hover:bg-opacity-80',
                  'focus:outline-none'
                ].join(' '),
                events: {
                  'click': (e) => onDrawerOpen!()
                }, // Trigger Scaffold's drawer open
                [
                  div([],
                      classes: ['w-6', 'h-1', 'bg-current', 'mb-1']
                          .join(' ')), // Hamburger line
                  div([],
                      classes: ['w-6', 'h-1', 'bg-current', 'mb-1']
                          .join(' ')), // Hamburger line
                  div([],
                      classes: ['w-6', 'h-1', 'bg-current']
                          .join(' ')), // Hamburger line
                ],
              ),
          ],
        ),

        // Title (takes center space)
        if (title != null)
          div(
              classes: ['flex-grow', 'text-xl', 'font-semibold', 'text-center']
                  .join(' '),
              [title!]),

        // Actions (e.g., search icon, overflow menu)
        div(
          classes: ['flex', 'items-center', 'gap-2'].join(' '),
          [
            if (actions != null) ...actions!,
            // If no custom actions and end drawer is available, show default end-drawer icon
            if (actions == null && onEndDrawerOpen != null)
              button(
                classes: [
                  'p-2',
                  'rounded-md',
                  'hover:bg-opacity-80',
                  'focus:outline-none'
                ].join(' '),
                events: {
                  'click': (e) => onEndDrawerOpen!()
                }, // Trigger Scaffold's end drawer open
                [
                  div([],
                      classes: ['w-6', 'h-1', 'bg-current', 'mb-1']
                          .join(' ')), // Icon line
                  div([],
                      classes: ['w-6', 'h-1', 'bg-current', 'mb-1']
                          .join(' ')), // Icon line
                  div([], classes: 'w-6 h-1 bg-current'), // Icon line
                ],
              ),
          ],
        ),
      ],
    );
  }
}
