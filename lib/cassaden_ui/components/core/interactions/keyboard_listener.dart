// lib/components/keyboard_listener.dart

import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart';

/// A widget that listens for raw keyboard events.
///
/// It can listen globally on the document or on a specific HTML element.
class KeyboardListener extends StatelessComponent {
  final EventCallback? onKeyUp;
  final EventCallback? onKeyDown;
  final Component child;

  const KeyboardListener(
      {super.key, required this.child, this.onKeyUp, this.onKeyDown});
  @override
  Iterable<Component> build(BuildContext context) {
    // For non-global listeners, Jaspr's `DomComponent` `events` map
    // automatically handles attaching `addEventListener` to the rendered element.
    return [
      DomComponent(
        tag: 'div', // Wrap the child in a div to attach events if not global
        // Using a `Ref` to get a reference to the actual DOM element for potential future use.
        // This is not strictly necessary for just adding events via the `events` map.
        children: [child],
        events: {
          if (onKeyDown != null) 'keydown': (Event e) => onKeyDown,
          if (onKeyUp != null) 'keyup': onKeyUp!,
        },
      ),
    ];
  }
}
