import 'package:jaspr/jaspr.dart';

part 'app_bar.dart';
part 'drawer.dart';
part 'floating_action_button.dart';

const String surfaceColorVariable = '--surface-color';

/// A basic Scaffold widget mimicking Flutter's layout for Jaspr web applications.
///
/// Provides a consistent visual structure with a top app bar, body,
/// optional floating action button, bottom navigation bar, and drawers.
class Scaffold extends StatefulComponent {
  /// An app bar to display at the top of the scaffold.
  final AppBar? appBar;

  /// The primary content of the scaffold.
  final Component body;

  /// A button displayed floating above the body, in the bottom right corner.
  final FloatingActionButton? floatingActionButton;

  /// A navigation bar displayed at the bottom of the scaffold.
  final Component? bottomNavigationBar;

  /// A panel displayed to the left of the body, closing upon tapping the backdrop.
  final Drawer? drawer;

  /// A panel displayed to the right of the body, closing upon tapping the backdrop.
  final Drawer? endDrawer;

  /// The background color of the scaffold.
  final Color? backgroundColor;

  const Scaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
  });

  @override
  State<Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<Scaffold> {
  bool _isDrawerOpen = false;
  bool _isEndDrawerOpen = false;

  void _openDrawer() {
    setState(() {
      _isDrawerOpen = true;
      _isEndDrawerOpen = false; // Close other drawer if open
    });
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
  }

  void _openEndDrawer() {
    setState(() {
      _isEndDrawerOpen = true;
      _isDrawerOpen = false; // Close other drawer if open
    });
  }

  void _closeEndDrawer() {
    setState(() {
      _isEndDrawerOpen = false;
    });
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // The main scaffold container, acting as the layout root
    yield div(
      classes: ['relative', 'flex', 'flex-col', 'min-h-screen'].join(' '),
      styles: Styles(raw: {
        surfaceColorVariable: '#fff',
      }),
      [
        // 1. App Bar (fixed at the top, if provided)
        if (component.appBar != null)
          component.appBar!.copyWith(
            // Pass callbacks to the AppBar so it can trigger drawer actions
            onDrawerOpen: component.drawer != null ? _openDrawer : null,
            onEndDrawerOpen:
                component.endDrawer != null ? _openEndDrawer : null,
          ),

        // 2. Body (takes up the remaining flexible space and handles its own scrolling)
        div(
          classes: 'flex-grow overflow-y-auto',
          [component.body],
        ),

        // 3. Bottom Navigation Bar (fixed at the bottom, if provided)
        if (component.bottomNavigationBar != null)
          component.bottomNavigationBar!,
      ],
    );

    // 4. Drawers and Overlay (rendered as a separate overlay on top of the main content)
    // These are yielded separately from the main scaffold div to ensure they render on top
    // with fixed positioning and z-indexing.

    // Overlay backdrop for drawers: appears when a drawer is open
    if (_isDrawerOpen || _isEndDrawerOpen) {
      yield div(
        [],
        classes: [
          'fixed', 'inset-0', 'bg-black',
          'z-40', // Fixed to cover entire viewport, high z-index
          'transition-opacity',
          'duration-300', // Smooth transition for opacity
          'opacity-50', // Semi-transparent black backdrop
        ].join(' '),
        styles: Styles(backgroundColor: component.backgroundColor),
        events: {
          // Close whichever drawer is open when backdrop is clicked
          'click': (e) {
            if (_isDrawerOpen) _closeDrawer();
            if (_isEndDrawerOpen) _closeEndDrawer();
          }
        },
      );
    }

    // Left Drawer (conditionally rendered and animated)
    if (component.drawer != null) {
      yield component.drawer!.copyWith(
        isOpen: _isDrawerOpen,
        onClose: _closeDrawer,
      );
    }

    // Right End Drawer (conditionally rendered and animated)
    if (component.endDrawer != null) {
      yield component.endDrawer!.copyWith(
        isOpen: _isEndDrawerOpen,
        onClose: _closeEndDrawer,
        isEndDrawer: true, // Signal it's an end drawer for correct positioning
      );
    }

    // 5. Floating Action Button (fixed position, rendered on top)
    if (component.floatingActionButton != null) {
      yield component.floatingActionButton!;
    }
  }
}
