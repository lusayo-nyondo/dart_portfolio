part of 'tailwindcss.dart';

// Source: https://tailwindcss.com/docs/customizing-colors
const Map<String, String> _tailwindHexCodes = {
  // --- Grayscale ---
  'slate-50': 'f8fafc',
  'slate-100': 'f1f5f9',
  'slate-200': 'e2e8f0',
  'slate-300': 'cbd5e1',
  'slate-400': '94a3b8',
  'slate-500': '64748b',
  'slate-600': '475569',
  'slate-700': '334155',
  'slate-800': '1e293b',
  'slate-900': '0f172a',
  'slate-950': '020617',
  'gray-50': 'f9fafb',
  'gray-100': 'f3f4f6',
  'gray-200': 'e5e7eb',
  'gray-300': 'd1d5db',
  'gray-400': '9ca3af',
  'gray-500': '6b7280',
  'gray-600': '4b5563',
  'gray-700': '374151',
  'gray-800': '1f2937',
  'gray-900': '111827',
  'gray-950': '030712',
  'zinc-50': 'fafafa',
  'zinc-100': 'f4f4f5',
  'zinc-200': 'e4e4e7',
  'zinc-300': 'd4d4d8',
  'zinc-400': 'a1a1aa',
  'zinc-500': '71717a',
  'zinc-600': '52525b',
  'zinc-700': '3f3f46',
  'zinc-800': '27272a',
  'zinc-900': '18181b',
  'zinc-950': '09090b',
  'neutral-50': 'fafafa',
  'neutral-100': 'f5f5f5',
  'neutral-200': 'e5e5e5',
  'neutral-300': 'd4d4d4',
  'neutral-400': 'a3a3a3',
  'neutral-500': '737373',
  'neutral-600': '525252',
  'neutral-700': '404040',
  'neutral-800': '262626',
  'neutral-900': '171717',
  'neutral-950': '0a0a0a',
  'stone-50': 'fafaf9',
  'stone-100': 'f5f5f4',
  'stone-200': 'e7e5e4',
  'stone-300': 'd6d3d1',
  'stone-400': 'a8a29e',
  'stone-500': '78716c',
  'stone-600': '57534e',
  'stone-700': '44403c',
  'stone-800': '292524',
  'stone-900': '1c1917',
  'stone-950': '0c0a09',
  // --- Primary Colors ---
  'red-50': 'fef2f2',
  'red-100': 'fee2e2',
  'red-200': 'fecaca',
  'red-300': 'fca5a5',
  'red-400': 'f87171',
  'red-500': 'ef4444',
  'red-600': 'dc2626',
  'red-700': 'b91c1c',
  'red-800': '991b1b',
  'red-900': '7f1d1d',
  'red-950': '450a0a',
  'orange-50': 'fff7ed',
  'orange-100': 'ffedd5',
  'orange-200': 'fed7aa',
  'orange-300': 'fdba74',
  'orange-400': 'fb923c',
  'orange-500': 'f97316',
  'orange-600': 'ea580c',
  'orange-700': 'c2410c',
  'orange-800': '9a3412',
  'orange-900': '7c2d12',
  'orange-950': '431407',
  'amber-50': 'fffbeb',
  'amber-100': 'fef3c7',
  'amber-200': 'fde68a',
  'amber-300': 'fcd34d',
  'amber-400': 'fbbf24',
  'amber-500': 'f59e0b',
  'amber-600': 'd97706',
  'amber-700': 'b45309',
  'amber-800': '92400e',
  'amber-900': '78350f',
  'amber-950': '451a03',
  'yellow-50': 'fefce8',
  'yellow-100': 'fef9c3',
  'yellow-200': 'fef08a',
  'yellow-300': 'fde047',
  'yellow-400': 'facc15',
  'yellow-500': 'eab308',
  'yellow-600': 'ca8a04',
  'yellow-700': 'a16207',
  'yellow-800': '854d0e',
  'yellow-900': '713f12',
  'yellow-950': '422006',
  'lime-50': 'f7fee7',
  'lime-100': 'ecfccb',
  'lime-200': 'd9f99d',
  'lime-300': 'bef264',
  'lime-400': 'a3e635',
  'lime-500': '84cc16',
  'lime-600': '65a30d',
  'lime-700': '4d7c0f',
  'lime-800': '3f6212',
  'lime-900': '365314',
  'lime-950': '1a2e05',
  'green-50': 'f0fdf4',
  'green-100': 'dcfce7',
  'green-200': 'bbf7d0',
  'green-300': '86efac',
  'green-400': '4ade80',
  'green-500': '22c55e',
  'green-600': '16a34a',
  'green-700': '15803d',
  'green-800': '166534',
  'green-900': '14532d',
  'green-950': '052e16',
  'emerald-50': 'ecfdf5',
  'emerald-100': 'd1fae5',
  'emerald-200': 'a7f3d0',
  'emerald-300': '6ee7b7',
  'emerald-400': '34d399',
  'emerald-500': '10b981',
  'emerald-600': '059669',
  'emerald-700': '047857',
  'emerald-800': '065f46',
  'emerald-900': '064e3b',
  'emerald-950': '022c22',
  'teal-50': 'f0fdfa',
  'teal-100': 'ccfbf1',
  'teal-200': '99f6e4',
  'teal-300': '5eead4',
  'teal-400': '2dd4bf',
  'teal-500': '14b8a6',
  'teal-600': '0d9488',
  'teal-700': '0f766e',
  'teal-800': '115e59',
  'teal-900': '134e4a',
  'teal-950': '042f2e',
  'cyan-50': 'ecfeff',
  'cyan-100': 'cffafe',
  'cyan-200': 'a5f3fc',
  'cyan-300': '67e8f9',
  'cyan-400': '22d3ee',
  'cyan-500': '06b6d4',
  'cyan-600': '0891b2',
  'cyan-700': '0e7490',
  'cyan-800': '155e75',
  'cyan-900': '164e63',
  'cyan-950': '083344',
  'sky-50': 'f0f9ff',
  'sky-100': 'e0f2fe',
  'sky-200': 'bae6fd',
  'sky-300': '7dd3fc',
  'sky-400': '38bdf8',
  'sky-500': '0ea5e9',
  'sky-600': '0284c7',
  'sky-700': '0369a1',
  'sky-800': '075985',
  'sky-900': '0c4a6e',
  'sky-950': '082f49',
  'blue-50': 'eff6ff',
  'blue-100': 'dbeafe',
  'blue-200': 'bfdbfe',
  'blue-300': '93c5fd',
  'blue-400': '60a5fa',
  'blue-500': '3b82f6',
  'blue-600': '2563eb',
  'blue-700': '1d4ed8',
  'blue-800': '1e40af',
  'blue-900': '1e3a8a',
  'blue-950': '172554',
  'indigo-50': 'eef2ff',
  'indigo-100': 'e0e7ff',
  'indigo-200': 'c7d2fe',
  'indigo-300': 'a5b4fc',
  'indigo-400': '818cf8',
  'indigo-500': '6366f1',
  'indigo-600': '4f46e5',
  'indigo-700': '4338ca',
  'indigo-800': '3730a3',
  'indigo-900': '312e81',
  'indigo-950': '1e1b4b',
  'violet-50': 'f5f3ff',
  'violet-100': 'ede9fe',
  'violet-200': 'ddd6fe',
  'violet-300': 'c4b5fd',
  'violet-400': 'a78bfa',
  'violet-500': '8b5cf6',
  'violet-600': '7c3aed',
  'violet-700': '6d28d9',
  'violet-800': '5b21b6',
  'violet-900': '4c1d95',
  'violet-950': '2e1065',
  'purple-50': 'faf5ff',
  'purple-100': 'f3e8ff',
  'purple-200': 'e9d5ff',
  'purple-300': 'd8b4fe',
  'purple-400': 'c084fc',
  'purple-500': 'a855f7',
  'purple-600': '9333ea',
  'purple-700': '7e22ce',
  'purple-800': '6b21a8',
  'purple-900': '581c87',
  'purple-950': '3b0764',
  'fuchsia-50': 'fdf4ff',
  'fuchsia-100': 'fae8ff',
  'fuchsia-200': 'f5d0fe',
  'fuchsia-300': 'f0abfc',
  'fuchsia-400': 'e879f9',
  'fuchsia-500': 'd946ef',
  'fuchsia-600': 'c026d3',
  'fuchsia-700': 'a21caf',
  'fuchsia-800': '86198f',
  'fuchsia-900': '701a75',
  'fuchsia-950': '4a044e',
  'pink-50': 'fdf2f8',
  'pink-100': 'fce7f3',
  'pink-200': 'fbcfe8',
  'pink-300': 'f9a8d4',
  'pink-400': 'f472b6',
  'pink-500': 'ec4899',
  'pink-600': 'db2777',
  'pink-700': 'be185d',
  'pink-800': '9d174d',
  'pink-900': '831843',
  'pink-950': '500724',
  'rose-50': 'fff1f2',
  'rose-100': 'ffe4e6',
  'rose-200': 'fecdd3',
  'rose-300': 'fda4af',
  'rose-400': 'fb7185',
  'rose-500': 'f43f5e',
  'rose-600': 'e11d48',
  'rose-700': 'be123c',
  'rose-800': '9f1239',
  'rose-900': '881337',
  'rose-950': '4c0519',
};

