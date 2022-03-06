part of 'podcast_player_bloc.dart';

abstract class PodcastPlayerState extends Equatable {
  const PodcastPlayerState();

  @override
  List<Object> get props => [];
}

class PodcastPlayerInitialState extends PodcastPlayerState {}
