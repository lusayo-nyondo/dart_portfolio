// lib/components/base_button.dart
import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart'; // Ensure this import is correct if you're using it

class ButtonStyle {
  final String? baseClasses;
  final String? hoverClasses;
  final String? focusClasses;
  final String? activeClasses;
  final String? disabledClasses;
  final String? textClasses; // For text styling (color, font-weight)

  const ButtonStyle({
    this.baseClasses,
    this.hoverClasses,
    this.focusClasses,
    this.activeClasses,
    this.disabledClasses,
    this.textClasses,
  });

  // Factory methods for common styles (e.g., primary, secondary) could be added here
  // For now, we'll define styles directly in each button class.
}

// Duration for long press detection
const Duration _kLongPressTimeout = Duration(milliseconds: 500);

// Abstract base class for all button types
abstract class BaseButton extends StatefulComponent {
  final Component? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final bool enabled;

  const BaseButton._({
    super.key,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.enabled = true,
  });

  // Abstract method to get the default ButtonStyle for each concrete button type
  ButtonStyle _resolveDefaultStyle();

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  Timer? _longPressTimer;
  bool _isLongPressing = false;
  bool _isHovering = false; // To track hover state for styling
  bool _isFocused = false; // To track focus state for styling
  bool _isActive = false; // To track active state (mouse down)

  @override
  void dispose() {
    _longPressTimer?.cancel();
    super.dispose();
  }

  void _handleMouseDown(Event event) {
    if (!component.enabled) return;
    setState(() {
      _isActive = true;
    });
    if (component.onLongPress != null) {
      _longPressTimer = Timer(_kLongPressTimeout, () {
        if (_isActive) {
          // Ensure still active (mouse is still down)
          _isLongPressing = true;
          component.onLongPress!();
        }
      });
    }
  }

  void _handleMouseUp(Event event) {
    if (!component.enabled) return;
    _longPressTimer?.cancel();
    _longPressTimer = null;
    if (_isActive && !_isLongPressing && component.onPressed != null) {
      // Only call onPressed if it was a short press (not a long press)
      component.onPressed!();
    }
    setState(() {
      _isActive = false;
    });
    _isLongPressing = false; // Reset for next interaction
  }

  void _handleMouseLeave(Event event) {
    if (!component.enabled) return;
    _longPressTimer?.cancel();
    _longPressTimer = null;
    setState(() {
      _isActive = false;
      _isHovering = false;
    });
    _isLongPressing = false;
  }

  void _handleMouseEnter(Event event) {
    if (!component.enabled) return;
    setState(() {
      _isHovering = true;
    });
  }

  void _handleFocus(Event event) {
    if (!component.enabled) return;
    setState(() {
      _isFocused = true;
    });
  }

  void _handleBlur(Event event) {
    setState(() {
      _isFocused = false;
    });
  }

  String _buildClasses() {
    final ButtonStyle resolvedStyle =
        component.style ?? component._resolveDefaultStyle();
    final List<String> classes = [];

    // Base classes
    if (resolvedStyle.baseClasses != null) {
      classes.add(resolvedStyle.baseClasses!);
    }

    // State-specific classes
    // Note: Tailwind utility classes already contain their prefixes (e.g., 'hover:shadow-lg')
    // We simply add them to the list if the state matches.
    if (!component.enabled) {
      if (resolvedStyle.disabledClasses != null) {
        classes.add(resolvedStyle.disabledClasses!);
      }
    } else {
      if (_isHovering && resolvedStyle.hoverClasses != null) {
        classes.add(resolvedStyle.hoverClasses!);
      }
      if (_isFocused && resolvedStyle.focusClasses != null) {
        classes.add(resolvedStyle.focusClasses!);
      }
      if (_isActive && resolvedStyle.activeClasses != null) {
        classes.add(resolvedStyle.activeClasses!);
      }
    }

    // Text classes applied to the child content (if it's text)
    if (resolvedStyle.textClasses != null) {
      classes.add(resolvedStyle.textClasses!);
    }

    return classes.join(' ');
  }

  @override
  build(BuildContext context) sync* {
    yield button(
      classes: _buildClasses(),
      attributes: {
        if (!component.enabled) 'disabled': 'true',
      },
      events: {
        'mousedown': _handleMouseDown,
        'mouseup': _handleMouseUp,
        'mouseleave': _handleMouseLeave,
        'mouseenter': _handleMouseEnter,
        'focus': _handleFocus,
        'blur': _handleBlur,
        // Using `ontouchend` for mobile long press detection.
        // `ontouchstart` is handled by mousedown, but touch end is separate.
        'touchend': _handleMouseUp,
        'touchcancel': _handleMouseUp, // Treat touchcancel like mouse up
      },
      [component.child ?? text('')], // Ensure there's always a child
    );
  }
}