/// Helper class for the `Colors.tailwind` extension.
class TailwindColorPaletteHelper {
  const TailwindColorPaletteHelper();

  // Dynamically create getters for all Tailwind colors
  // This is a bit of a trick to avoid manually writing 200+ getters.
  // It relies on noSuchMethod, which is less performant than direct getters
  // but significantly reduces boilerplate. For a fixed set of colors,
  // code generation or manual getters would be more typical.
  // However, for this context, it demonstrates the concept.

  // For a production app, consider generating these getters or writing them manually.
  // Example of manual getters:
  // Color get slate50 => Color('#f8fafc');
  // Color get slate100 => Color('#f1f5f9');
  // ... and so on for all colors

  Color _getColor(String name) => Color('#${_tailwindHexCodes[name]!}');

  Color get slate50 => _getColor('slate-50');
  Color get slate100 => _getColor('slate-100');
  Color get slate200 => _getColor('slate-200');
  Color get slate300 => _getColor('slate-300');
  Color get slate400 => _getColor('slate-400');
  Color get slate500 => _getColor('slate-500');
  Color get slate600 => _getColor('slate-600');
  Color get slate700 => _getColor('slate-700');
  Color get slate800 => _getColor('slate-800');
  Color get slate900 => _getColor('slate-900');
  Color get slate950 => _getColor('slate-950');
  Color get gray50 => _getColor('gray-50');
  Color get gray100 => _getColor('gray-100');
  Color get gray200 => _getColor('gray-200');
  Color get gray300 => _getColor('gray-300');
  Color get gray400 => _getColor('gray-400');
  Color get gray500 => _getColor('gray-500');
  Color get gray600 => _getColor('gray-600');
  Color get gray700 => _getColor('gray-700');
  Color get gray800 => _getColor('gray-800');
  Color get gray900 => _getColor('gray-900');
  Color get gray950 => _getColor('gray-950');
  Color get zinc50 => _getColor('zinc-50');
  Color get zinc100 => _getColor('zinc-100');
  Color get zinc200 => _getColor('zinc-200');
  Color get zinc300 => _getColor('zinc-300');
  Color get zinc400 => _getColor('zinc-400');
  Color get zinc500 => _getColor('zinc-500');
  Color get zinc600 => _getColor('zinc-600');
  Color get zinc700 => _getColor('zinc-700');
  Color get zinc800 => _getColor('zinc-800');
  Color get zinc900 => _getColor('zinc-900');
  Color get zinc950 => _getColor('zinc-950');
  Color get neutral50 => _getColor('neutral-50');
  Color get neutral100 => _getColor('neutral-100');
  Color get neutral200 => _getColor('neutral-200');
  Color get neutral300 => _getColor('neutral-300');
  Color get neutral400 => _getColor('neutral-400');
  Color get neutral500 => _getColor('neutral-500');
  Color get neutral600 => _getColor('neutral-600');
  Color get neutral700 => _getColor('neutral-700');
  Color get neutral800 => _getColor('neutral-800');
  Color get neutral900 => _getColor('neutral-900');
  Color get neutral950 => _getColor('neutral-950');
  Color get stone50 => _getColor('stone-50');
  Color get stone100 => _getColor('stone-100');
  Color get stone200 => _getColor('stone-200');
  Color get stone300 => _getColor('stone-300');
  Color get stone400 => _getColor('stone-400');
  Color get stone500 => _getColor('stone-500');
  Color get stone600 => _getColor('stone-600');
  Color get stone700 => _getColor('stone-700');
  Color get stone800 => _getColor('stone-800');
  Color get stone900 => _getColor('stone-900');
  Color get stone950 => _getColor('stone-950');
  Color get red50 => _getColor('red-50');
  Color get red100 => _getColor('red-100');
  Color get red200 => _getColor('red-200');
  Color get red300 => _getColor('red-300');
  Color get red400 => _getColor('red-400');
  Color get red500 => _getColor('red-500');
  Color get red600 => _getColor('red-600');
  Color get red700 => _getColor('red-700');
  Color get red800 => _getColor('red-800');
  Color get red900 => _getColor('red-900');
  Color get red950 => _getColor('red-950');
  Color get orange50 => _getColor('orange-50');
  Color get orange100 => _getColor('orange-100');
  Color get orange200 => _getColor('orange-200');
  Color get orange300 => _getColor('orange-300');
  Color get orange400 => _getColor('orange-400');
  Color get orange500 => _getColor('orange-500');
  Color get orange600 => _getColor('orange-600');
  Color get orange700 => _getColor('orange-700');
  Color get orange800 => _getColor('orange-800');
  Color get orange900 => _getColor('orange-900');
  Color get orange950 => _getColor('orange-950');
  Color get amber50 => _getColor('amber-50');
  Color get amber100 => _getColor('amber-100');
  Color get amber200 => _getColor('amber-200');
  Color get amber300 => _getColor('amber-300');
  Color get amber400 => _getColor('amber-400');
  Color get amber500 => _getColor('amber-500');
  Color get amber600 => _getColor('amber-600');
  Color get amber700 => _getColor('amber-700');
  Color get amber800 => _getColor('amber-800');
  Color get amber900 => _getColor('amber-900');
  Color get amber950 => _getColor('amber-950');
  Color get yellow50 => _getColor('yellow-50');
  Color get yellow100 => _getColor('yellow-100');
  Color get yellow200 => _getColor('yellow-200');
  Color get yellow300 => _getColor('yellow-300');
  Color get yellow400 => _getColor('yellow-400');
  Color get yellow500 => _getColor('yellow-500');
  Color get yellow600 => _getColor('yellow-600');
  Color get yellow700 => _getColor('yellow-700');
  Color get yellow800 => _getColor('yellow-800');
  Color get yellow900 => _getColor('yellow-900');
  Color get yellow950 => _getColor('yellow-950');
  Color get lime50 => _getColor('lime-50');
  Color get lime100 => _getColor('lime-100');
  Color get lime200 => _getColor('lime-200');
  Color get lime300 => _getColor('lime-300');
  Color get lime400 => _getColor('lime-400');
  Color get lime500 => _getColor('lime-500');
  Color get lime600 => _getColor('lime-600');
  Color get lime700 => _getColor('lime-700');
  Color get lime800 => _getColor('lime-800');
  Color get lime900 => _getColor('lime-900');
  Color get lime950 => _getColor('lime-950');
  Color get green50 => _getColor('green-50');
  Color get green100 => _getColor('green-100');
  Color get green200 => _getColor('green-200');
  Color get green300 => _getColor('green-300');
  Color get green400 => _getColor('green-400');
  Color get green500 => _getColor('green-500');
  Color get green600 => _getColor('green-600');
  Color get green700 => _getColor('green-700');
  Color get green800 => _getColor('green-800');
  Color get green900 => _getColor('green-900');
  Color get green950 => _getColor('green-950');
  Color get emerald50 => _getColor('emerald-50');
  Color get emerald100 => _getColor('emerald-100');
  Color get emerald200 => _getColor('emerald-200');
  Color get emerald300 => _getColor('emerald-300');
  Color get emerald400 => _getColor('emerald-400');
  Color get emerald500 => _getColor('emerald-500');
  Color get emerald600 => _getColor('emerald-600');
  Color get emerald700 => _getColor('emerald-700');
  Color get emerald800 => _getColor('emerald-800');
  Color get emerald900 => _getColor('emerald-900');
  Color get emerald950 => _getColor('emerald-950');
  Color get teal50 => _getColor('teal-50');
  Color get teal100 => _getColor('teal-100');
  Color get teal200 => _getColor('teal-200');
  Color get teal300 => _getColor('teal-300');
  Color get teal400 => _getColor('teal-400');
  Color get teal500 => _getColor('teal-500');
  Color get teal600 => _getColor('teal-600');
  Color get teal700 => _getColor('teal-700');
  Color get teal800 => _getColor('teal-800');
  Color get teal900 => _getColor('teal-900');
  Color get teal950 => _getColor('teal-950');
  Color get cyan50 => _getColor('cyan-50');
  Color get cyan100 => _getColor('cyan-100');
  Color get cyan200 => _getColor('cyan-200');
  Color get cyan300 => _getColor('cyan-300');
  Color get cyan400 => _getColor('cyan-400');
  Color get cyan500 => _getColor('cyan-500');
  Color get cyan600 => _getColor('cyan-600');
  Color get cyan700 => _getColor('cyan-700');
  Color get cyan800 => _getColor('cyan-800');
  Color get cyan900 => _getColor('cyan-900');
  Color get cyan950 => _getColor('cyan-950');
  Color get sky50 => _getColor('sky-50');
  Color get sky100 => _getColor('sky-100');
  Color get sky200 => _getColor('sky-200');
  Color get sky300 => _getColor('sky-300');
  Color get sky400 => _getColor('sky-400');
  Color get sky500 => _getColor('sky-500');
  Color get sky600 => _getColor('sky-600');
  Color get sky700 => _getColor('sky-700');
  Color get sky800 => _getColor('sky-800');
  Color get sky900 => _getColor('sky-900');
  Color get sky950 => _getColor('sky-950');
  Color get blue50 => _getColor('blue-50');
  Color get blue100 => _getColor('blue-100');
  Color get blue200 => _getColor('blue-200');
  Color get blue300 => _getColor('blue-300');
  Color get blue400 => _getColor('blue-400');
  Color get blue500 => _getColor('blue-500');
  Color get blue600 => _getColor('blue-600');
  Color get blue700 => _getColor('blue-700');
  Color get blue800 => _getColor('blue-800');
  Color get blue900 => _getColor('blue-900');
  Color get blue950 => _getColor('blue-950');
  Color get indigo50 => _getColor('indigo-50');
  Color get indigo100 => _getColor('indigo-100');
  Color get indigo200 => _getColor('indigo-200');
  Color get indigo300 => _getColor('indigo-300');
  Color get indigo400 => _getColor('indigo-400');
  Color get indigo500 => _getColor('indigo-500');
  Color get indigo600 => _getColor('indigo-600');
  Color get indigo700 => _getColor('indigo-700');
  Color get indigo800 => _getColor('indigo-800');
  Color get indigo900 => _getColor('indigo-900');
  Color get indigo950 => _getColor('indigo-950');
  Color get violet50 => _getColor('violet-50');
  Color get violet100 => _getColor('violet-100');
  Color get violet200 => _getColor('violet-200');
  Color get violet300 => _getColor('violet-300');
  Color get violet400 => _getColor('violet-400');
  Color get violet500 => _getColor('violet-500');
  Color get violet600 => _getColor('violet-600');
  Color get violet700 => _getColor('violet-700');
  Color get violet800 => _getColor('violet-800');
  Color get violet900 => _getColor('violet-900');
  Color get violet950 => _getColor('violet-950');
  Color get purple50 => _getColor('purple-50');
  Color get purple100 => _getColor('purple-100');
  Color get purple200 => _getColor('purple-200');
  Color get purple300 => _getColor('purple-300');
  Color get purple400 => _getColor('purple-400');
  Color get purple500 => _getColor('purple-500');
  Color get purple600 => _getColor('purple-600');
  Color get purple700 => _getColor('purple-700');
  Color get purple800 => _getColor('purple-800');
  Color get purple900 => _getColor('purple-900');
  Color get purple950 => _getColor('purple-950');
  Color get fuchsia50 => _getColor('fuchsia-50');
  Color get fuchsia100 => _getColor('fuchsia-100');
  Color get fuchsia200 => _getColor('fuchsia-200');
  Color get fuchsia300 => _getColor('fuchsia-300');
  Color get fuchsia400 => _getColor('fuchsia-400');
  Color get fuchsia500 => _getColor('fuchsia-500');
  Color get fuchsia600 => _getColor('fuchsia-600');
  Color get fuchsia700 => _getColor('fuchsia-700');
  Color get fuchsia800 => _getColor('fuchsia-800');
  Color get fuchsia900 => _getColor('fuchsia-900');
  Color get fuchsia950 => _getColor('fuchsia-950');
  Color get pink50 => _getColor('pink-50');
  Color get pink100 => _getColor('pink-100');
  Color get pink200 => _getColor('pink-200');
  Color get pink300 => _getColor('pink-300');
  Color get pink400 => _getColor('pink-400');
  Color get pink500 => _getColor('pink-500');
  Color get pink600 => _getColor('pink-600');
  Color get pink700 => _getColor('pink-700');
  Color get pink800 => _getColor('pink-800');
  Color get pink900 => _getColor('pink-900');
  Color get pink950 => _getColor('pink-950');
  Color get rose50 => _getColor('rose-50');
  Color get rose100 => _getColor('rose-100');
  Color get rose200 => _getColor('rose-200');
  Color get rose300 => _getColor('rose-300');
  Color get rose400 => _getColor('rose-400');
  Color get rose500 => _getColor('rose-500');
  Color get rose600 => _getColor('rose-600');
  Color get rose700 => _getColor('rose-700');
  Color get rose800 => _getColor('rose-800');
  Color get rose900 => _getColor('rose-900');
  Color get rose950 => _getColor('rose-950');
}

