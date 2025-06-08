import 'package:jaspr/jaspr.dart';

import 'package:dart_portfolio/components/components.dart';

import 'package:dart_portfolio/components/counter.dart';

@client
class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Run code depending on the rendering environment.
    if (kIsWeb) {
      print("Hello client");
      // When using @client components there is no default `main()` function on the client where you would normally
      // run any client-side initialization logic. Instead you can put it here, considering this component is only
      // mounted once at the root of your client-side component tree.
    } else {
      print("Hello server");
    }
  }

  @override
  build(BuildContext context) sync* {
    yield div(
      classes:
          'p-8 flex flex-col items-center min-h-screen bg-gray-100 font-sans text-gray-800',
      [
        h1(
            classes: 'text-4xl font-extrabold text-gray-900 mb-8 mt-4',
            [text('Jaspr Flex Layout Demo')]),
        p(classes: 'text-lg text-gray-600 mb-12 max-w-2xl text-center', [
          text(
            'Explore the power of `Column`, `Row`, `Expanded`, and `Flexible` components, ',
          ),
          text(
            'mimicking Flutter\'s layout system with Tailwind CSS for styling.',
          )
        ]),

        // --- Column with Spacing Example ---
        _buildSectionTitle('Column with Spacing (gap)', 'bg-blue-200'),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0, // Creates 16px vertical gap between children
          customClasses: 'p-6 bg-blue-100 rounded-lg shadow-md mb-8 w-80',
          children: [
            _buildDemoBox('Item 1', 'bg-blue-500'),
            _buildDemoBox('Item 2', 'bg-blue-600'),
            _buildDemoBox('Item 3', 'bg-blue-700'),
          ],
        ),

        // --- Row with Spacing Example ---
        _buildSectionTitle('Row with Spacing (gap)', 'bg-green-200'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 12.0, // Creates 12px horizontal gap between children
          customClasses:
              'w-full max-w-xl p-6 bg-green-100 rounded-lg shadow-md mb-8',
          children: [
            _buildDemoBox('Left', 'bg-green-500'),
            _buildDemoBox('Center', 'bg-green-600'),
            _buildDemoBox('Right', 'bg-green-700'),
          ],
        ),

        // --- Column.separated Example ---
        _buildSectionTitle(
            'Column.separated (with Divider Component)', 'bg-purple-200'),
        Column.separated(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          customClasses: 'p-6 bg-purple-100 rounded-lg shadow-md mb-8 w-80',
          children: [
            _buildDemoBox('First Entry', 'bg-indigo-500'),
            _buildDemoBox('Second Entry', 'bg-orange-500'),
            _buildDemoBox('Third Entry', 'bg-pink-500'),
          ],
          separatorBuilder: div(
            classes:
                'h-0.5 w-full bg-gray-400 my-4', // A thicker line separator
            [
              span([text(' --- ')],
                  classes: 'text-center text-xs text-gray-500')
            ],
          ),
        ),

        // --- Row.separated Example ---
        _buildSectionTitle(
            'Row.separated (with Spacer Component)', 'bg-red-200'),
        Row.separated(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          customClasses: 'p-6 bg-red-100 rounded-lg shadow-md mb-8 max-w-xl',
          children: [
            _buildDemoBox('Item A', 'bg-red-500'),
            _buildDemoBox('Item B', 'bg-red-600'),
            _buildDemoBox('Item C', 'bg-red-700'),
          ],
          separatorBuilder: div(
              classes: 'w-px h-8 bg-gray-400 mx-4', // A vertical line separator
              [
                span([text('|')],
                    classes: 'text-xs text-gray-500 -mt-2 -ml-0.5')
              ] // Little trick to center '|'
              ),
        ),

        // --- Flex with Expanded & Flexible Example ---
        _buildSectionTitle('Flex with Expanded & Flexible', 'bg-teal-200'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          customClasses:
              'w-full h-32 bg-teal-100 rounded-lg shadow-md mb-8 max-w-2xl',
          children: [
            _buildDemoBox('Fixed 1', 'bg-teal-500',
                width: 'w-20'), // Fixed width
            Expanded(
              // Takes 1 unit of available space (tight)
              child: _buildDemoBox('Expanded (flex:1, tight)', 'bg-teal-600'),
            ),
            Flexible(
              // Flexible with default flex: 1, fit: loose
              child: _buildDemoBox('Flexible (flex:1, loose)', 'bg-teal-700',
                  minWidth: 'min-w-24'), // min-width to show looseness
            ),
            Flexible(
              // Flexible with flex: 2, fit: tight
              flex: 2,
              fit: FlexFit.tight,
              child: _buildDemoBox('Flexible (flex:2, tight)', 'bg-teal-800'),
            ),
            _buildDemoBox('Fixed 2', 'bg-teal-900',
                width: 'w-20'), // Fixed width
          ],
        ),

        // --- Complex Column Layout Example ---
        _buildSectionTitle(
            'Complex Column Layout (Mix & Match)', 'bg-indigo-200'),
        Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between elements
          crossAxisAlignment: CrossAxisAlignment.center,
          customClasses: 'h-96 w-80 bg-indigo-100 rounded-lg shadow-md mb-8',
          children: [
            _buildDemoBox('Header', 'bg-indigo-500 w-full'),
            Expanded(
              // Middle section takes all remaining space
              child: Column(
                // Nested Column
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.0,
                customClasses: 'bg-indigo-300 w-full h-full p-4',
                children: [
                  _buildDemoBox('Nested Item 1', 'bg-indigo-600'),
                  _buildDemoBox('Nested Item 2', 'bg-indigo-700'),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child:
                        _buildDemoBox('Flexible Content Here', 'bg-indigo-800'),
                  ),
                ],
              ),
            ),
            _buildDemoBox('Footer', 'bg-indigo-500 w-full'),
          ],
        ),

        p(
            classes: 'text-sm text-gray-500 mt-8',
            [text('Demo built with Jaspr and Tailwind CSS.')]),
      ],
    );
  }

  // --- Helper Widgets for Demo ---

  Component _buildSectionTitle(String title, String bgColorClass) {
    return div(
      classes:
          'text-2xl font-bold py-3 px-6 $bgColorClass text-gray-800 rounded-t-lg shadow-inner mt-8 mb-4 w-full max-w-2xl text-center',
      [text(title)],
    );
  }

  Component _buildDemoBox(String label, String bgColorClass,
      {String width = 'w-auto', String minWidth = 'min-w-0'}) {
    return div(
      classes:
          '$bgColorClass text-white p-3 text-center text-sm rounded shadow-sm $width $minWidth',
      [text(label)],
    );
  }
}
