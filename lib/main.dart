import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app_reducer.dart';
import 'app_state.dart';

import 'login.dart';
import 'middleware/mastodon_api_middleware.dart';
import 'splash.dart';
import 'timeline.dart';

void main() {
  runApp(new FlutterdonApp());
}

class FlutterdonApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.initial(),
    middleware: [ 
      createMastodonMiddleware()
    ]
  );
  
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Flutterdon',
        theme: new ThemeData(
          primarySwatch: Colors.blue
        ),
        routes: {
          '/': (context) {
            return new StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(new InitInstancesAction()),
              builder: (context, builder) {
                return const SplashPage();
              },
            );
          },
          '/login': (context) {
            return new StoreBuilder<AppState>(
              builder: (context, builder) {
                return new LoginPage();
              },
            );
          },
          '/timeline': (context) {
            return new StoreBuilder<AppState>(
              builder: (context, builder) {
                return const TimelinePage();
              },
            );
          }
        },
      )
    );
  }
}
