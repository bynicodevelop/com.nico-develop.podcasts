part of 'podcast_list_bloc.dart';

abstract class PodcastListState extends Equatable {
  const PodcastListState();

  @override
  List<Object> get props => [];
}

class PodcastListInitialState extends PodcastListState {}

class PodcastListLoadingState extends PodcastListState {}

class PodcastListLoadedState extends PodcastListState {
  final List<PodcastModel> podcasts;

  const PodcastListLoadedState({
    this.podcasts = const [],
  });

  @override
  List<Object> get props => [
        podcasts,
      ];
}
