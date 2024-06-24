import 'package:app/app/app.dart';
import 'package:app/repository/auth.repo.dart';
import 'package:app/repository/budget.repo.dart';
import 'package:app/repository/health.repo.dart';
import 'package:app/repository/url.repo.dart';
import 'package:app/repository/user.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final prefs = await SharedPreferences.getInstance();

  final store = AsyncAuthStore(
    save: (data) async => prefs.setString('pb_auth', data),
    initial: prefs.getString('pb_auth'),
  );

  final pb = PocketBase('', authStore: store);

  return runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(pb: pb)),
        RepositoryProvider(create: (_) => BudgetRepository(pb: pb)),
        RepositoryProvider(create: (_) => HealthRepository(pb: pb)),
        RepositoryProvider(create: (_) => UrlRepository(pb: pb, prefs: prefs)),
        RepositoryProvider(create: (_) => UserRepository(pb: pb)),
      ],
      child: const FundwiseApp(),
    ),
  );
}
