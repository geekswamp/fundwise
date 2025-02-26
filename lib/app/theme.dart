import 'package:flutter/material.dart';

ThemeData _with(ColorScheme colorScheme) {
  return ThemeData.from(colorScheme: colorScheme).copyWith(
    dividerTheme: DividerThemeData(
      space: 0,
      endIndent: 0,
      thickness: 1,
      indent: 0,
      color: colorScheme.onSurface,
    ),
  );
}

ThemeData themeDataLight = _with(lightScheme);
ThemeData themeDataDark = _with(darkScheme);

const ColorScheme lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff1565c0),
  onPrimary: Color(0xfff0f6fe),
  primaryContainer: Color(0xff90caf9),
  onPrimaryContainer: Color(0xff192228),
  secondary: Color(0xff039be5),
  onSecondary: Color(0xffeffbff),
  secondaryContainer: Color(0xffcbe6ff),
  onSecondaryContainer: Color(0xff222728),
  tertiary: Color(0xff0277bd),
  onTertiary: Color(0xffeff8fd),
  tertiaryContainer: Color(0xff97d1f4),
  onTertiaryContainer: Color(0xff1a2328),
  error: Color(0xffb00020),
  onError: Color(0xfffceff1),
  errorContainer: Color(0xfffcd8df),
  onErrorContainer: Color(0xff282526),
  surface: Color(0xfffafbfd),
  onSurface: Color(0xff090909),
  surfaceContainerHighest: Color(0xffe5e8ec),
  onSurfaceVariant: Color(0xff111212),
  outline: Color(0xff868686),
  outlineVariant: Color(0xffd2d2d2),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff111214),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xffaedfff),
  surfaceTint: Color(0xff1565c0),
);

const ColorScheme darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff90caf9),
  onPrimary: Color(0xff1e2728),
  primaryContainer: Color(0xff0d47a1),
  onPrimaryContainer: Color(0xffc4d6f3),
  secondary: Color(0xff81d4fa),
  onSecondary: Color(0xff1c2828),
  secondaryContainer: Color(0xff004b73),
  onSecondaryContainer: Color(0xffc0d8e4),
  tertiary: Color(0xffe1f5fe),
  onTertiary: Color(0xff282828),
  tertiaryContainer: Color(0xff3c5864),
  onTertiaryContainer: Color(0xffd3dcdf),
  error: Color(0xffcf6679),
  onError: Color(0xff28181a),
  errorContainer: Color(0xffb1384e),
  onErrorContainer: Color(0xfff8d2d9),
  surface: Color(0xff141617),
  onSurface: Color(0xffececec),
  surfaceContainerHighest: Color(0xff373a3c),
  onSurfaceVariant: Color(0xffdfe0e0),
  outline: Color(0xff666969),
  outlineVariant: Color(0xff1b1c1c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffbfdfe),
  onInverseSurface: Color(0xff131313),
  inversePrimary: Color(0xff4a6373),
  surfaceTint: Color(0xff90caf9),
);
