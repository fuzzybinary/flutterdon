import 'dart:async';

import 'package:flutter/material.dart';

import 'mastodon/mastodon.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.title});

  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _checkExistingInstance();
  }

  Future _checkExistingInstance() async {
    final mim = MastodonInstanceManager.instance();
    final instanceList = await mim.getRegisteredInstances();
    if (instanceList == null) {
      _gotoLogin();
    } else {
      // For now, only care about the first instance:
      final instanceName = instanceList.first;
      final client = MastodonApi(instanceName);
      try {
        await client.login();
        _gotoTimeline();
      } catch (e) {
        _gotoLogin();
      }
    }
  }

  void _gotoLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _gotoTimeline() {
    Navigator.of(context).pushReplacementNamed('/timeline');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
