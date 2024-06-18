import 'package:app/app/router.dart';
import 'package:app/components/context_extension.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class FundwiseApp extends StatefulWidget {
  const FundwiseApp({super.key});

  @override
  State<FundwiseApp> createState() => _FundwiseAppState();
}

class _FundwiseAppState extends State<FundwiseApp> {
  late final _router = router(context.pb.authStore.onChange);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: _router,
    );
  }

  ThemeData get lightTheme {
    const defaulElevation = WidgetStatePropertyAll<double>(0);

    final defaultShape = WidgetStatePropertyAll(
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
    const dividerThemeData = DividerThemeData(space: 0);
    final cardTheme = CardTheme(
      elevation: defaulElevation.value,
      shape: defaultShape.value,
    );

    final textButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        elevation: defaulElevation,
        shape: defaultShape,
      ),
    );

    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        elevation: const WidgetStatePropertyAll(0),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        shape: defaultShape,
      ),
    );

    return FlexThemeData.light(
      scheme: FlexScheme.dellGenoa,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        elevatedButtonRadius: 8,
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ).copyWith(
      cardTheme: cardTheme,
      dividerTheme: dividerThemeData,
      elevatedButtonTheme: elevatedButtonTheme,
      textButtonTheme: textButtonTheme,
    );
  }
}
