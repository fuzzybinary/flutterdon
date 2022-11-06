// The bridge between all the different ways to fetch and store data
import 'dart:async';

import 'package:cancellation_token_http/http.dart';

import 'mastodon_api.dart';
import 'models.dart';

class MastodonStatusService {
  final MastodonApi mastodonApi;

  bool _updatingTimeline = false;
  Future<void>? _fetchFuture;

  late StreamController<List<Status>> timelineController;
  List<Status> currentTimeline = [];
  final Map<String, Status> _statusMap = {};

  MastodonStatusService(this.mastodonApi) {
    timelineController = StreamController.broadcast(
        onListen: _onTimelineListen, onCancel: _onTimelineCancel);
  }

  Stream<List<Status>> timelineStream() {
    return timelineController.stream;
  }

  Future<Status> fetchStatus(String id,
      {CancellationToken? cancellationToken}) async {
    var status = _statusMap[id];
    status ??= await mastodonApi.getStatus(
      id,
      cancellationToken: cancellationToken,
    );
    _statusMap[id] = status;
    return status;
  }

  Future<Context> fetchStatusContext(Status status,
      {CancellationToken? cancellationToken}) async {
    var context = await mastodonApi.getContext(
      status,
      cancellationToken: cancellationToken,
    );
    for (final s in context.ancestors) {
      _statusMap[s.id] = s;
    }
    for (final s in context.descendants) {
      _statusMap[s.id] = s;
    }
    return context;
  }

  Future<void> _fetchTimeline() async {
    while (_updatingTimeline) {
      String? minId;
      if (currentTimeline.isNotEmpty) {
        minId = currentTimeline.first.id;
      }
      final statusList = await mastodonApi.getTimeline(minId: minId);
      currentTimeline.insertAll(0, statusList);
      for (final status in statusList.reversed) {
        _statusMap[status.id] = status;
      }
      timelineController.sink.add(currentTimeline);
      await Future.delayed(const Duration(seconds: 20));
    }
  }

  void _onTimelineListen() {
    unawaited(_startTimelineUpdates());
  }

  void _onTimelineCancel() async {
    if (!timelineController.hasListener) {
      await _stopTimelineUpdates();
    }
  }

  Future<void> _startTimelineUpdates() async {
    if (!_updatingTimeline) {
      // We were in the process of stopping this, wait for
      // it to finish before starting it up again
      if (_fetchFuture != null) {
        await _fetchFuture;
      }
      _updatingTimeline = true;
      _fetchFuture = _fetchTimeline();
    }
  }

  Future<void> _stopTimelineUpdates() async {
    if (_updatingTimeline) {
      _updatingTimeline = false;
      await _fetchFuture;
      _fetchFuture = null;
    }
  }
}
