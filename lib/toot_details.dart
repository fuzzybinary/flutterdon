import 'dart:async';

import 'package:flutter/material.dart';

import 'mastodon/mastodon.dart';
import 'mastodon/models.dart';
import 'widgets/toot_cell_widget.dart';

class TootDetailsPage extends StatelessWidget {
  final Toot toot;

  const TootDetailsPage({super.key, required this.toot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('toot')),
      body: _InnerTootDetailsPage(toot: toot),
    );
  }
}

class _InnerTootDetailsPage extends StatefulWidget {
  final Toot toot;

  const _InnerTootDetailsPage({required this.toot});

  @override
  _TootDetailsState createState() => _TootDetailsState();
}

class _TootDetailsState extends State<_InnerTootDetailsPage> {
  int rootIndex = 0;
  bool loading = false;
  Context? tootContext;

  Future<void> _loadContext() async {
    setState(() {
      loading = true;
    });

    try {
      tootContext = await MastodonInstanceManager.instance()
          .currentApi
          ?.getContext(widget.toot);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading toot: $e'),
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
    if (tootContext != null) {
      itemCount =
          tootContext!.ancestors.length + tootContext!.descendants.length + 1;
    }
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        var status = widget.toot;
        if (tootContext != null) {
          if (index < tootContext!.ancestors.length) {
            status = tootContext!.ancestors[index];
          } else {
            index -= (tootContext!.ancestors.length + 1);
            if (index >= 0 && index < tootContext!.descendants.length) {
              status = tootContext!.descendants[index];
            }
          }
        }
        return TootCell(status: status);
      },
    );
  }
}
