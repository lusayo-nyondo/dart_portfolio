// lib/components/gesture_detector.dart

import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart';
import 'package:universal_web/js_interop.dart';

import 'dart:math';
import 'dart:async';

// Constants for gesture detection thresholds (unchanged)
const Duration _kTapTimeout = Duration(milliseconds: 300);
const Duration _kDoubleTapTimeout = Duration(milliseconds: 300);
const Duration _kLongPressTimeout = Duration(milliseconds: 500);
const double _kTouchSlop =
    18.0; // Max distance a touch can move and still be a tap/long press
const double _kPanSlop = 10.0; // Min distance before a drag starts

// Type Definitions (unchanged)
typedef GestureTapDownCallback = void Function(TapDownDetails details);
typedef GestureTapUpCallback = void Function(TapUpDetails details);
typedef GestureTapCallback = void Function();
typedef GestureTapCancelCallback = void Function();
typedef GestureDoubleTapCallback = void Function();
typedef GestureLongPressDownCallback = void Function(
    LongPressDownDetails details);
typedef GestureLongPressStartCallback = void Function(
    LongPressStartDetails details);
typedef GestureLongPressMoveUpdateCallback = void Function(
    LongPressMoveUpdateDetails details);
typedef GestureLongPressEndCallback = void Function(
    LongPressEndDetails details);
typedef GestureLongPressCancelCallback = void Function();
typedef GestureLongPressCallback = void Function();
typedef GestureVerticalDragStartCallback = void Function(
    DragStartDetails details);
typedef GestureVerticalDragUpdateCallback = void Function(
    DragUpdateDetails details);
typedef GestureVerticalDragEndCallback = void Function(DragEndDetails details);
typedef GestureHorizontalDragStartCallback = void Function(
    DragStartDetails details);
typedef GestureHorizontalDragUpdateCallback = void Function(
    DragUpdateDetails details);
typedef GestureHorizontalDragEndCallback = void Function(
    DragEndDetails details);
typedef GesturePanStartCallback = void Function(DragStartDetails details);
typedef GesturePanUpdateCallback = void Function(DragUpdateDetails details);
typedef GesturePanEndCallback = void Function(DragEndDetails details);
typedef GestureScaleStartCallback = void Function(ScaleStartDetails details);
typedef GestureScaleUpdateCallback = void Function(ScaleUpdateDetails details);
typedef GestureScaleEndCallback = void Function(ScaleEndDetails details);

// GestureDetector class definition (unchanged, just added here for context)
// ...
class GestureDetector extends StatefulComponent {
  final Component child;
  final EventCallback? onClick;
  final EventCallback? onMouseDown;
  final EventCallback? onMouseUp;
  final EventCallback? onMouseMove;
  final EventCallback? onMouseEnter;
  final EventCallback? onMouseLeave;
  final EventCallback? onPointerDown;
  final EventCallback? onPointerUp;
  final EventCallback? onPointerMove;
  final EventCallback? onDragStart;
  final EventCallback? onDrag;
  final EventCallback? onDragEnd;
  final EventCallback? onContextMenu;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTap;
  final GestureTapCancelCallback? onTapCancel;
  final GestureDoubleTapCallback? onDoubleTap;
  final GestureLongPressDownCallback? onLongPressDown;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressCancelCallback? onLongPressCancel;
  final GestureLongPressCallback? onLongPress;
  final GestureVerticalDragStartCallback? onVerticalDragStart;
  final GestureVerticalDragUpdateCallback? onVerticalDragUpdate;
  final GestureVerticalDragEndCallback? onVerticalDragEnd;
  final GestureHorizontalDragStartCallback? onHorizontalDragStart;
  final GestureHorizontalDragUpdateCallback? onHorizontalDragUpdate;
  final GestureHorizontalDragEndCallback? onHorizontalDragEnd;
  final GesturePanStartCallback? onPanStart;
  final GesturePanUpdateCallback? onPanUpdate;
  final GesturePanEndCallback? onPanEnd;
  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  const GestureDetector({
    super.key,
    required this.child,
    this.onClick,
    this.onMouseDown,
    this.onMouseUp,
    this.onMouseMove,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
    this.onContextMenu,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPressDown,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onLongPressCancel,
    this.onLongPress,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  });