class Button extends BaseButton {
  const Button({
    super.key,
    required super.child,
    super.onPressed,
    super.onLongPress,
    super.enabled,
    super.style, // Allows complete custom styling
  }) : super._();

  @override
  ButtonStyle _resolveDefaultStyle() {
    return const ButtonStyle(
      // --- CORRECTED: Added 'cursor-pointer' ---
      baseClasses:
          'rounded-md py-2 px-4 border border-transparent text-center text-sm transition-all shadow-md cursor-pointer',
      hoverClasses: 'hover:shadow-lg',
      focusClasses: 'focus:shadow-none',
      activeClasses: 'active:shadow-none',
      disabledClasses:
          'disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none',
      textClasses: 'text-gray-800', // Default text color
    );
  }
}

class FilledButton extends BaseButton {
  const FilledButton({
    super.key,
    required super.child,
    super.onPressed,
    super.onLongPress,
    super.enabled,
    super.style,
  }) : super._();

  @override
  ButtonStyle _resolveDefaultStyle() {
    return const ButtonStyle(
      // --- CORRECTED: Added 'cursor-pointer' ---
      baseClasses:
          'rounded-md py-2 px-4 border border-transparent text-center text-sm transition-all shadow-md '
          'bg-slate-800 cursor-pointer', // Dark background
      hoverClasses: 'hover:bg-slate-700 hover:shadow-lg',
      focusClasses: 'focus:bg-slate-700 focus:shadow-none',
      activeClasses: 'active:bg-slate-700 active:shadow-none',
      disabledClasses:
          'disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none',
      textClasses: 'text-white', // White text
    );
  }
}

class ElevatedButton extends BaseButton {
  const ElevatedButton({
    super.key,
    required super.child,
    super.onPressed,
    super.onLongPress,
    super.enabled,
    super.style,
  }) : super._();

  @override
  ButtonStyle _resolveDefaultStyle() {
    return const ButtonStyle(
      // --- CORRECTED: Added 'cursor-pointer' ---
      baseClasses:
          'rounded-md py-2 px-4 border border-transparent text-center text-sm transition-all shadow-md '
          'bg-blue-600 cursor-pointer', // Blue background, initial shadow
      hoverClasses:
          'hover:bg-blue-700 hover:shadow-xl', // Increased shadow on hover
      focusClasses:
          'focus:bg-blue-700 focus:shadow-md', // Focus retains some shadow
      activeClasses:
          'active:bg-blue-800 active:shadow-sm', // Reduced shadow on active/pressed
      disabledClasses:
          'disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none',
      textClasses: 'text-white',
    );
  }
}

class TextButton extends BaseButton {
  const TextButton({
    super.key,
    required super.child,
    super.onPressed,
    super.onLongPress,
    super.enabled,
    super.style,
  }) : super._();

  @override
  ButtonStyle _resolveDefaultStyle() {
    return const ButtonStyle(
      // --- CORRECTED: Added 'cursor-pointer' ---
      baseClasses:
          'rounded-md py-2 px-4 border border-transparent text-center text-sm transition-colors cursor-pointer',
      hoverClasses: 'hover:bg-gray-200', // Subtle background on hover
      focusClasses: 'focus:bg-gray-200',
      activeClasses: 'active:bg-gray-300',
      disabledClasses: 'disabled:pointer-events-none disabled:opacity-50',
      textClasses: 'text-blue-600', // Primary text color
    );
  }
}

class OutlinedButton extends BaseButton {
  const OutlinedButton({
    super.key,
    required super.child,
    super.onPressed,
    super.onLongPress,
    super.enabled,
    super.style,
  }) : super._();

  @override
  ButtonStyle _resolveDefaultStyle() {
    return const ButtonStyle(
      // --- CORRECTED: Added 'cursor-pointer' ---
      baseClasses:
          'rounded-md py-2 px-4 border text-center text-sm transition-colors '
          'border-blue-600 cursor-pointer', // Blue border
      hoverClasses: 'hover:bg-blue-50', // Light background on hover
      focusClasses:
          'focus:ring-2 focus:ring-blue-300 focus:outline-none', // Focus ring
      activeClasses: 'active:bg-blue-100',
      disabledClasses:
          'disabled:pointer-events-none disabled:opacity-50 disabled:border-gray-400',
      textClasses: 'text-blue-600', // Primary text color
    );
  }
}
