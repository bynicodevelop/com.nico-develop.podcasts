import 'package:com_nico_develop_podcasting/components/podcast_list/bloc/podcast_list_bloc.dart';
import 'package:com_nico_develop_podcasting/configs/constants.dart';
import 'package:com_nico_develop_podcasting/models/podcast_model.dart';
import 'package:com_nico_develop_podcasting/screens/podcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PodcastListComponent extends StatelessWidget {
  const PodcastListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastListBloc, PodcastListState>(
      bloc: context.read<PodcastListBloc>()
        ..add(OnLoadPodcastListEvent(
          userId: kDefaultUserParameters["uid"],
        )),
      builder: (context, state) {
        if (state is! PodcastListLoadedState) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * 3,
            ),
            child: SpinKitThreeBounce(
              color: kDefautColor,
              size: kDefaultPadding,
            ),
          );
        }

        final List<PodcastModel> podcasts = state.podcasts;

        if (podcasts.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * 3,
            ),
            child: Center(
              child: Text('No podcasts found'),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  Text(
                    "${podcasts.length} épisode${podcasts.length > 1 ? "s" : ""}"
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: podcasts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buidRow(
                    context,
                    podcasts[index],
                    index,
                    podcastsLength: podcasts.length,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 30.0,
                    thickness: 0,
                    color: Colors.transparent,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buidRow(
    BuildContext context,
    PodcastModel podcast,
    int index, {
    int podcastsLength = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(
          15.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 252, 252, 252),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40),
                  child: Image.network(
                    podcast.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  right: 15.0,
                ),
                height: 65.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      podcast.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Episode ${podcastsLength - index} • ${_formatDuration(podcast.duration)}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10.0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PodcastScreen(
                          podcast: podcast,
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.play_arrow,
                      color: kDefaultTextTitleColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    List<String> listDuration = [];

    if (duration.inHours > 0) {
      listDuration.add("${duration.inHours % 24} h");
    }

    if (duration.inMinutes > 0) {
      listDuration.add("${duration.inMinutes % 60} min");
    }

    return listDuration.join(" ");
  }
}
