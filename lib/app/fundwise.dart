import 'package:app/app/app.dart';
import 'package:app/authentication/authentication.dart';
import 'package:app/home/home_location.dart';
import 'package:app/login/login_location.dart';
import 'package:app/repository/repository.dart';
import 'package:app/router/router.dart';
import 'package:app/splash/splash.dart';
import 'package:app/startup/startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix/mix.dart';

class FundwiseApp extends StatefulWidget {
  const FundwiseApp({required this.authentication, super.key});
  final AuthenticationRepository authentication;

  @override
  State<FundwiseApp> createState() => _FundwiseAppState();
}

class _FundwiseAppState extends State<FundwiseApp> {
  late final DuckRouter router;

  @override
  void initState() {
    router = duckRouter(
      authentication: () => widget.authentication,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartUpBloc, StartUpState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: router,
          theme: themeDataLight,
          darkTheme: themeDataDark,
          builder: (context, child) {
            if (state is LoadingStartUpState) return const Splash();

            return MixTheme(
              data: MixThemeData.withMaterial(),
              child: AuthenticationNavigation(
                onAuthenticated: () => router.navigate(
                  to: HomeLocation(),
                  replace: true,
                ),
                onNotAuthenticated: () => router.navigate(
                  to: LoginLocation(),
                  clearStack: true,
                  root: true,
                  replace: true,
                ),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
