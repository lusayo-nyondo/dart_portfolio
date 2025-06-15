// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buttons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonTheme _$ButtonThemeFromJson(Map<String, dynamic> json) => ButtonTheme(
      backgroundColor: _$JsonConverterFromJson<String, Color>(
          json['backgroundColor'], const ColorConverter().fromJson),
      foregroundColor: _$JsonConverterFromJson<String, Color>(
          json['foregroundColor'], const ColorConverter().fromJson),
      textStyle: json['textStyle'] == null
          ? null
          : TextStyle.fromJson(json['textStyle'] as Map<String, dynamic>),
      padding: _$JsonConverterFromJson<Map<String, String>, Spacing>(
          json['padding'], const SpacingConverter().fromJson),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      elevation: (json['elevation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ButtonThemeToJson(ButtonTheme instance) =>
    <String, dynamic>{
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const ColorConverter().toJson),
      'foregroundColor': _$JsonConverterToJson<String, Color>(
          instance.foregroundColor, const ColorConverter().toJson),
      'textStyle': instance.textStyle,
      'padding': _$JsonConverterToJson<Map<String, String>, Spacing>(
          instance.padding, const SpacingConverter().toJson),
      'borderRadius': instance.borderRadius,
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
