import 'package:jaspr/jaspr.dart';

enum FlexFit {
  tight,

  loose,
}

class Flexible extends StatelessComponent {
  final Component child;
  final int flex;
  final FlexFit fit;

  const Flexible({
    super.key,
    required this.child,
    this.flex = 1, // Default flex factor (like Flutter)
    this.fit = FlexFit.loose, // Default fit is loose (like Flutter)
  });

  @override
  build(BuildContext context) sync* {
    final List<String> tailwindClasses = [];

    // Apply flex properties based on flex factor and fit
    if (flex == 0) {
      tailwindClasses.add('flex-none'); // flex: 0 0 auto;
    } else {
      // For flex > 0, we need to consider 'fit'
      if (fit == FlexFit.tight) {
        // FlexFit.tight: flex-grow and flex-shrink are both true. Basis 0%
        // In Tailwind, 'flex-1' is flex: 1 1 0%.
        // For flex > 1, we use grow-[X] and shrink-[X] if custom shrink is needed.
        // Tailwind's flex-grow utility is `grow`, `grow-0`, `grow-[value]`
        // Tailwind's flex-shrink utility is `shrink`, `shrink-0`, `shrink-[value]`

        // 'flex-1' covers flex: 1 and tight very well.
        // For flex > 1, we typically just need `grow-[flex_value]`
        if (flex == 1) {
          tailwindClasses.add('flex-1'); // flex: 1 1 0%
        } else {
          tailwindClasses.add('grow-[$flex]'); // flex-grow: <flex>;
          tailwindClasses.add('shrink-0'); // Explicitly not shrinking
          // To ensure it takes minimum initial size before growing,
          // we should also add `basis-0` or `flex-basis: 0;` via inline style if needed.
          // However, `flex-1` implies `basis-0`. For `grow-[X]`, basis is usually `auto` unless specified.
          // For Tight behavior, basis-0 is important to force it to take minimal space first.
          // Let's add inline style for flex-basis for robustness when flex > 1 and tight.
        }
      } else {
        // FlexFit.loose
        // FlexFit.loose: flex-grow is true, flex-shrink is true. Basis auto.
        // Corresponds to 'flex-auto' or just `grow` without a basis.
        // 'flex-auto' is flex: 1 1 auto.
        // If flex is 1, 'flex-auto' is a good fit.
        // If flex > 1, we use `grow-[flex_value]`
        if (flex == 1) {
          tailwindClasses.add('flex-auto'); // flex: 1 1 auto
        } else {
          tailwindClasses.add('grow-[$flex]'); // flex-grow: <flex>;
          tailwindClasses.add('shrink'); // Default shrink behavior
        }
      }
    }

    yield div(
      classes: tailwindClasses.join(' '),
      styles: Styles(
        flex: Flex(basis: Unit.zero),
      ),
      [child],
    );
  }
}
