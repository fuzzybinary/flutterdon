import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import 'app_reducer.dart';
import 'app_state.dart';

import 'mastodon/mastodon.dart';
import 'widgets/toot_cell_widget.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key key}) : super(key: key);

  void _logout(BuildContext context, Store<AppState> store) {
    store.dispatch(new LogoutAction());
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return new _ViewModel(store.state.homeTimeline, () {
          _logout(context, store);
        });
      },
      onInit: (store) => store.dispatch(new LoadTimelineAction()),
      builder: (context, vm) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Flutterdon'),
            actions: <Widget>[
              new FlatButton(
                child: const Text('Logout'),
                textColor: Colors.white,
                onPressed: vm.logoutFunction
              )
            ],
          ),
          body: _buildBody(vm.timeline)
        );
      }
    );
  }

  Widget _buildBody(List<Status> timeline) {
    if(timeline == null ) {
      return new Center(
        child: const CircularProgressIndicator(),
      );
    }
    return new ListView.builder(
      itemBuilder: (BuildContext buildContext, int index) => new TootCell(status: timeline[index]),
      itemCount: timeline.length 
    );
  }
}

class _ViewModel {
  final List<Status> timeline;
  final Function() logoutFunction;

  _ViewModel(this.timeline, this.logoutFunction);
}