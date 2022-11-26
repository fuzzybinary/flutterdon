import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'mastodon/mastodon_api.dart';
import 'mastodon/mastodon_instance_manager.dart';
import 'mastodon/mastodon_status_service.dart';
import 'pages/login.dart';
import 'pages/splash.dart';
import 'pages/status_details.dart';
import 'pages/timeline.dart';
import 'theming/theme_data.dart';
import 'utilities/platform_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (PlatformUtils.isDesktop) {
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setSize(const Size(600, 900));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(title: 'Flutterdon'),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          const LoginPage(title: 'Select Mastodon Instance'),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const TimelinePage(title: 'Timeline'),
      routes: [
        GoRoute(
          path: 'status/:id',
          builder: (context, state) =>
              StatusDetailsPage(statusId: state.params['id']!),
        ),
      ],
    ),
  ]);

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => FlutterdonThemeData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MastodonInstanceManager(),
        ),
        ProxyProvider<MastodonInstanceManager, MastodonApi?>(
          update: (_, instanceManager, __) => instanceManager.currentApi,
        ),
        ProxyProvider<MastodonApi, MastodonStatusService?>(
          update: (_, mastodonApi, __) => MastodonStatusService(mastodonApi),
        )
      ],
      child: Consumer<FlutterdonThemeData>(builder: (context, themeData, __) {
        return MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: 'Flutterdon',
          darkTheme: themeData.darkTheme,
          theme: themeData.lightTheme,
          themeMode: ThemeMode.dark,
        );
      }),
    );
  }
}
