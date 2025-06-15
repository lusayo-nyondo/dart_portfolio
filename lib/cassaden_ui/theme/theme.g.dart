// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeData _$ThemeDataFromJson(Map<String, dynamic> json) => ThemeData(
      colorScheme:
          ColorTheme.fromJson(json['colorScheme'] as Map<String, dynamic>),
      textTheme: TextTheme.fromJson(json['textTheme'] as Map<String, dynamic>),
      brightness:
          $enumDecodeNullable(_$BrightnessEnumMap, json['brightness']) ??
              Brightness.dark,
      appBarTheme: json['appBarTheme'] == null
          ? const AppBarTheme()
          : AppBarTheme.fromJson(json['appBarTheme'] as Map<String, dynamic>),
      buttonTheme: json['buttonTheme'] == null
          ? const ButtonTheme()
          : ButtonTheme.fromJson(json['buttonTheme'] as Map<String, dynamic>),
      fontFamily: json['fontFamily'] as String?,
      scaffoldBackgroundColor: _$JsonConverterFromJson<String, Color>(
          json['scaffoldBackgroundColor'], const ColorConverter().fromJson),
      defaultBorderRadius:
          (json['defaultBorderRadius'] as num?)?.toDouble() ?? 4.0,
    );

Map<String, dynamic> _$ThemeDataToJson(ThemeData instance) => <String, dynamic>{
      'brightness': _$BrightnessEnumMap[instance.brightness]!,
      'colorScheme': instance.colorScheme,
      'textTheme': instance.textTheme,
      'appBarTheme': instance.appBarTheme,
      'buttonTheme': instance.buttonTheme,
      'fontFamily': instance.fontFamily,
      'scaffoldBackgroundColor': _$JsonConverterToJson<String, Color>(
          instance.scaffoldBackgroundColor, const ColorConverter().toJson),
      'defaultBorderRadius': instance.defaultBorderRadius,
    };

const _$BrightnessEnumMap = {
  Brightness.light: 'light',
  Brightness.dark: 'dark',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
