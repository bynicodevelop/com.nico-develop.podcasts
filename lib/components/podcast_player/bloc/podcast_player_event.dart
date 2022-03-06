part of 'podcast_player_bloc.dart';

abstract class PodcastPlayerEvent extends Equatable {
  const PodcastPlayerEvent();

  @override
  List<Object> get props => [];
}

class OnPodcastPlayerEvent extends PodcastPlayerEvent {
  final PodcastModel podcast;

  const OnPodcastPlayerEvent({
    required this.podcast,
  });

  @override
  List<Object> get props => [
        podcast,
      ];
}
