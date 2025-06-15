// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorTheme _$ColorThemeFromJson(Map<String, dynamic> json) => ColorTheme(
      primary: const ColorConverter().fromJson(json['primary'] as String),
      primaryVariant:
          const ColorConverter().fromJson(json['primaryVariant'] as String),
      secondary: const ColorConverter().fromJson(json['secondary'] as String),
      secondaryVariant:
          const ColorConverter().fromJson(json['secondaryVariant'] as String),
      surface: const ColorConverter().fromJson(json['surface'] as String),
      background: const ColorConverter().fromJson(json['background'] as String),
      error: const ColorConverter().fromJson(json['error'] as String),
      onPrimary: const ColorConverter().fromJson(json['onPrimary'] as String),
      onSecondary:
          const ColorConverter().fromJson(json['onSecondary'] as String),
      onSurface: const ColorConverter().fromJson(json['onSurface'] as String),
      onBackground:
          const ColorConverter().fromJson(json['onBackground'] as String),
      onError: const ColorConverter().fromJson(json['onError'] as String),
    );

Map<String, dynamic> _$ColorThemeToJson(ColorTheme instance) =>
    <String, dynamic>{
      'primary': const ColorConverter().toJson(instance.primary),
      'primaryVariant': const ColorConverter().toJson(instance.primaryVariant),
      'secondary': const ColorConverter().toJson(instance.secondary),
      'secondaryVariant':
          const ColorConverter().toJson(instance.secondaryVariant),
      'surface': const ColorConverter().toJson(instance.surface),
      'background': const ColorConverter().toJson(instance.background),
      'error': const ColorConverter().toJson(instance.error),
      'onPrimary': const ColorConverter().toJson(instance.onPrimary),
      'onSecondary': const ColorConverter().toJson(instance.onSecondary),
      'onSurface': const ColorConverter().toJson(instance.onSurface),
      'onBackground': const ColorConverter().toJson(instance.onBackground),
      'onError': const ColorConverter().toJson(instance.onError),
    };
