import 'dart:async';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) {
        StreamSubscription<AppState> subscription;
        subscription = store.onChange.listen((AppState state) {
          if(!state.instancesLoading) {
            if(state.instanceName != null) {
              Navigator.of(context).pushReplacementNamed('/timeline');
            } else {
              Navigator.of(context).pushReplacementNamed('/login');
            }
            subscription.cancel();
          }
        });
      },
      builder: (constext, state) {
        return new Scaffold(
          body: new Center(
            child:  const CircularProgressIndicator()
          )
        );
      }
    );
  }
}