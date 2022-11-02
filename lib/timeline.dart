import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'mastodon/mastodon_api.dart';
import 'mastodon/models.dart';
import 'status_details.dart';
import 'widgets/status_cell.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.title});

  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Status>? _statusList;

  @override
  void initState() {
    super.initState();

    _loadTimeline();
  }

  Future<void> _logout() async {
    final api = Provider.of<MastodonApi>(context, listen: false);
    await api.logout();
    GoRouter.of(context).replace('/login');
  }

  Future _loadTimeline() async {
    final api = Provider.of<MastodonApi>(context, listen: false);
    _statusList = await api.getTimeline();

    setState(() => {});
  }

  void _handleTap(Status status) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return StatusDetailsPage(status: status);
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
          child: StatusCell(status: _statusList![index]),
        );
      },
      itemCount: _statusList!.length,
    );
  }
}
