import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'mastodon/mastodon_instance_manager.dart';

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

    SchedulerBinding.instance
        .addPostFrameCallback((_) => _checkExistingInstance());
  }

  Future _checkExistingInstance() async {
    final mim = Provider.of<MastodonInstanceManager>(context, listen: false);
    final instanceList = await mim.getRegisteredInstances();
    if (instanceList == null) {
      _gotoLogin();
    } else {
      // For now, only care about the first instance:
      final instanceName = instanceList.first;
      try {
        await mim.loginToInstance(instanceName);
        _gotoTimeline();
      } catch (e) {
        _gotoLogin();
      }
    }
  }

  void _gotoLogin() {
    GoRouter.of(context).replace('/login');
  }

  void _gotoTimeline() {
    GoRouter.of(context).replace('/timeline');
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
