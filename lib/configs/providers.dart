import 'package:com_nico_develop_podcasting/components/podcast_list/bloc/podcast_list_bloc.dart';
import 'package:com_nico_develop_podcasting/components/podcast_player/bloc/podcast_player_bloc.dart';
import 'package:com_nico_develop_podcasting/repositories/podcast_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Provider extends StatelessWidget {
  final Widget child;
  final PodcastRepository podcastRepository;

  const Provider({
    Key? key,
    required this.child,
    required this.podcastRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PodcastListBloc>(
          create: (context) => PodcastListBloc(
            podcastRepository: podcastRepository,
          ),
        ),
        BlocProvider<PodcastPlayerBloc>(
          create: (context) => PodcastPlayerBloc(
            podcastRepository: podcastRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
