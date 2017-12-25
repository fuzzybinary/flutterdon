import 'app_state.dart';

import 'mastodon/mastodon.dart';

// Base class so we don't have to rely on 'dynamic'
class Action {

}

class InitInstancesAction extends Action {

}

class NoInstancesFoundAction extends Action {

}

class LoginAction extends Action {
  final String instanceName;

  LoginAction(this.instanceName);
}

class LoginCompletedAction extends Action {
  final String instanceName;
  
  LoginCompletedAction(this.instanceName);
}

class LoginFailedAction extends Action {
  final String failureMessage;

  LoginFailedAction(this.failureMessage);
}

class LogoutAction extends Action {

}

class LoadTimelineAction extends Action {

}

class TimelineLoadFinihsed extends Action {
  final List<Status> timeline;

  TimelineLoadFinihsed(this.timeline);
}

AppState appReducer(AppState state, Action action) {
  switch(action.runtimeType) {
    case InitInstancesAction:
      return state.copyOf(instancesLoading: true);
    case NoInstancesFoundAction:
      return state.copyOf(instancesLoading: false, instanceName: '');
    case LoginCompletedAction:
      final LoginCompletedAction login = action;
      return state.copyOf(instancesLoading: false, instanceName: login.instanceName);
    case LoginFailedAction:
      final LoginFailedAction failure = action;
      return state.copyOf(lastExceptionMessage: failure.failureMessage);
    case LogoutAction:
      return state.copyOf(instanceName: '', isLoading: false);
    case TimelineLoadFinihsed:
      final TimelineLoadFinihsed timelineAciton = action;
      return state.copyOf(homeTimeline: timelineAciton.timeline);
  }
  return state;
}