/// Extension to provide access to Tailwind colors via `Colors.tailwind.colorName`.
extension TailwindColorAccess on Colors {
  static const TailwindColorPaletteHelper tailwind =
      TailwindColorPaletteHelper();
}

/// Parses various color representations into Tailwind CSS class strings.
class TailwindColorParser {
  // Precompute Jaspr.Color instances for predefined Tailwind colors for efficient lookup.
  static final Map<String, Color> _predefinedTailwindJasprColors = {
    for (var entry in _tailwindHexCodes.entries)
      entry.key: Color('#${entry.value}'),
  };

  // Inverted map: jaspr.Color.value (CSS string) -> tailwindClassName
  static final Map<String, String> _jasprValueToClassName = {
    for (var entry in _predefinedTailwindJasprColors.entries)
      entry.value.value: entry.key,
  };

  /// Converts a [jaspr.Color] to its corresponding Tailwind CSS class string.
  ///
  /// If the color matches a predefined Tailwind color, its name (e.g., "red-500") is returned.
  /// Otherwise, an arbitrary Tailwind value string (e.g., "[#ff0000]", "[rgba(0,0,255,0.5)]")
  /// is returned, using the `color.value` (CSS string representation).
  static String fromJasprColor(Color color) {
    final predefinedClassName = _jasprValueToClassName[color.value];
    if (predefinedClassName != null) {
      return predefinedClassName;
    }
    // For arbitrary values, Tailwind expects them inside brackets.
    // color.value is already a valid CSS color string.
    return '[${color.value.toLowerCase()}]';
  }

