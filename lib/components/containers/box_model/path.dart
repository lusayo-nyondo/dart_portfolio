import 'package:jaspr/jaspr.dart';

import 'rect.dart';
import 'offset.dart';

import '../../extensions/units.dart';

class Path {
  final String _svgPathData;

  Path.rect(Rect rect)
      : _svgPathData =
            'M${rect.left},${rect.top} L${rect.right},${rect.top} L${rect.right},${rect.bottom} L${rect.left},${rect.bottom} Z';
  Path.oval(Rect rect)
      : _svgPathData =
            'M ${rect.left + (rect.width / 2).px},${rect.top} A ${rect.width / 2},${rect.height / 2} 0 1,0 ${rect.left + (rect.width / 2).px},${rect.bottom} A ${rect.width / 2},${rect.height / 2} 0 1,0 ${rect.left + (rect.width / 2).px},${rect.top} Z';
  Path.arcToPoint({
    required Offset arcStartPoint,
    required Offset arcEndPoint,
    required double radiusX,
    required double radiusY,
    double rotation = 0,
    bool largeArc = false,
    bool sweep = false,
  }) : _svgPathData =
            'M ${arcStartPoint.dx},${arcStartPoint.dy} A $radiusX,$radiusY $rotation ${largeArc ? 1 : 0},${sweep ? 1 : 0} ${arcEndPoint.dx},${arcEndPoint.dy}';

  Path.lineTo(Offset point) : _svgPathData = 'L ${point.dx},${point.dy}';
  Path.moveTo(Offset point) : _svgPathData = 'M ${point.dx},${point.dy}';
  Path.close() : _svgPathData = 'Z';

  // For simplicity, a constructor that takes raw SVG path data.
  Path.fromSvgPathData(this._svgPathData);

  String toSvgPathData() => _svgPathData;
}
