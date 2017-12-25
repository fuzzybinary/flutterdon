import 'package:meta/meta.dart';
import 'mastodon/mastodon.dart';

@immutable
class AppState {
  final bool instancesLoading;
  final String instanceName;
  final bool isLoading;
  final String lastExceptionMessage;
  final List<Status> homeTimeline;

  const AppState({
    this.instancesLoading,
    this.instanceName,
    this.isLoading = false,
    this.lastExceptionMessage,
    this.homeTimeline
  });

  factory AppState.initial() => const AppState(
    instancesLoading: true,
    isLoading: true,
  );
  
  AppState copyOf({
    bool instancesLoading,
    String instanceName,
    bool loggedIn,
    bool isLoading,
    String lastExceptionMessage,
    List<Status> homeTimeline
  }) {
    return new AppState(
      instancesLoading: instancesLoading ?? this.instancesLoading,
      instanceName: instanceName ?? this.instanceName,
      isLoading: isLoading ?? this.isLoading,
      lastExceptionMessage: lastExceptionMessage ?? this.lastExceptionMessage,
      homeTimeline: homeTimeline ?? this.homeTimeline
    );
  }
}