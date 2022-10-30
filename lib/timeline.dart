import 'dart:async';

import 'package:flutter/material.dart';

import 'mastodon/mastodon.dart';
import 'mastodon/models.dart';
import 'toot_details.dart';
import 'widgets/toot_cell_widget.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.title});

  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Toot>? _statusList;

  @override
  void initState() {
    super.initState();

    _loadTimeline();
  }

  Future<void> _logout() async {
    await MastodonInstanceManager.instance().currentApi?.logout();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future _loadTimeline() async {
    final mim = MastodonInstanceManager.instance();
    _statusList = await mim.currentApi?.getTimeline();

    setState(() => {});
  }

  void _handleTap(Toot status) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return TootDetailsPage(toot: status);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            child: const Text('Logout'),
            //textColor: Colors.white,
            onPressed: _logout,
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    if (_statusList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemBuilder: (BuildContext buildContext, int index) {
        return GestureDetector(
          onTap: () {
            _handleTap(_statusList![index]);
          },
          child: TootCell(status: _statusList![index]),
        );
      },
      itemCount: _statusList!.length,
    );
  }
}
