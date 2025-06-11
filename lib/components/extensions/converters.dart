import 'package:jaspr/jaspr.dart';
import 'package:json_annotation/json_annotation.dart';

import 'extensions.dart';

/// A [JsonConverter] that converts [Color] objects to and from their String [value].
class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) {
    return Color(json);
  }

  @override
  String toJson(Color object) {
    return object.value;
  }
}

/// A [JsonConverter] that converts [Unit] objects to and from their CSS String [value].
class UnitConverter extends JsonConverter<Unit, String> {
  const UnitConverter();

  @override
  Unit fromJson(String json) {
    return UnitExtension.parse(json);
  }

  @override
  String toJson(Unit object) {
    return object.value;
  }
}

/// A [JsonConverter] that converts [FontWeight] objects to and from their CSS string [value].
class FontWeightConverter extends JsonConverter<FontWeight, String> {
  const FontWeightConverter();

  @override
  FontWeight fromJson(String json) {
    return switch (json) {
      'normal' => FontWeight.normal,
      'bold' => FontWeight.bold,
      'bolder' => FontWeight.bolder,
      'lighter' => FontWeight.lighter,
      '100' => FontWeight.w100,
      '200' => FontWeight.w200,
      '300' => FontWeight.w300,
      '400' => FontWeight.w400,
      '500' => FontWeight.w500,
      '600' => FontWeight.w600,
      '700' => FontWeight.w700,
      '800' => FontWeight.w800,
      '900' => FontWeight.w900,
      'inherit' => FontWeight.inherit,
      'initial' => FontWeight.initial,
      'revert' => FontWeight.revert,
      'revert-layer' => FontWeight.revertLayer,
      'unset' => FontWeight.unset,
      _ => throw ArgumentError('Unknown FontWeight value: $json'),
    };
  }

  @override
  String toJson(FontWeight object) {
    return object.value;
  }
}

class TextDecorationConverter extends JsonConverter<TextDecoration, String> {
  const TextDecorationConverter();

  @override
  TextDecoration fromJson(String json) {
    return switch (json) {
      'none' => TextDecoration.none,
      'inherit' => TextDecoration.inherit,
      'initial' => TextDecoration.initial,
      'revert' => TextDecoration.revert,
      'revert-layer' => TextDecoration.revertLayer,
      'unset' => TextDecoration.unset,
      _ => throw ArgumentError('Unknown TextDecorationLine value: $json'),
    };
  }

  @override
  String toJson(TextDecoration object) {
    return object.value;
  }
}

class FontStyleConverter extends JsonConverter<FontStyle, String> {
  const FontStyleConverter();

  @override
  FontStyle fromJson(String json) {
    return switch (json) {
      'normal' => FontStyle.normal,
      'italic' => FontStyle.italic,
      'oblique' => FontStyle.oblique,
      'inherit' => FontStyle.inherit,
      'initial' => FontStyle.initial,
      'revert' => FontStyle.revert,
      'revert-layer' => FontStyle.revertLayer,
      'unset' => FontStyle.unset,
      _ => throw ArgumentError('Unknown FontStyle value: $json'),
    };
  }

  @override
  String toJson(FontStyle object) {
    return object.value;
  }
}

class SpacingConverter extends JsonConverter<Spacing, Map<String, String>> {
  const SpacingConverter();

  @override
  Spacing fromJson(Map<String, String> json) {
    if (json.isEmpty) {
      return Spacing.zero;
    }

    Unit? parseUnitOrNull(String? unitStr) {
      if (unitStr == null) return null;
      try {
        return UnitExtension.parse(unitStr);
      } catch (e) {
        // Consider how UnitExtension.parse handles keywords; this might need adjustment.
        // For now, assume it throws for non-standard unit strings not handled by Spacing constants.
        print(
            'Warning: Could not parse unit string "$unitStr" for Spacing: $e');
        return null;
      }
    }

    // Handle Spacing constants like Spacing.inherit by checking their specific style representation
    if (json.length == 1 && json.containsKey('')) {
      final singleValue = json['']!;
      if (singleValue == 'inherit') return Spacing.inherit;
      if (singleValue == 'initial') return Spacing.initial;
      if (singleValue == 'revert') return Spacing.revert;
      if (singleValue == 'revert-layer') return Spacing.revertLayer;
      if (singleValue == 'unset') return Spacing.unset;
      // Spacing.zero is Spacing.all(Unit.zero), its style is {'': '0'}.
      // It will be correctly handled by the Spacing.all logic below if singleValue is '0'.
    }

    if (json.containsKey('')) {
      String value = json['']!;
      List<String> parts = value.split(' ').where((s) => s.isNotEmpty).toList();

      if (parts.length == 1) {
        Unit? parsed = parseUnitOrNull(parts[0]);
        if (parsed == null) {
          throw ArgumentError(
              'Invalid unit value for Spacing.all: ${parts[0]} from json $json');
        }
        return Spacing.all(parsed);
      } else if (parts.length == 2) {
        Unit? vertical = parseUnitOrNull(parts[0]);
        Unit? horizontal = parseUnitOrNull(parts[1]);
        if (vertical == null || horizontal == null) {
          throw ArgumentError(
              'Invalid unit values for Spacing.symmetric: $parts from json $json');
        }
        return Spacing.symmetric(vertical: vertical, horizontal: horizontal);
      } else if (parts.length == 4) {
        Unit? top = parseUnitOrNull(parts[0]);
        Unit? right = parseUnitOrNull(parts[1]);
        Unit? bottom = parseUnitOrNull(parts[2]);
        Unit? left = parseUnitOrNull(parts[3]);
        if (top == null || right == null || bottom == null || left == null) {
          throw ArgumentError(
              'Invalid unit values for Spacing.fromLTRB: $parts from json $json');
        }
        return Spacing.fromLTRB(left, top, right, bottom);
      } else {
        throw ArgumentError(
            'Invalid Spacing shorthand format: "$value" from json $json');
      }
    } else if (json.keys
        .any((k) => ['top', 'left', 'right', 'bottom'].contains(k))) {
      Unit? top = parseUnitOrNull(json['top']);
      Unit? bottom = parseUnitOrNull(json['bottom']);
      Unit? left = parseUnitOrNull(json['left']);
      Unit? right = parseUnitOrNull(json['right']);

      return Spacing.only(top: top, bottom: bottom, left: left, right: right);
    } else {
      throw ArgumentError('Unknown or unsupported Spacing format: $json');
    }
  }

  @override
  Map<String, String> toJson(Spacing object) {
    return object.styles;
  }
}
