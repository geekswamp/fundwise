import 'dart:async';

import 'package:app/settings_view.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> _dashboardRoutes() {
  return {
    '/settings': (BuildContext context) {
      return const SettingsView();
    },
    '/budget': (BuildContext context) {
      return const Center(
        child: Text('budget'),
      );
    },
    '/reports': (BuildContext context) {
      return const Center(
        child: Text('reports'),
      );
    },
    '/accounts': (BuildContext context) {
      return const Center(
        child: Text('accounts'),
      );
    },
  };
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => navigatorKey.currentState!;

  FutureOr<void> sidebarNavigate(String route) async {
    if (currentRoute == route) return;
    setState(() => currentRoute = route);
    await navigator.pushReplacementNamed(route);
  }

  static const initialRoute = '/settings';
  String? currentRoute = initialRoute;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = _dashboardRoutes()[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(4),
          child: builder(context),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: _Sidebar(sidebarNavigate, currentRoute),
          ),
          Expanded(
            child: Navigator(
              key: navigatorKey,
              initialRoute: initialRoute,
              onGenerateRoute: onGenerateRoute,
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatefulWidget {
  const _Sidebar(this.route, this.path);

  final FutureOr<void> Function(String path) route;
  final String? path;

  @override
  State<_Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<_Sidebar> {
  bool expanded = true;

  bool active(String path) => widget.path?.startsWith(path) ?? false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: context.boxDecorationTheme.boxDecoration,
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          Size.fromWidth(expanded ? 240 : 56),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _DashboardButton(
                    onPressed: () => widget.route('/settings'),
                    active: active('/settings'),
                    icon: const Icon(Icons.savings_rounded),
                    label: '<name of budget>',
                    labelBuilder: (label) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'user+fillerspace@fundwise.dev',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall
                              ?.copyWith(
                                color: active('/settings')
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.onPrimary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _DashboardButton(
                    onPressed: () => widget.route('/budget'),
                    active: active('/budget'),
                    icon: const Icon(Icons.wallet),
                    label: 'Budget',
                    labelBuilder: (label) => Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _DashboardButton(
                    onPressed: () => widget.route('/reports'),
                    active: active('/reports'),
                    icon: const Icon(Icons.bar_chart),
                    label: 'Reports',
                    labelBuilder: (label) => Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _DashboardButton(
                    onPressed: () => widget.route('/accounts'),
                    active: active('/accounts'),
                    icon: const Icon(Icons.account_balance),
                    label: 'Acounts',
                    labelBuilder: (label) => Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                label: expanded // fmt
                    ? const Text('Collapse')
                    : const SizedBox.shrink(),
                onPressed: () => setState(() => expanded = !expanded),
                icon: Icon(
                  expanded
                      ? Icons.arrow_left_rounded
                      : Icons.arrow_right_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  const _DashboardButton({
    required this.onPressed,
    required this.icon,
    required this.active,
    required this.label,
    required this.labelBuilder,
  });

  final VoidCallback onPressed;

  final Icon icon;
  final bool active;
  final String label;
  final Widget Function(String label) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, contraints) {
          if (contraints.maxWidth < (IconTheme.of(context).size ?? 0) + 72) {
            return IconButton.outlined(
              tooltip: label,
              visualDensity: VisualDensity.compact,
              color: active
                  ? Theme.of(context).colorScheme.onTertiaryContainer
                  : Theme.of(context).colorScheme.onSecondary,
              style: IconButton.styleFrom(),
              onPressed: onPressed,
              icon: icon,
            );
          }

          return TextButton.icon(
            icon: icon,
            onPressed: onPressed,
            label: labelBuilder(label),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.standard,
              backgroundColor: active
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.tertiaryContainer,
              foregroundColor: active
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          );
        },
      ),
    );
  }
}
