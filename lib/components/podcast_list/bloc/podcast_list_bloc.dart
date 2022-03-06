import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_podcasting/models/podcast_model.dart';
import 'package:com_nico_develop_podcasting/repositories/podcast_repository.dart';
import 'package:equatable/equatable.dart';

part 'podcast_list_event.dart';
part 'podcast_list_state.dart';

class PodcastListBloc extends Bloc<PodcastListEvent, PodcastListState> {
  final PodcastRepository podcastRepository;

  PodcastListBloc({
    required this.podcastRepository,
  }) : super(PodcastListInitialState()) {
    on<OnLoadPodcastListEvent>((event, emit) async {
      emit(PodcastListLoadingState());

      List<PodcastModel> podcastModel = await podcastRepository.getPodcasts(
        event.userId,
      );

      emit(PodcastListLoadedState(
        podcasts: podcastModel,
      ));
    });
  }
}
