import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mastodon/mastodon_api.dart';
import 'mastodon/models.dart';
import 'widgets/status_cell.dart';

class StatusDetailsPage extends StatelessWidget {
  final Status status;

  const StatusDetailsPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status')),
      body: _InnerStatusDetailsPage(status: status),
    );
  }
}

class _InnerStatusDetailsPage extends StatefulWidget {
  final Status status;

  const _InnerStatusDetailsPage({required this.status});

  @override
  _StatusDetailsState createState() => _StatusDetailsState();
}

class _StatusDetailsState extends State<_InnerStatusDetailsPage> {
  int rootIndex = 0;
  bool loading = false;
  Context? statusContext;

  Future<void> _loadContext() async {
    setState(() {
      loading = true;
    });

    try {
      final api = Provider.of<MastodonApi>(context, listen: false);
      statusContext = await api.getContext(widget.status);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading status: $e'),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadContext();
  }

  @override
  Widget build(BuildContext context) {
    var itemCount = 1;
    if (statusContext != null) {
      itemCount = statusContext!.ancestors.length +
          statusContext!.descendants.length +
          1;
    }
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        var status = widget.status;
        if (statusContext != null) {
          if (index < statusContext!.ancestors.length) {
            status = statusContext!.ancestors[index];
          } else {
            var descendentIndex = index - (statusContext!.ancestors.length + 1);
            if (descendentIndex >= 0 &&
                descendentIndex < statusContext!.descendants.length) {
              status = statusContext!.descendants[descendentIndex];
            }
          }
        }
        return StatusCell(
          status: status,
          isFirst: index == 0,
          isLast: index == (itemCount - 1),
        );
      },
    );
  }
}
