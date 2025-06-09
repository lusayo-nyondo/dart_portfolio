import 'package:jaspr/jaspr.dart';

import 'scroll_direction.dart'; // Assuming scroll_direction.dart is in the same folder

/// A scrollable list of widgets arranged linearly.
///
/// This component provides a basic scrollable area for its children.
/// For very large lists, consider a custom virtualization solution
/// as this implementation renders all children upfront.
class ListView extends StatelessComponent {
  final List<Component> children;
  final ScrollDirection scrollDirection;
  final bool reverse; // Not fully implemented for CSS, but good to have
  final bool shrinkWrap; // Not fully implemented for CSS
  final double?
      itemExtent; // For fixed-size items, allows optimization potentially
  final Spacing? padding;

  const ListView({
    required this.children,
    this.scrollDirection = ScrollDirection.vertical,
    this.reverse = false,
    this.shrinkWrap = false, // `shrinkWrap` often means content-sized scrolling
    this.itemExtent, // More for Flutter's rendering optimization
    this.padding,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final Map<String, String> containerStyles = {
      'display': 'flex',
      'overflow': scrollDirection == ScrollDirection.vertical
          ? 'auto'
          : 'hidden', // Auto for primary scroll axis
      'overflow-x': scrollDirection == ScrollDirection.horizontal
          ? 'auto'
          : 'hidden', // Horizontal scroll
      'overflow-y': scrollDirection == ScrollDirection.vertical
          ? 'auto'
          : 'hidden', // Vertical scroll
      'flex-direction':
          scrollDirection == ScrollDirection.vertical ? 'column' : 'row',
      'position':
          'relative', // For scrollbar styling or potential positioned children
      'height':
          '100%', // Assume it fills parent height, or provide explicit height
      'width': '100%', // Assume it fills parent width
    };

    if (itemExtent != null) {
      // If itemExtent is provided, we can apply specific sizing to children.
      // For flex items, this means flex-basis.
      final String itemSizeProp =
          scrollDirection == ScrollDirection.vertical ? 'height' : 'width';
      // Note: This applies to ALL children. For varying sizes, remove itemExtent.
      // Or you might need to apply specific styles to children individually.
      containerStyles['$itemSizeProp-min'] = '${itemExtent}px';
      containerStyles['$itemSizeProp-max'] = '${itemExtent}px';
    }

    if (padding != null) {
      containerStyles['padding-top'] = '${padding!.top}px';
      containerStyles['padding-right'] = '${padding!.right}px';
      containerStyles['padding-bottom'] = '${padding!.bottom}px';
      containerStyles['padding-left'] = '${padding!.left}px';
    }

    // `shrinkWrap` would typically mean the scrollable takes only as much space
    // as its children. In CSS, this is often `display: inline-flex` or `fit-content`
    // combined with `max-height`/`max-width`. For simple scrollables,
    // explicitly defining width/height for the parent is usually required.
    // For this basic implementation, we assume it fills its parent unless
    // explicit sizing is provided externally.

    yield DomComponent(
      tag: 'div',
      styles: Styles(raw: containerStyles),
      children: children,
    );
  }
}

// Example Usage:
// ListView(
//   scrollDirection: ScrollDirection.vertical,
//   padding: Spacing.all(10),
//   children: [
//     for (int i = 0; i < 20; i++)
//       Container(
//         height: 50,
//         color: i.isEven ? Color('lightblue') : Color('lightgray'),
//         child: Center(child: Text('Item $i')),
//       ),
//   ],
// )

// ListView(
//   scrollDirection: ScrollDirection.horizontal,
//   padding: Spacing.all(10),
//   children: [
//     for (int i = 0; i < 10; i++)
//       Container(
//         width: 100,
//         color: i.isEven ? Color('lightcoral') : Color('salmon'),
//         child: Center(child: Text('Item $i')),
//       ),
//   ],
// )