  /// Converts RGB components to a Tailwind CSS class string.
  static String fromRGB(int r, int g, int b) {
    return fromJasprColor(Color.rgb(r, g, b));
  }

  /// Converts RGBA components to a Tailwind CSS class string.
  static String fromRGBA(int r, int g, int b, double alpha) {
    return fromJasprColor(Color.rgba(r, g, b, alpha));
  }

  /// Converts HSL components to a Tailwind CSS class string.
  static String fromHSL(int h, int s, int l) {
    return fromJasprColor(Color.hsl(h, s, l));
  }

  /// Converts HSLA components to a Tailwind CSS class string.
  static String fromHSLA(int h, int s, int l, double alpha) {
    return fromJasprColor(Color.hsla(h, s, l, alpha));
  }

  /// Converts a hex string (e.g., "FF0000", "#F00") to a Tailwind CSS class string.
  static String fromHexString(String hex) {
    String originalHexForTailwindArbitrary = hex;
    if (originalHexForTailwindArbitrary.startsWith('#')) {
      originalHexForTailwindArbitrary =
          originalHexForTailwindArbitrary.substring(1);
    }
    originalHexForTailwindArbitrary =
        originalHexForTailwindArbitrary.toLowerCase();

    String cssHex = hex;
    if (!cssHex.startsWith('#')) {
      cssHex = '#$cssHex';
    }

    try {
      final jasprColor = Color(cssHex); // Use Jaspr's main Color constructor
      return fromJasprColor(jasprColor);
    } catch (e) {
      // If jaspr.Color(cssHex) fails, it's not a valid CSS color string.
      // Return it as a Tailwind arbitrary value using the (normalized) original hex.
      return '[#$originalHexForTailwindArbitrary]';
    }
  }
}

