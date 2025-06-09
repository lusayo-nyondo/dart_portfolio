import 'package:jaspr/jaspr.dart';

import 'flexbox.dart';

class Column extends Flexbox {
  // Default Column constructor (with spacing for gap)
  const Column({
    super.key,
    required super.children,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    super.customClasses,
    super.spacing, // Directly maps to the Flex's spacing
  }) : super(); // Call the private constructor of Flex

  // Column.separated factory constructor
  factory Column.separated({
    Key? key,
    required Iterable<Component> children,
    required Component separatorBuilder, // The actual separator component
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    String? customClasses,
  }) {
    final List<Component> separatedChildren = [];
    final List<Component> childrenList = children.toList();

    for (int i = 0; i < childrenList.length; i++) {
      separatedChildren.add(childrenList[i]);
      if (i < childrenList.length - 1) {
        separatedChildren.add(separatorBuilder);
      }
    }

    return Column(
      key: key,
      children: separatedChildren,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      customClasses: customClasses,
      spacing: null,
    );
  }

  @override
  String get directionClass => 'flex-col';
}
