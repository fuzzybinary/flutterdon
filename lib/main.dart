import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'login.dart';
import 'mastodon/mastodon_api.dart';
import 'mastodon/mastodon_instance_manager.dart';
import 'mastodon/mastodon_status_service.dart';
import 'splash.dart';
import 'status_details.dart';
import 'timeline.dart';
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
          )
        ]),
  ]);

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MastodonInstanceManager(),
        ),
        ProxyProvider<MastodonInstanceManager, MastodonApi?>(
          update: (_, instanceManager, __) => instanceManager.currentApi,
        ),
        ProxyProvider<MastodonApi, MastodonStatusService?>(
          update: (_, mastodonApi, __) => MastodonStatusService(mastodonApi),
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Flutterdon',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            color: Colors.lightBlue,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