/// Represents a Tailwind CSS color, which can be either a predefined named color
/// (like "blue-500") or an arbitrary color value (like "bg-[#FF0000]").
class TailwindColor {
  /// The Tailwind CSS class name (e.g., "blue-500", "bg-[#FF0000]").
  final String className;
  final Color?
      _jasprColor; // Null for arbitrary colors not directly parsable to a single color

  // Private constructor
  const TailwindColor._(this.className, this._jasprColor);

  /// Creates a [TailwindColor] instance from a Tailwind class name string.
  /// If the name corresponds to a predefined Tailwind color, a canonical instance is returned.
  /// Otherwise, an instance representing an arbitrary color class is returned.
  factory TailwindColor.fromString(String name) {
    final predefined = _predefinedColors[name];
    if (predefined != null) {
      // Exact match for predefined name
      return predefined;
    }
    // For arbitrary Tailwind class strings (e.g., "bg-[#FF0000]", "text-[rgb(0,0,0)]"),
    // the className is the name itself. _parseArbitraryClassNameToColor will extract the color.
    return TailwindColor._(name, _parseArbitraryClassNameToColor(name));
  }

  /// Creates a [TailwindColor] instance from a [jaspr.Color].
  /// If the color matches a predefined Tailwind color, a canonical instance is returned.
  /// Otherwise, an instance representing an arbitrary color class `[#rrggbb]` or `[#rrggbbaa]` is returned.
  factory TailwindColor.fromJasprColor(Color color) {
    final String className = TailwindColorParser.fromJasprColor(color);

    // If the generated className corresponds to a predefined Tailwind color name,
    // return the canonical static instance.
    final predefinedCanonical = _predefinedColors[className];
    if (predefinedCanonical != null) {
      return predefinedCanonical;
    }
    return TailwindColor._(className, color);
  }

  /// Creates a [TailwindColor] instance from a hex string (e.g., "FF0000", "#F00", "aabbccdd").
  /// If the hex (when normalized to 6-digit opaque) corresponds to a predefined color,
  /// that canonical instance is returned.
  /// Otherwise, an arbitrary color class `[#<inputHex>]` is returned.
  /// Hex matching is case-insensitive.
  factory TailwindColor.fromHex(String hex) {
    String originalHexForTailwindArbitrary = hex;
    if (originalHexForTailwindArbitrary.startsWith('#')) {
      originalHexForTailwindArbitrary =
          originalHexForTailwindArbitrary.substring(1);
    }
    originalHexForTailwindArbitrary =
        originalHexForTailwindArbitrary.toLowerCase();

    String cssHex = hex;
    if (!cssHex.startsWith('#')) {
      cssHex = '#$cssHex';
    }

    Color? jasprColorInstance;
    try {
      jasprColorInstance = Color(cssHex);
    } catch (_) {
      return TailwindColor._('[#$originalHexForTailwindArbitrary]', null);
    }

    // Use the fromJasprColor factory which correctly handles predefined checks
    // and uses TailwindColorParser.
    return TailwindColor.fromJasprColor(jasprColorInstance);
  }

  /// Attempts to convert this Tailwind color representation to a [jaspr.Color].
  /// Returns `null` if the color cannot be determined.
  Color? toJasprColor() {
    return _jasprColor; // Determined at construction
  }

  static Color? _parseArbitraryClassNameToColor(String className) {
    // Handles formats like "[#RGB]", "[#RGBA]", "[#RRGGBB]", "[#RRGGBBAA]"
    // or "prefix-[...]" (e.g., "bg-[#aabbcc]").
    // This parser is specifically for Tailwind's arbitrary hex value syntax.
    final RegExp pattern = RegExp(
        r'^(?:[a-zA-Z]+(?:-[a-zA-Z]+)*-)?\[#([0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\]$');
    final Match? match = pattern.firstMatch(className);

    if (match != null) {
      final String hexCode = match.group(1)!;
      try {
        // Jaspr's Color() constructor needs '#' for hex values.
        return Color('#$hexCode');
      } catch (_) {
        return null; // Invalid hex format
      }
    }
    return null; // Not a recognized hex color format
  }

  // --- Predefined Color Instances (canonical) ---
  // Lazily initialized map of canonical TailwindColor instances for predefined colors.
  static final Map<String, TailwindColor> _predefinedColors = {
    for (var entry in _tailwindHexCodes.entries)
      entry.key: TailwindColor._(entry.key, Color('#${entry.value}')),
  };

  // --- Static final fields for easy access (mimicking enum values) ---
  // These provide the `TailwindColor.slate50` syntax.
  // Example for Slate:
  static final TailwindColor slate50 = _predefinedColors['slate-50']!;
  static final TailwindColor slate100 = _predefinedColors['slate-100']!;
  static final TailwindColor slate200 = _predefinedColors['slate-200']!;
  static final TailwindColor slate300 = _predefinedColors['slate-300']!;
  static final TailwindColor slate400 = _predefinedColors['slate-400']!;
  static final TailwindColor slate500 = _predefinedColors['slate-500']!;
  static final TailwindColor slate600 = _predefinedColors['slate-600']!;
  static final TailwindColor slate700 = _predefinedColors['slate-700']!;
  static final TailwindColor slate800 = _predefinedColors['slate-800']!;
  static final TailwindColor slate900 = _predefinedColors['slate-900']!;
  static final TailwindColor slate950 = _predefinedColors['slate-950']!;

