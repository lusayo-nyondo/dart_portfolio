// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppBarTheme _$AppBarThemeFromJson(Map<String, dynamic> json) => AppBarTheme(
      backgroundColor: _$JsonConverterFromJson<String, Color>(
          json['backgroundColor'], const ColorConverter().fromJson),
      foregroundColor: _$JsonConverterFromJson<String, Color>(
          json['foregroundColor'], const ColorConverter().fromJson),
      titleTextStyle: json['titleTextStyle'] == null
          ? null
          : TextStyle.fromJson(json['titleTextStyle'] as Map<String, dynamic>),
      elevation: (json['elevation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AppBarThemeToJson(AppBarTheme instance) =>
    <String, dynamic>{
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const ColorConverter().toJson),
      'foregroundColor': _$JsonConverterToJson<String, Color>(
          instance.foregroundColor, const ColorConverter().toJson),
      'titleTextStyle': instance.titleTextStyle,
      'elevation': instance.elevation,
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