  @override
  State<GestureDetector> createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<GestureDetector> {
  // State for gesture detection
  bool _isPointerDown = false;
  Point<double>? _initialDownPosition;
  Point<double>? _lastMovePosition;
  DateTime? _pointerDownTimestamp;

  // Timers for tap and long press
  Timer? _longPressTimer;
  Timer? _doubleTapTimer;

  // Gesture flags
  bool _isLongPressActive = false;
  bool _isPanActive = false;
  bool _isVerticalDragActive = false;
  bool _isHorizontalDragActive = false;
  final bool _isScaleActive = false; // For basic scale implementation

  // Double tap state
  DateTime? _lastTapEndTime;

  @override
  void dispose() {
    _longPressTimer?.cancel();
    _doubleTapTimer?.cancel();
    super.dispose();
  }

  Point<double> _getGlobalPosition(PointerEvent event) {
    // clientX and clientY are guaranteed to be non-null for PointerEvent.
    return Point(event.clientX.toDouble(), event.clientY.toDouble());
  }

  void _handlePointerDown(Event event) {
    // Call the raw pointerDown callback if provided
    component.onPointerDown?.call(event);

    // Safely check and convert to PointerEvent using isA and toJS
    if (event.isA<PointerEvent>()) {
      final PointerEvent pointerEvent = event as PointerEvent;

      _isPointerDown = true;
      _initialDownPosition = _getGlobalPosition(pointerEvent);
      _lastMovePosition = _initialDownPosition;
      _pointerDownTimestamp = DateTime.now();

      // Tap Down
      component.onTapDown?.call(TapDownDetails(
          globalPosition: _initialDownPosition!, originalEvent: pointerEvent));

      // Long Press Down
      component.onLongPressDown
          ?.call(LongPressDownDetails(globalPosition: _initialDownPosition!));

      // Start long press timer
      _longPressTimer = Timer(_kLongPressTimeout, () {
        if (_isPointerDown &&
            _initialDownPosition != null &&
            !_isPanActive &&
            !_isScaleActive) {
          _isLongPressActive = true;
          component.onLongPressStart?.call(
              LongPressStartDetails(globalPosition: _initialDownPosition!));
          component.onLongPress?.call(); // Simplified completion callback
        }
        _longPressTimer = null;
      });

      // Double Tap detection: Start timer for next tap
      _doubleTapTimer?.cancel(); // Cancel any pending double tap timer
      if (_lastTapEndTime != null &&
          DateTime.now().difference(_lastTapEndTime!) <= _kDoubleTapTimeout) {
        // This is a potential second tap for a double tap. Logic will confirm on pointer up.
      } else {
        // This is the first tap of a potential double tap
        _lastTapEndTime = null; // Clear previous tap end time
      }
    }
  }

  void _handlePointerMove(Event event) {
    // Call the raw pointerMove callback if provided
    component.onPointerMove?.call(event);

    if (_isPointerDown && event.isA<PointerEvent>()) {
      // Use isA
      final PointerEvent pointerEvent = event as PointerEvent;
      final currentPosition = _getGlobalPosition(pointerEvent);
      final Point<double> delta = currentPosition - _lastMovePosition!;
      _lastMovePosition = currentPosition;

      final double totalDistance =
          _initialDownPosition!.distanceTo(currentPosition);

      // Cancel long press if moved too far
      if (_longPressTimer != null && totalDistance > _kTouchSlop) {
        _longPressTimer?.cancel();
        _longPressTimer = null;
        if (!_isLongPressActive) {
          // If long press hadn't started yet
          component.onLongPressCancel?.call();
        }
      }

      // Handle Pan/Drag Start
      if (!_isPanActive && totalDistance > _kPanSlop) {
        _isPanActive = true;
        // Cancel tap/long press if pan starts
        component.onTapCancel?.call();
        component.onLongPressCancel?.call();
        _longPressTimer?.cancel();
        _longPressTimer = null;
        _isLongPressActive = false; // Reset long press state

        final dragStartDetails = DragStartDetails(
          globalPosition: _initialDownPosition!,
          localPosition: _initialDownPosition!, // Simplified for now
        );
        component.onPanStart?.call(dragStartDetails);

        final double absDeltaX =
            (currentPosition.x - _initialDownPosition!.x).abs();
        final double absDeltaY =
            (currentPosition.y - _initialDownPosition!.y).abs();

        if (absDeltaX > absDeltaY && absDeltaX > _kPanSlop) {
          // Horizontal dominance
          _isHorizontalDragActive = true;
          component.onHorizontalDragStart?.call(dragStartDetails);
        } else if (absDeltaY > absDeltaX && absDeltaY > _kPanSlop) {
          // Vertical dominance
          _isVerticalDragActive = true;
          component.onVerticalDragStart?.call(dragStartDetails);
        }

        // Basic scale start (if two pointers are involved in actual scale implementation)
        // This example is single-pointer focused, so scale will not be fully implemented here.
        // if (pointerEvent.pointerId == 0 && pointerEvent.pointers.length > 1) { // Pseudo-code for multi-pointer
        //   _isScaleActive = true;
        //   component.onScaleStart?.call(ScaleStartDetails(globalFocalPoint: _initialDownPosition!, pointerCount: pointerEvent.pointers.length));
        // }
      }

      // Handle Pan/Drag Update
      if (_isPanActive) {
        final DragUpdateDetails details = DragUpdateDetails(
          globalPosition: currentPosition,
          localPosition: currentPosition, // Simplified for now
          delta: delta,
          primaryDelta: (delta.x.abs() > delta.y.abs()) ? delta.x : delta.y,
        );
        component.onPanUpdate?.call(details);
        if (_isHorizontalDragActive) {
          component.onHorizontalDragUpdate?.call(details);
        }
        if (_isVerticalDragActive) {
          component.onVerticalDragUpdate?.call(details);
        }
      }
      // Handle Long Press Move Update (only if long press is active and not yet pan)
      else if (_isLongPressActive && totalDistance <= _kTouchSlop) {
        component.onLongPressMoveUpdate?.call(LongPressMoveUpdateDetails(
          globalPosition: currentPosition,
          localPosition: currentPosition, // Simplified for now
          delta: delta,
        ));
      }
      // Handle Scale Update (multi-pointer logic would go here)
      // if (_isScaleActive) {
      //   component.onScaleUpdate?.call(ScaleUpdateDetails(
      //     globalFocalPoint: currentPosition, localFocalPoint: currentPosition,
      //     scale: 1.0, horizontalScale: 1.0, verticalScale: 1.0, rotation: 0.0,
      //     pointerCount: pointerEvent.pointers.length, // Pseudo-code
      //   ));
      // }
    }
  }

  void _handlePointerUp(Event event) {
    // Call the raw pointerUp callback if provided
    component.onPointerUp?.call(event);

    if (_isPointerDown && event.isA<PointerEvent>()) {
      // Use isA
      final PointerEvent pointerEvent = event as PointerEvent;
      _isPointerDown = false;
      _longPressTimer?.cancel();
      _longPressTimer = null;

      final currentPosition = _getGlobalPosition(pointerEvent);
      final double totalDistance =
          _initialDownPosition!.distanceTo(currentPosition);
      final Duration duration =
          DateTime.now().difference(_pointerDownTimestamp!);

      if (_isPanActive) {
        // End pan/drag gesture
        _isPanActive = false;
        final DragEndDetails details = DragEndDetails(
            globalPosition: currentPosition,
            velocity: Point(0.0, 0.0)); // Simplified velocity
        component.onPanEnd?.call(details);
        if (_isHorizontalDragActive) {
          component.onHorizontalDragEnd?.call(details);
          _isHorizontalDragActive = false;
        }
        if (_isVerticalDragActive) {
          component.onVerticalDragEnd?.call(details);
          _isVerticalDragActive = false;
        }
      } else if (_isLongPressActive) {
        // End long press gesture
        _isLongPressActive = false;
        component.onLongPressEnd?.call(LongPressEndDetails(
            globalPosition: currentPosition, velocity: Point(0.0, 0.0)));
      } else if (totalDistance <= _kTouchSlop && duration <= _kTapTimeout) {
        // It's a tap gesture (or part of a double tap)
        component.onTapUp?.call(TapUpDetails(
            globalPosition: currentPosition, originalEvent: pointerEvent));

        // Double Tap check
        if (_lastTapEndTime != null &&
            DateTime.now().difference(_lastTapEndTime!) <= _kDoubleTapTimeout) {
          component.onDoubleTap?.call();
          _lastTapEndTime = null; // Consume double tap
        } else {
          // This was a single tap, or the first of a double tap
          component.onTap?.call();
          _lastTapEndTime = DateTime.now(); // Store for potential double tap
        }
      } else {
        // If pointer lifted after moving too far or held too long without recognized gesture
        component.onTapCancel?.call();
        component.onLongPressCancel?.call();
      }

      // Handle Scale End (multi-pointer logic would go here)
      // if (_isScaleActive) {
      //   _isScaleActive = false;
      //   component.onScaleEnd?.call(ScaleEndDetails(velocity: Point(0.0, 0.0)));
      // }
    } else {
      // Pointer was not initially down or unexpected event type, cancel
      _handlePointerCancel(event); // Treat as cancellation
    }
  }

  void _handlePointerCancel(Event event) {
    // This is called when the browser cancels the pointer sequence (e.g., system alert)
    // or when the pointer leaves the element if _isPointerDown is true.
    if (_isPointerDown && event.isA<PointerEvent>()) {
      // Use isA
      _isPointerDown = false;
      _longPressTimer?.cancel();
      _longPressTimer = null;

      component.onTapCancel?.call();
      component.onLongPressCancel?.call();

      final currentPosition = _lastMovePosition ??
          _initialDownPosition!; // Fallback to last known position
      if (_isPanActive) {
        _isPanActive = false;
        component.onPanEnd?.call(DragEndDetails(
            globalPosition: currentPosition,
            velocity: Point(0.0, 0.0))); // Simplified
        if (_isHorizontalDragActive) {
          _isHorizontalDragActive = false;
          component.onHorizontalDragEnd?.call(DragEndDetails(
              globalPosition: currentPosition, velocity: Point(0.0, 0.0)));
        }
        if (_isVerticalDragActive) {
          _isVerticalDragActive = false;
          component.onVerticalDragEnd?.call(DragEndDetails(
              globalPosition: currentPosition, velocity: Point(0.0, 0.0)));
        }
      }
      if (_isLongPressActive) {
        _isLongPressActive = false;
        component.onLongPressEnd?.call(LongPressEndDetails(
            globalPosition: currentPosition,
            velocity: Point(0.0, 0.0))); // Simplified
      }
      // if (_isScaleActive) { ... call scaleEnd and set _isScaleActive = false; }
    }
  }

  // Handle pointer leaving the element while pressed (cancels current gestures)
  void _handlePointerLeave(Event event) {
    component.onMouseLeave?.call(event); // Call raw mouse leave if provided
    if (event.isA<PointerEvent>() && _isPointerDown) {
      _handlePointerCancel(event); // Treat leaving while down as a cancellation
    }
  }

  @override
  Iterable<Component> build(BuildContext context) {
    return [
      DomComponent(
        tag: 'div',
        attributes: {
          if (component.onDragStart != null ||
              component.onDrag != null ||
              component.onDragEnd != null ||
              component.onPanStart != null ||
              component.onPanUpdate != null ||
              component.onPanEnd != null ||
              component.onVerticalDragStart != null ||
              component.onHorizontalDragStart != null)
            'draggable': 'true', // Enables native browser drag-and-drop
        },
        children: [component.child],
        events: {
          // Use pointer events for robust gesture detection and internal logic
          'pointerdown': _handlePointerDown,
          'pointerup': _handlePointerUp,
          'pointermove': _handlePointerMove,
          'pointerleave':
              _handlePointerLeave, // When pointer leaves the element
          'pointercancel':
              _handlePointerCancel, // When browser cancels pointer sequence

          // Original raw DOM events (still included for maximum compatibility/redundancy)
          // Note: Some of these might conflict or be redundant with pointer event logic.
          if (component.onClick != null) 'click': component.onClick!,
          if (component.onMouseDown != null)
            'mousedown': component.onMouseDown!,
          if (component.onMouseUp != null) 'mouseup': component.onMouseUp!,
          if (component.onMouseMove != null)
            'mousemove': component.onMouseMove!,
          if (component.onMouseEnter != null)
            'mouseenter': component.onMouseEnter!,
          // 'mouseleave' is handled by _handlePointerLeave
          if (component.onDragStart != null)
            'dragstart': component.onDragStart!,
          if (component.onDrag != null) 'drag': component.onDrag!,
          if (component.onDragEnd != null) 'dragend': component.onDragEnd!,
          if (component.onContextMenu != null)
            'contextmenu': component.onContextMenu!,
        },
      ),
    ];
  }
}

/// Details for a pointer down event.
class TapDownDetails {
  /// The global position at which the pointer contacted the screen.
  final Point<double> globalPosition;

