// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextStyle _$TextStyleFromJson(Map<String, dynamic> json) => TextStyle(
      fontSize: _$JsonConverterFromJson<String, Unit>(
          json['fontSize'], const UnitConverter().fromJson),
      fontWeight: _$JsonConverterFromJson<String, FontWeight>(
          json['fontWeight'], const FontWeightConverter().fromJson),
      color: _$JsonConverterFromJson<String, Color>(
          json['color'], const ColorConverter().fromJson),
      fontFamily: json['fontFamily'] as String?,
      decoration: _$JsonConverterFromJson<String, TextDecoration>(
          json['decoration'], const TextDecorationConverter().fromJson),
      decorationColor: _$JsonConverterFromJson<String, Color>(
          json['decorationColor'], const ColorConverter().fromJson),
      decorationStyle: $enumDecodeNullable(
          _$TextDecorationStyleEnumMap, json['decorationStyle']),
      letterSpacing: _$JsonConverterFromJson<String, Unit>(
          json['letterSpacing'], const UnitConverter().fromJson),
      wordSpacing: _$JsonConverterFromJson<String, Unit>(
          json['wordSpacing'], const UnitConverter().fromJson),
      lineHeight: _$JsonConverterFromJson<String, Unit>(
          json['lineHeight'], const UnitConverter().fromJson),
      fontStyle: _$JsonConverterFromJson<String, FontStyle>(
          json['fontStyle'], const FontStyleConverter().fromJson),
    );

Map<String, dynamic> _$TextStyleToJson(TextStyle instance) => <String, dynamic>{
      'fontSize': _$JsonConverterToJson<String, Unit>(
          instance.fontSize, const UnitConverter().toJson),
      'fontWeight': _$JsonConverterToJson<String, FontWeight>(
          instance.fontWeight, const FontWeightConverter().toJson),
      'color': _$JsonConverterToJson<String, Color>(
          instance.color, const ColorConverter().toJson),
      'fontFamily': instance.fontFamily,
      'decoration': _$JsonConverterToJson<String, TextDecoration>(
          instance.decoration, const TextDecorationConverter().toJson),
      'decorationColor': _$JsonConverterToJson<String, Color>(
          instance.decorationColor, const ColorConverter().toJson),
      'decorationStyle': _$TextDecorationStyleEnumMap[instance.decorationStyle],
      'letterSpacing': _$JsonConverterToJson<String, Unit>(
          instance.letterSpacing, const UnitConverter().toJson),
      'wordSpacing': _$JsonConverterToJson<String, Unit>(
          instance.wordSpacing, const UnitConverter().toJson),
      'lineHeight': _$JsonConverterToJson<String, Unit>(
          instance.lineHeight, const UnitConverter().toJson),
      'fontStyle': _$JsonConverterToJson<String, FontStyle>(
          instance.fontStyle, const FontStyleConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
  TextDecorationStyle.inherit: 'inherit',
  TextDecorationStyle.initial: 'initial',
  TextDecorationStyle.revert: 'revert',
  TextDecorationStyle.revertLayer: 'revertLayer',
  TextDecorationStyle.unset: 'unset',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

TextTheme _$TextThemeFromJson(Map<String, dynamic> json) => TextTheme(
      headlineLarge:
          TextStyle.fromJson(json['headlineLarge'] as Map<String, dynamic>),
      headlineMedium:
          TextStyle.fromJson(json['headlineMedium'] as Map<String, dynamic>),
      headlineSmall:
          TextStyle.fromJson(json['headlineSmall'] as Map<String, dynamic>),
      displayLarge:
          TextStyle.fromJson(json['displayLarge'] as Map<String, dynamic>),
      displayMedium:
          TextStyle.fromJson(json['displayMedium'] as Map<String, dynamic>),
      displaySmall:
          TextStyle.fromJson(json['displaySmall'] as Map<String, dynamic>),
      bodyLarge: TextStyle.fromJson(json['bodyLarge'] as Map<String, dynamic>),
      bodyMedium:
          TextStyle.fromJson(json['bodyMedium'] as Map<String, dynamic>),
      bodySmall: TextStyle.fromJson(json['bodySmall'] as Map<String, dynamic>),
      titleLarge:
          TextStyle.fromJson(json['titleLarge'] as Map<String, dynamic>),
      titleMedium:
          TextStyle.fromJson(json['titleMedium'] as Map<String, dynamic>),
      titleSmall:
          TextStyle.fromJson(json['titleSmall'] as Map<String, dynamic>),
      labelLarge:
          TextStyle.fromJson(json['labelLarge'] as Map<String, dynamic>),
      labelMedium:
          TextStyle.fromJson(json['labelMedium'] as Map<String, dynamic>),
      labelSmall:
          TextStyle.fromJson(json['labelSmall'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TextThemeToJson(TextTheme instance) => <String, dynamic>{
      'headlineLarge': instance.headlineLarge,
      'headlineMedium': instance.headlineMedium,
      'headlineSmall': instance.headlineSmall,
      'displayLarge': instance.displayLarge,
      'displayMedium': instance.displayMedium,
      'displaySmall': instance.displaySmall,
      'bodyLarge': instance.bodyLarge,
      'bodyMedium': instance.bodyMedium,
      'bodySmall': instance.bodySmall,
      'titleLarge': instance.titleLarge,
      'titleMedium': instance.titleMedium,
      'titleSmall': instance.titleSmall,
      'labelLarge': instance.labelLarge,
      'labelMedium': instance.labelMedium,
      'labelSmall': instance.labelSmall,
    };
