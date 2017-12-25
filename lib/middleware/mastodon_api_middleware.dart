import 'dart:async';

import 'package:redux/redux.dart';

import '../app_reducer.dart';
import '../app_state.dart';
import '../mastodon/mastodon.dart';

Middleware<AppState> createMastodonMiddleware() {
  return (Store<AppState> store, Action action, NextDispatcher next) async {
    next(action);
    
    switch(action.runtimeType) {
      case InitInstancesAction:
        _initInstances(store);
        break;
      case LoginAction:
        _login(store, action);
        break;
      case LogoutAction:
        _logout(store);
        break;
      case LoadTimelineAction:
        _loadTimeline(store);
        break;
    }    
  };
}

Future<Null> _initInstances(Store<AppState> store) async {
  final mim = MastodonInstanceManager.instance();
  final instanceList = await mim.getRegisteredInstances();
  if(instanceList == null) {
    store.dispatch(new NoInstancesFoundAction());
  } else {
    // For now, only care about the first instance:
    final instanceName = instanceList.first;
    final client = new MastodonApi(instanceName);
    try {
      await client.login();
      store.dispatch(new LoginCompletedAction(instanceName));
    } catch(e) {
      store.dispatch(new NoInstancesFoundAction());
    }
  }  
}

Future<Null> _login(Store<AppState> store, LoginAction action) async {
  final api = new MastodonApi(action.instanceName);
  try {
    await api.login();
    store.dispatch(new LoginCompletedAction(action.instanceName));
  } catch(exception) {
    store.dispatch(new LoginFailedAction(exception.toString()));
  }
}

Future<Null> _logout(Store<AppState> store) async {
  final mim = MastodonInstanceManager.instance();
  await mim.currentApi.logout();
  mim.currentApi = null;
}

Future<Null> _loadTimeline(Store<AppState> store) async {
  final mim = MastodonInstanceManager.instance();
  try {
    final timeline = await mim.currentApi.getTimeline();
    store.dispatch(new TimelineLoadFinihsed(timeline));
  } catch(exception) {

  }
}