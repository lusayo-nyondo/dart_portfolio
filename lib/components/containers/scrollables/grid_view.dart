import 'package:jaspr/jaspr.dart';

import 'scroll_direction.dart';

/// Abstract base for grid delegates.
/// In Jaspr, this mostly helps structure input for CSS Grid.
abstract class SliverGridDelegate {
  const SliverGridDelegate();
  // This would ideally have methods to calculate layout, but for CSS
  // we primarily convert properties.
}

/// A grid delegate that specifies a fixed number of children in the cross axis.
class SliverGridDelegateWithFixedCrossAxisCount extends SliverGridDelegate {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const SliverGridDelegateWithFixedCrossAxisCount({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
  });

  @override
  bool operator ==(Object other) =>
      other is SliverGridDelegateWithFixedCrossAxisCount &&
      crossAxisCount == other.crossAxisCount &&
      mainAxisSpacing == other.mainAxisSpacing &&
      crossAxisSpacing == other.crossAxisSpacing &&
      childAspectRatio == other.childAspectRatio;

  @override
  int get hashCode => Object.hash(
      crossAxisCount, mainAxisSpacing, crossAxisSpacing, childAspectRatio);
}

/// A scrollable grid of widgets.
///
/// This component provides a basic scrollable grid for its children.
/// For very large grids, consider a custom virtualization solution
/// as this implementation renders all children upfront.
class GridView extends StatelessComponent {
  final List<Component> children;
  final ScrollDirection scrollDirection;
  final SliverGridDelegate gridDelegate;
  final Spacing? padding;

  const GridView({
    required this.children,
    required this.gridDelegate,
    this.scrollDirection = ScrollDirection.vertical,
    this.padding,
    super.key,
  }) : assert(gridDelegate is SliverGridDelegateWithFixedCrossAxisCount,
            'Only SliverGridDelegateWithFixedCrossAxisCount is currently supported for GridView in Jaspr.');

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> containerStyles = {
      'display': 'grid',
      'overflow': 'auto', // Always auto for grid to allow scrolling
      'height': '100%',
      'width': '100%',
    };

    if (padding != null) {
      containerStyles['padding-top'] = '${padding!.top}px';
      containerStyles['padding-right'] = '${padding!.right}px';
      containerStyles['padding-bottom'] = '${padding!.bottom}px';
      containerStyles['padding-left'] = '${padding!.left}px';
    }

    if (gridDelegate is SliverGridDelegateWithFixedCrossAxisCount) {
      final delegate =
          gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      containerStyles['gap'] =
          '${delegate.mainAxisSpacing}px ${delegate.crossAxisSpacing}px';

      if (scrollDirection == ScrollDirection.vertical) {
        // Fixed cross-axis count (columns) for vertical scrolling
        containerStyles['grid-template-columns'] =
            'repeat(${delegate.crossAxisCount}, 1fr)';
        // Optional: Aspect ratio on grid items. Needs to be applied to children.
        // Or using CSS `aspect-ratio` on the grid item itself.
        // For simplicity, we assume child's inherent sizing or apply aspect-ratio to direct children.
      } else {
        // Fixed cross-axis count (rows) for horizontal scrolling
        containerStyles['grid-template-rows'] =
            'repeat(${delegate.crossAxisCount}, 1fr)';
        containerStyles['grid-auto-flow'] = 'column'; // Flow horizontally
      }
    }

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: containerStyles),
      children: [
        for (final child in children)
          DomComponent(
            tag: 'div',
            styles: Styles(raw: {
              // Apply aspect ratio to each child if specified
              if (gridDelegate is SliverGridDelegateWithFixedCrossAxisCount)
                'aspect-ratio':
                    '${(gridDelegate as SliverGridDelegateWithFixedCrossAxisCount).childAspectRatio}',
            }),
            children: [child],
          )
      ],
    );
  }
}

// Example Usage:
// GridView(
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 3,
//     mainAxisSpacing: 10,
//     crossAxisSpacing: 10,
//     childAspectRatio: 1.0, // Square items
//   ),
//   padding: Spacing.all(10),
//   children: [
//     for (int i = 0; i < 30; i++)
//       Container(
//         color: i.isEven ? Color('orange') : Color('darkorange'),
//         child: Center(child: Text('$i')),
//       ),
//   ],
// )

// GridView(
//   scrollDirection: ScrollDirection.horizontal, // Horizontal grid
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2, // 2 rows for horizontal scrolling
//     mainAxisSpacing: 10,
//     crossAxisSpacing: 10,
//     childAspectRatio: 1.5, // Wider than tall items
//   ),
//   padding: Spacing.all(10),
//   children: [
//     for (int i = 0; i < 20; i++)
//       Container(
//         color: i.isEven ? Color('teal') : Color('darkteal'),
//         child: Center(child: Text('$i')),
//       ),
//   ],
// )
