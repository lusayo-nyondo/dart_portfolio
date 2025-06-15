import 'package:jaspr/jaspr.dart';

export 'expanded.dart';
export 'flexible.dart';
export 'row.dart';
export 'column.dart';
export 'intrinsic_height.dart';
export 'intrinsic_width.dart';

enum MainAxisAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

enum CrossAxisAlignment {
  start,
  end,
  center,
  stretch,
  baseline,
}

enum MainAxisSize {
  min,
  max,
}

abstract class Flexbox extends StatelessComponent {
  final Iterable<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final String? customClasses;
  final Unit? spacing; // For gap utility

  // Protected constructor to be used by subclasses
  const Flexbox({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.customClasses,
    this.spacing,
  });

  // Abstract method to get the direction-specific flex class ('flex-col' or 'flex-row')
  String get directionClass;

  @override
  build(BuildContext context) sync* {
    final List<String> tailwindClasses = ['flex', directionClass];

    // Apply mainAxisAlignment
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        tailwindClasses.add('justify-start');
        break;
      case MainAxisAlignment.end:
        tailwindClasses.add('justify-end');
        break;
      case MainAxisAlignment.center:
        tailwindClasses.add('justify-center');
        break;
      case MainAxisAlignment.spaceBetween:
        tailwindClasses.add('justify-between');
        break;
      case MainAxisAlignment.spaceAround:
        tailwindClasses.add('justify-around');
        break;
      case MainAxisAlignment.spaceEvenly:
        tailwindClasses.add('justify-evenly');
        break;
    }

    // Apply crossAxisAlignment
    switch (crossAxisAlignment) {
      case CrossAxisAlignment.start:
        tailwindClasses.add('items-start');
        break;
      case CrossAxisAlignment.end:
        tailwindClasses.add('items-end');
        break;
      case CrossAxisAlignment.center:
        tailwindClasses.add('items-center');
        break;
      case CrossAxisAlignment.stretch:
        tailwindClasses.add('items-stretch');
        break;
      case CrossAxisAlignment.baseline:
        tailwindClasses.add(
            'items-baseline'); // Baseline is relevant for both rows and columns (text)
        break;
    }

    // Apply mainAxisSize
    switch (mainAxisSize) {
      case MainAxisSize.min:
        if (directionClass == 'flex-col') {
          tailwindClasses.add('w-min');
          tailwindClasses.add('h-min');
        } else {
          // flex-row
          tailwindClasses.add('w-min');
          tailwindClasses.add('h-min');
        }
        break;
      case MainAxisSize.max:
        if (directionClass == 'flex-col') {
          tailwindClasses.add('w-full');
          tailwindClasses.add('h-full');
        } else {
          // flex-row
          tailwindClasses.add('w-full');
          tailwindClasses.add('h-full');
        }
        break;
    }

    // Add any custom classes if provided
    if (customClasses != null) {
      tailwindClasses.add(customClasses!);
    }

    yield div(
      classes: tailwindClasses.join(' '),
      styles: Styles(
          gap: spacing != null
              ? Gap(
                  row: directionClass == 'flex-col' ? spacing : null,
                  column: directionClass == 'flex-row' ? spacing : null)
              : null),
      List.from(children),
    );
  }
}
