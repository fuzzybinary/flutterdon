import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../mastodon/mastodon_api.dart';
import '../mastodon/mastodon_status_service.dart';
import '../mastodon/models.dart';
import '../widgets/status_cell.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.title});

  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  late MastodonStatusService statusService;

  @override
  void initState() {
    super.initState();

    //_loadTimeline();
    statusService = Provider.of<MastodonStatusService>(context, listen: false);
  }

  Future<void> _logout() async {
    final api = Provider.of<MastodonApi>(context, listen: false);
    await api.logout();
    GoRouter.of(context).replace('/login');
  }

  void _handleStatusTap(Status status) {
    var statusId = status.id;
    if (status.reblog != null) {
      statusId = status.reblog!.id;
    }
    GoRouter.of(context).push('/home/status/$statusId');
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
    return StreamBuilder<List<Status>>(
      stream: statusService.timelineStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('No data yet.');
        }
        final data = snapshot.data!;
        return ListView.builder(
          itemBuilder: (BuildContext buildContext, int index) {
            final item = data[index];
            return GestureDetector(
              onTap: () {
                _handleStatusTap(item);
              },
              child: StatusCell(
                key: Key(item.id),
                status: item,
              ),
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}