  /// The specific pointer event that triggered this down.
  final PointerEvent originalEvent;
  TapDownDetails({required this.globalPosition, required this.originalEvent});
}

/// Details for a pointer up event.
class TapUpDetails {
  /// The global position at which the pointer ceased to contact the screen.
  final Point<double> globalPosition;

  /// The specific pointer event that triggered this up.
  final PointerEvent originalEvent;
  TapUpDetails({required this.globalPosition, required this.originalEvent});
}

/// Details for a long press down event (when the pointer first contacts).
class LongPressDownDetails {
  final Point<double> globalPosition;
  LongPressDownDetails({required this.globalPosition});
}

/// Details for a long press start event (after the long press timeout).
class LongPressStartDetails {
  final Point<double> globalPosition;
  LongPressStartDetails({required this.globalPosition});
}

/// Details for a long press move update event.
class LongPressMoveUpdateDetails {
  final Point<double> globalPosition;
  final Point<double>
      localPosition; // For convenience, often same as global in simple cases
  final Point<double> delta; // Change in position since last update
  LongPressMoveUpdateDetails({
    required this.globalPosition,
    required this.localPosition,
    required this.delta,
  });
}

/// Details for a long press end event.
class LongPressEndDetails {
  final Point<double> globalPosition;
  final Point<double> velocity; // Simplified velocity (x and y components)
  LongPressEndDetails({required this.globalPosition, required this.velocity});
}

/// Details for a drag start event.
class DragStartDetails {
  final Point<double> globalPosition;
  final Point<double> localPosition; // Often same as global in simple cases
  DragStartDetails({required this.globalPosition, required this.localPosition});
}

/// Details for a drag update event.
class DragUpdateDetails {
  final Point<double> globalPosition;
  final Point<double> localPosition; // Often same as global in simple cases
  final Point<double> delta; // Change in position since last update
  final double primaryDelta; // Simplified: usually either delta.x or delta.y
  DragUpdateDetails({
    required this.globalPosition,
    required this.localPosition,
    required this.delta,
    required this.primaryDelta,
  });
}

/// Details for a drag end event.
class DragEndDetails {
  final Point<double> globalPosition;
  final Point<double> velocity; // Simplified velocity (x and y components)
  DragEndDetails({required this.globalPosition, required this.velocity});
}

/// Details for a scale start event.
class ScaleStartDetails {
  final Point<double> globalFocalPoint; // Center of the multi-touch gesture
  final int pointerCount; // Number of pointers involved
  ScaleStartDetails({required this.globalFocalPoint, this.pointerCount = 1});
}

/// Details for a scale update event.
class ScaleUpdateDetails {
  final Point<double> globalFocalPoint;
  final Point<double> localFocalPoint;
  final double scale; // Current scale factor (e.g., 1.0 is no scale)
  final double horizontalScale; // Horizontal scale factor
  final double verticalScale; // Vertical scale factor
  final double rotation; // Rotation in radians
  final int pointerCount; // Number of pointers involved
  ScaleUpdateDetails({
    required this.globalFocalPoint,
    required this.localFocalPoint,
    this.scale = 1.0,
    this.horizontalScale = 1.0,
    this.verticalScale = 1.0,
    this.rotation = 0.0,
    this.pointerCount = 1,
  });
}

/// Details for a scale end event.
class ScaleEndDetails {
  final Point<double> velocity; // Simplified velocity of the gesture
  ScaleEndDetails({required this.velocity});
}
