import 'package:jaspr/jaspr.dart';

import '../../extensions/units.dart';

class Rect {
  final Unit left;
  final Unit top;
  final Unit width;
  final Unit height;
  Unit get right => (left + width).px;
  Unit get bottom => (top + height).px;
  const Rect.fromLTWH(this.left, this.top, this.width, this.height);
  @override
  bool operator ==(Object other) =>
      other is Rect &&
      left == other.left &&
      top == other.top &&
      width == other.width &&
      height == other.height;
  @override
  int get hashCode => Object.hash(left, top, width, height);
}