  static final TailwindColor gray50 = _predefinedColors['gray-50']!;
  static final TailwindColor gray100 = _predefinedColors['gray-100']!;
  static final TailwindColor gray200 = _predefinedColors['gray-200']!;
  static final TailwindColor gray300 = _predefinedColors['gray-300']!;
  static final TailwindColor gray400 = _predefinedColors['gray-400']!;
  static final TailwindColor gray500 = _predefinedColors['gray-500']!;
  static final TailwindColor gray600 = _predefinedColors['gray-600']!;
  static final TailwindColor gray700 = _predefinedColors['gray-700']!;
  static final TailwindColor gray800 = _predefinedColors['gray-800']!;
  static final TailwindColor gray900 = _predefinedColors['gray-900']!;
  static final TailwindColor gray950 = _predefinedColors['gray-950']!;

  static final TailwindColor zinc50 = _predefinedColors['zinc-50']!;
  static final TailwindColor zinc100 = _predefinedColors['zinc-100']!;
  static final TailwindColor zinc200 = _predefinedColors['zinc-200']!;
  static final TailwindColor zinc300 = _predefinedColors['zinc-300']!;
  static final TailwindColor zinc400 = _predefinedColors['zinc-400']!;
  static final TailwindColor zinc500 = _predefinedColors['zinc-500']!;
  static final TailwindColor zinc600 = _predefinedColors['zinc-600']!;
  static final TailwindColor zinc700 = _predefinedColors['zinc-700']!;
  static final TailwindColor zinc800 = _predefinedColors['zinc-800']!;
  static final TailwindColor zinc900 = _predefinedColors['zinc-900']!;
  static final TailwindColor zinc950 = _predefinedColors['zinc-950']!;

  static final TailwindColor neutral50 = _predefinedColors['neutral-50']!;
  static final TailwindColor neutral100 = _predefinedColors['neutral-100']!;
  static final TailwindColor neutral200 = _predefinedColors['neutral-200']!;
  static final TailwindColor neutral300 = _predefinedColors['neutral-300']!;
  static final TailwindColor neutral400 = _predefinedColors['neutral-400']!;
  static final TailwindColor neutral500 = _predefinedColors['neutral-500']!;
  static final TailwindColor neutral600 = _predefinedColors['neutral-600']!;
  static final TailwindColor neutral700 = _predefinedColors['neutral-700']!;
  static final TailwindColor neutral800 = _predefinedColors['neutral-800']!;
  static final TailwindColor neutral900 = _predefinedColors['neutral-900']!;
  static final TailwindColor neutral950 = _predefinedColors['neutral-950']!;

  static final TailwindColor stone50 = _predefinedColors['stone-50']!;
  static final TailwindColor stone100 = _predefinedColors['stone-100']!;
  static final TailwindColor stone200 = _predefinedColors['stone-200']!;
  static final TailwindColor stone300 = _predefinedColors['stone-300']!;
  static final TailwindColor stone400 = _predefinedColors['stone-400']!;
  static final TailwindColor stone500 = _predefinedColors['stone-500']!;
  static final TailwindColor stone600 = _predefinedColors['stone-600']!;
  static final TailwindColor stone700 = _predefinedColors['stone-700']!;
  static final TailwindColor stone800 = _predefinedColors['stone-800']!;
  static final TailwindColor stone900 = _predefinedColors['stone-900']!;
  static final TailwindColor stone950 = _predefinedColors['stone-950']!;

  static final TailwindColor red50 = _predefinedColors['red-50']!;
  static final TailwindColor red100 = _predefinedColors['red-100']!;
  static final TailwindColor red200 = _predefinedColors['red-200']!;
  static final TailwindColor red300 = _predefinedColors['red-300']!;
  static final TailwindColor red400 = _predefinedColors['red-400']!;
  static final TailwindColor red500 = _predefinedColors['red-500']!;
  static final TailwindColor red600 = _predefinedColors['red-600']!;
  static final TailwindColor red700 = _predefinedColors['red-700']!;
  static final TailwindColor red800 = _predefinedColors['red-800']!;
  static final TailwindColor red900 = _predefinedColors['red-900']!;
  static final TailwindColor red950 = _predefinedColors['red-950']!;

  static final TailwindColor orange50 = _predefinedColors['orange-50']!;
  static final TailwindColor orange100 = _predefinedColors['orange-100']!;
  static final TailwindColor orange200 = _predefinedColors['orange-200']!;
  static final TailwindColor orange300 = _predefinedColors['orange-300']!;
  static final TailwindColor orange400 = _predefinedColors['orange-400']!;
  static final TailwindColor orange500 = _predefinedColors['orange-500']!;
  static final TailwindColor orange600 = _predefinedColors['orange-600']!;
  static final TailwindColor orange700 = _predefinedColors['orange-700']!;
  static final TailwindColor orange800 = _predefinedColors['orange-800']!;
  static final TailwindColor orange900 = _predefinedColors['orange-900']!;
  static final TailwindColor orange950 = _predefinedColors['orange-950']!;

  static final TailwindColor amber50 = _predefinedColors['amber-50']!;
  static final TailwindColor amber100 = _predefinedColors['amber-100']!;
  static final TailwindColor amber200 = _predefinedColors['amber-200']!;
  static final TailwindColor amber300 = _predefinedColors['amber-300']!;
  static final TailwindColor amber400 = _predefinedColors['amber-400']!;
  static final TailwindColor amber500 = _predefinedColors['amber-500']!;
  static final TailwindColor amber600 = _predefinedColors['amber-600']!;
  static final TailwindColor amber700 = _predefinedColors['amber-700']!;
  static final TailwindColor amber800 = _predefinedColors['amber-800']!;
  static final TailwindColor amber900 = _predefinedColors['amber-900']!;
  static final TailwindColor amber950 = _predefinedColors['amber-950']!;

