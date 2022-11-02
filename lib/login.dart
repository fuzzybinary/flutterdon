import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'mastodon/mastodon_instance_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEditingController = TextEditingController();
  var _loading = false;
  String? _exceptionMessage;

  void _performLogin() {
    _login();

    setState(() {
      _exceptionMessage = '';
      _loading = true;
    });
  }

  Future _login() async {
    final instanceManager =
        Provider.of<MastodonInstanceManager>(context, listen: false);

    try {
      await instanceManager.loginToInstance(_textEditingController.text);
      GoRouter.of(context).replace('/home');
    } catch (exception) {
      setState(() {
        _loading = false;
        _exceptionMessage = exception.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Mastodon Instance:',
              ),
              TextField(
                controller: _textEditingController,
                autofocus: true,
                autocorrect: false,
                decoration:
                    const InputDecoration(hintText: 'ex: mastodon.social'),
              ),
              TextButton(
                onPressed: _loading ? null : _performLogin,
                //color: Colors.blueAccent,
                //textColor: Colors.white,
                child: const Text('Login'),
              ),
              if (_loading) const CircularProgressIndicator(),
              if (_exceptionMessage != null)
                Text(
                  _exceptionMessage!,
                  style: const TextStyle(color: Colors.red),
                )
            ],
          ),
        ),
      ),
    );
  }
}
