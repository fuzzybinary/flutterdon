import 'package:meta/meta.dart';
import 'mastodon/mastodon.dart';

@immutable
class AppState {
  final String instanceName;
  final String currentRoute;
  final bool isLoading;
  final List<Status> homeTimeline;

  const AppState({
    this.instanceName,
    @required this.currentRoute,
    this.isLoading = false,
    this.homeTimeline
  });

  factory AppState.initial() => const AppState(
    isLoading: true,
    currentRoute: '/'
  );
  
}