  static final TailwindColor yellow50 = _predefinedColors['yellow-50']!;
  static final TailwindColor yellow100 = _predefinedColors['yellow-100']!;
  static final TailwindColor yellow200 = _predefinedColors['yellow-200']!;
  static final TailwindColor yellow300 = _predefinedColors['yellow-300']!;
  static final TailwindColor yellow400 = _predefinedColors['yellow-400']!;
  static final TailwindColor yellow500 = _predefinedColors['yellow-500']!;
  static final TailwindColor yellow600 = _predefinedColors['yellow-600']!;
  static final TailwindColor yellow700 = _predefinedColors['yellow-700']!;
  static final TailwindColor yellow800 = _predefinedColors['yellow-800']!;
  static final TailwindColor yellow900 = _predefinedColors['yellow-900']!;
  static final TailwindColor yellow950 = _predefinedColors['yellow-950']!;

  static final TailwindColor lime50 = _predefinedColors['lime-50']!;
  static final TailwindColor lime100 = _predefinedColors['lime-100']!;
  static final TailwindColor lime200 = _predefinedColors['lime-200']!;
  static final TailwindColor lime300 = _predefinedColors['lime-300']!;
  static final TailwindColor lime400 = _predefinedColors['lime-400']!;
  static final TailwindColor lime500 = _predefinedColors['lime-500']!;
  static final TailwindColor lime600 = _predefinedColors['lime-600']!;
  static final TailwindColor lime700 = _predefinedColors['lime-700']!;
  static final TailwindColor lime800 = _predefinedColors['lime-800']!;
  static final TailwindColor lime900 = _predefinedColors['lime-900']!;
  static final TailwindColor lime950 = _predefinedColors['lime-950']!;

  static final TailwindColor green50 = _predefinedColors['green-50']!;
  static final TailwindColor green100 = _predefinedColors['green-100']!;
  static final TailwindColor green200 = _predefinedColors['green-200']!;
  static final TailwindColor green300 = _predefinedColors['green-300']!;
  static final TailwindColor green400 = _predefinedColors['green-400']!;
  static final TailwindColor green500 = _predefinedColors['green-500']!;
  static final TailwindColor green600 = _predefinedColors['green-600']!;
  static final TailwindColor green700 = _predefinedColors['green-700']!;
  static final TailwindColor green800 = _predefinedColors['green-800']!;
  static final TailwindColor green900 = _predefinedColors['green-900']!;
  static final TailwindColor green950 = _predefinedColors['green-950']!;

  static final TailwindColor emerald50 = _predefinedColors['emerald-50']!;
  static final TailwindColor emerald100 = _predefinedColors['emerald-100']!;
  static final TailwindColor emerald200 = _predefinedColors['emerald-200']!;
  static final TailwindColor emerald300 = _predefinedColors['emerald-300']!;
  static final TailwindColor emerald400 = _predefinedColors['emerald-400']!;
  static final TailwindColor emerald500 = _predefinedColors['emerald-500']!;
  static final TailwindColor emerald600 = _predefinedColors['emerald-600']!;
  static final TailwindColor emerald700 = _predefinedColors['emerald-700']!;
  static final TailwindColor emerald800 = _predefinedColors['emerald-800']!;
  static final TailwindColor emerald900 = _predefinedColors['emerald-900']!;
  static final TailwindColor emerald950 = _predefinedColors['emerald-950']!;

  static final TailwindColor teal50 = _predefinedColors['teal-50']!;
  static final TailwindColor teal100 = _predefinedColors['teal-100']!;
  static final TailwindColor teal200 = _predefinedColors['teal-200']!;
  static final TailwindColor teal300 = _predefinedColors['teal-300']!;
  static final TailwindColor teal400 = _predefinedColors['teal-400']!;
  static final TailwindColor teal500 = _predefinedColors['teal-500']!;
  static final TailwindColor teal600 = _predefinedColors['teal-600']!;
  static final TailwindColor teal700 = _predefinedColors['teal-700']!;
  static final TailwindColor teal800 = _predefinedColors['teal-800']!;
  static final TailwindColor teal900 = _predefinedColors['teal-900']!;
  static final TailwindColor teal950 = _predefinedColors['teal-950']!;

  static final TailwindColor cyan50 = _predefinedColors['cyan-50']!;
  static final TailwindColor cyan100 = _predefinedColors['cyan-100']!;
  static final TailwindColor cyan200 = _predefinedColors['cyan-200']!;
  static final TailwindColor cyan300 = _predefinedColors['cyan-300']!;
  static final TailwindColor cyan400 = _predefinedColors['cyan-400']!;
  static final TailwindColor cyan500 = _predefinedColors['cyan-500']!;
  static final TailwindColor cyan600 = _predefinedColors['cyan-600']!;
  static final TailwindColor cyan700 = _predefinedColors['cyan-700']!;
  static final TailwindColor cyan800 = _predefinedColors['cyan-800']!;
  static final TailwindColor cyan900 = _predefinedColors['cyan-900']!;
  static final TailwindColor cyan950 = _predefinedColors['cyan-950']!;

  static final TailwindColor sky50 = _predefinedColors['sky-50']!;
  static final TailwindColor sky100 = _predefinedColors['sky-100']!;
  static final TailwindColor sky200 = _predefinedColors['sky-200']!;
  static final TailwindColor sky300 = _predefinedColors['sky-300']!;
  static final TailwindColor sky400 = _predefinedColors['sky-400']!;
  static final TailwindColor sky500 = _predefinedColors['sky-500']!;
  static final TailwindColor sky600 = _predefinedColors['sky-600']!;
  static final TailwindColor sky700 = _predefinedColors['sky-700']!;
  static final TailwindColor sky800 = _predefinedColors['sky-800']!;
  static final TailwindColor sky900 = _predefinedColors['sky-900']!;
  static final TailwindColor sky950 = _predefinedColors['sky-950']!;

