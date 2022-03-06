import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_podcasting/models/podcast_model.dart';
import 'package:com_nico_develop_podcasting/repositories/podcast_repository.dart';
import 'package:equatable/equatable.dart';

part 'podcast_player_event.dart';
part 'podcast_player_state.dart';

class PodcastPlayerBloc extends Bloc<PodcastPlayerEvent, PodcastPlayerState> {
  final PodcastRepository podcastRepository;

  PodcastPlayerBloc({
    required this.podcastRepository,
  }) : super(PodcastPlayerInitialState()) {
    on<OnPodcastPlayerEvent>((event, emit) {});
  }
}
