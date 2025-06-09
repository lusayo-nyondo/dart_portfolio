class Rect {
  final double left;
  final double top;
  final double width;
  final double height;
  double get right => left + width;
  double get bottom => top + height;
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
