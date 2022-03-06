part of 'podcast_list_bloc.dart';

abstract class PodcastListEvent extends Equatable {
  const PodcastListEvent();

  @override
  List<Object> get props => [];
}

class OnLoadPodcastListEvent extends PodcastListEvent {
  final String userId;

  const OnLoadPodcastListEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [
        userId,
      ];
}
