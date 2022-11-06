import 'dart:async';

import 'package:cancellation_token_http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mastodon/mastodon_status_service.dart';
import 'mastodon/models.dart';
import 'widgets/status_cell.dart';

class StatusDetailsPage extends StatelessWidget {
  final String statusId;

  const StatusDetailsPage({super.key, required this.statusId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status')),
      body: _InnerStatusDetailsPage(statusId: statusId),
    );
  }
}

class _InnerStatusDetailsPage extends StatefulWidget {
  final String statusId;

  const _InnerStatusDetailsPage({required this.statusId});

  @override
  _StatusDetailsState createState() => _StatusDetailsState();
}

enum _StatusLoadingState {
  statusLoading,
  contextLoading,
  done,
}

class _StatusDetailsState extends State<_InnerStatusDetailsPage> {
  late MastodonStatusService statusService;
  int statusIndex = 0;

  _StatusLoadingState _loadingState = _StatusLoadingState.statusLoading;
  CancellationToken? _cancellationToken;
  Status? status;
  Context? statusContext;

  Future<void> _loadContext() async {
    try {
      setState(() {
        _loadingState = _StatusLoadingState.statusLoading;
      });
      _cancellationToken = CancellationToken();
      status = await statusService.fetchStatus(
        widget.statusId,
        cancellationToken: _cancellationToken,
      );

      setState(() {
        _loadingState = _StatusLoadingState.contextLoading;
      });

      statusContext = await statusService.fetchStatusContext(
        status!,
        cancellationToken: _cancellationToken,
      );

      setState(() {
        _loadingState = _StatusLoadingState.done;
      });

      _cancellationToken = null;
    } on CancelledException {
      // Nothing to do
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading status: $e'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    statusService = Provider.of<MastodonStatusService>(context, listen: false);
    _loadContext();
  }

  @override
  void dispose() {
    super.dispose();

    _cancellationToken?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loadingState) {
      case _StatusLoadingState.statusLoading:
        return _fullPageLoading();
      case _StatusLoadingState.contextLoading:
        return _statusLoadingContext(status!);
      case _StatusLoadingState.done:
        return _fullyLoaded();
    }
  }

  Widget _fullPageLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _statusLoadingContext(Status status) {
    return ListView.builder(
      key: const Key('status_context_key'),
      itemCount: 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return StatusCell(key: Key(status.id), status: status);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _fullyLoaded() {
    var itemCount = 1;
    if (statusContext != null) {
      itemCount = statusContext!.ancestors.length +
          statusContext!.descendants.length +
          1;
    }
    return ListView.builder(
      key: const Key('status_context_key'),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        var status = this.status!;
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
