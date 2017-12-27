import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app_reducer.dart';
import 'app_state.dart';

class LoginPage extends StatelessWidget {
  final _textEditingController = new TextEditingController();
  
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) => new _ViewModel(
        store.state.isLoading,
        store.state.lastExceptionMessage, 
        () {
          store.dispatch(new LoginAction(_textEditingController.text));
        }      
      ),
      onInit: (store) {
        StreamSubscription<AppState> subscription;
        subscription = store.onChange.listen((AppState state) {
          if(state.instanceName != null && state.instanceName.isNotEmpty) {
            Navigator.of(context).pushReplacementNamed('/timeline');
            subscription.cancel();
          }
        });
      },
      builder: (buildContext, vm) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Login'),
          ),
          body: new Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Mastodon Instance:',
                  ),
                  new TextField(
                    controller: _textEditingController,
                    autofocus: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'ex: mastodon.social'
                    ),
                  ),
                  new FlatButton(
                    onPressed: vm.onLogin,
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: const Text('Login'),
                  ),
                  vm.isLoading ? const CircularProgressIndicator() : new Container(),
                  vm.exceptionMessage == null ? new Container() : 
                    new Text(vm.exceptionMessage,
                      style: new TextStyle(color: Colors.red)
                    ) 
                ],
              ),
            ),
          )
        );
      }
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final String exceptionMessage;
  final Function() onLogin;
  
  _ViewModel(this.isLoading, this.exceptionMessage, this.onLogin);
}