  static final TailwindColor blue50 = _predefinedColors['blue-50']!;
  static final TailwindColor blue100 = _predefinedColors['blue-100']!;
  static final TailwindColor blue200 = _predefinedColors['blue-200']!;
  static final TailwindColor blue300 = _predefinedColors['blue-300']!;
  static final TailwindColor blue400 = _predefinedColors['blue-400']!;
  static final TailwindColor blue500 = _predefinedColors['blue-500']!;
  static final TailwindColor blue600 = _predefinedColors['blue-600']!;
  static final TailwindColor blue700 = _predefinedColors['blue-700']!;
  static final TailwindColor blue800 = _predefinedColors['blue-800']!;
  static final TailwindColor blue900 = _predefinedColors['blue-900']!;
  static final TailwindColor blue950 = _predefinedColors['blue-950']!;

  static final TailwindColor indigo50 = _predefinedColors['indigo-50']!;
  static final TailwindColor indigo100 = _predefinedColors['indigo-100']!;
  static final TailwindColor indigo200 = _predefinedColors['indigo-200']!;
  static final TailwindColor indigo300 = _predefinedColors['indigo-300']!;
  static final TailwindColor indigo400 = _predefinedColors['indigo-400']!;
  static final TailwindColor indigo500 = _predefinedColors['indigo-500']!;
  static final TailwindColor indigo600 = _predefinedColors['indigo-600']!;
  static final TailwindColor indigo700 = _predefinedColors['indigo-700']!;
  static final TailwindColor indigo800 = _predefinedColors['indigo-800']!;
  static final TailwindColor indigo900 = _predefinedColors['indigo-900']!;
  static final TailwindColor indigo950 = _predefinedColors['indigo-950']!;

  static final TailwindColor violet50 = _predefinedColors['violet-50']!;
  static final TailwindColor violet100 = _predefinedColors['violet-100']!;
  static final TailwindColor violet200 = _predefinedColors['violet-200']!;
  static final TailwindColor violet300 = _predefinedColors['violet-300']!;
  static final TailwindColor violet400 = _predefinedColors['violet-400']!;
  static final TailwindColor violet500 = _predefinedColors['violet-500']!;
  static final TailwindColor violet600 = _predefinedColors['violet-600']!;
  static final TailwindColor violet700 = _predefinedColors['violet-700']!;
  static final TailwindColor violet800 = _predefinedColors['violet-800']!;
  static final TailwindColor violet900 = _predefinedColors['violet-900']!;
  static final TailwindColor violet950 = _predefinedColors['violet-950']!;

  static final TailwindColor purple50 = _predefinedColors['purple-50']!;
  static final TailwindColor purple100 = _predefinedColors['purple-100']!;
  static final TailwindColor purple200 = _predefinedColors['purple-200']!;
  static final TailwindColor purple300 = _predefinedColors['purple-300']!;
  static final TailwindColor purple400 = _predefinedColors['purple-400']!;
  static final TailwindColor purple500 = _predefinedColors['purple-500']!;
  static final TailwindColor purple600 = _predefinedColors['purple-600']!;
  static final TailwindColor purple700 = _predefinedColors['purple-700']!;
  static final TailwindColor purple800 = _predefinedColors['purple-800']!;
  static final TailwindColor purple900 = _predefinedColors['purple-900']!;
  static final TailwindColor purple950 = _predefinedColors['purple-950']!;

  static final TailwindColor fuchsia50 = _predefinedColors['fuchsia-50']!;
  static final TailwindColor fuchsia100 = _predefinedColors['fuchsia-100']!;
  static final TailwindColor fuchsia200 = _predefinedColors['fuchsia-200']!;
  static final TailwindColor fuchsia300 = _predefinedColors['fuchsia-300']!;
  static final TailwindColor fuchsia400 = _predefinedColors['fuchsia-400']!;
  static final TailwindColor fuchsia500 = _predefinedColors['fuchsia-500']!;
  static final TailwindColor fuchsia600 = _predefinedColors['fuchsia-600']!;
  static final TailwindColor fuchsia700 = _predefinedColors['fuchsia-700']!;
  static final TailwindColor fuchsia800 = _predefinedColors['fuchsia-800']!;
  static final TailwindColor fuchsia900 = _predefinedColors['fuchsia-900']!;
  static final TailwindColor fuchsia950 = _predefinedColors['fuchsia-950']!;

  static final TailwindColor pink50 = _predefinedColors['pink-50']!;
  static final TailwindColor pink100 = _predefinedColors['pink-100']!;
  static final TailwindColor pink200 = _predefinedColors['pink-200']!;
  static final TailwindColor pink300 = _predefinedColors['pink-300']!;
  static final TailwindColor pink400 = _predefinedColors['pink-400']!;
  static final TailwindColor pink500 = _predefinedColors['pink-500']!;
  static final TailwindColor pink600 = _predefinedColors['pink-600']!;
  static final TailwindColor pink700 = _predefinedColors['pink-700']!;
  static final TailwindColor pink800 = _predefinedColors['pink-800']!;
  static final TailwindColor pink900 = _predefinedColors['pink-900']!;
  static final TailwindColor pink950 = _predefinedColors['pink-950']!;

  static final TailwindColor rose50 = _predefinedColors['rose-50']!;
  static final TailwindColor rose100 = _predefinedColors['rose-100']!;
  static final TailwindColor rose200 = _predefinedColors['rose-200']!;
  static final TailwindColor rose300 = _predefinedColors['rose-300']!;
  static final TailwindColor rose400 = _predefinedColors['rose-400']!;
  static final TailwindColor rose500 = _predefinedColors['rose-500']!;
  static final TailwindColor rose600 = _predefinedColors['rose-600']!;
  static final TailwindColor rose700 = _predefinedColors['rose-700']!;
  static final TailwindColor rose800 = _predefinedColors['rose-800']!;
  static final TailwindColor rose900 = _predefinedColors['rose-900']!;
  static final TailwindColor rose950 = _predefinedColors['rose-950']!;

  /// Provides a list of all predefined [TailwindColor] instances, similar to `Enum.values`.
  static List<TailwindColor> get values => _predefinedColors.values.toList();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TailwindColor &&
          runtimeType == other.runtimeType &&
          className == other.className &&
          _jasprColor == other._jasprColor);

  @override
  int get hashCode => className.hashCode ^ _jasprColor.hashCode;

  @override
  String toString() => 'TailwindColor($className)';
}
