import 'dart:ui';

import 'package:audio_wave/audio_wave.dart';
import 'package:com_nico_develop_podcasting/components/podcast_player/bloc/podcast_player_bloc.dart';
import 'package:com_nico_develop_podcasting/configs/constants.dart';
import 'package:com_nico_develop_podcasting/models/podcast_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

const List<double> bars = [
  10,
  20,
  25,
  30,
  25,
  10,
  15,
  20,
  30,
  15,
  20,
  20,
  10,
  30,
  25,
  10,
  20,
  25,
  30,
  25,
  10,
  15,
  20,
  30,
  15,
  20,
  20,
  10,
  30,
  25,
  20,
  10,
];

class PodcastScreen extends StatefulWidget {
  final PodcastModel podcast;

  const PodcastScreen({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _avatarUrl;
  int nBar = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    FirebaseStorage.instance
        .ref("users/${kDefaultUserParameters["uid"]}/avatar.png")
        .getDownloadURL()
        .then((url) {
      setState(() => _avatarUrl = url);
    });

    widget.podcast.audioUrl.getDownloadURL().then((url) async {
      _audioPlayer.setUrl(url);

      _audioPlayer.play();
      setState(() => isPlaying = true);
    });

    _audioPlayer.positionStream.listen((event) {
      setState(() => nBar =
          (bars.length * (event.inSeconds / widget.podcast.duration.inSeconds))
                  .toInt() +
              1);
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();

    _audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                widget.podcast.thumbnail,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 40,
                      sigmaY: 40,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(
                        kDefaultPadding * 2,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            kDefaultTextColor.withOpacity(.2),
                            kDefaultTextColor,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: kDefaultPadding,
                                ),
                                child: CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage: _avatarUrl != null
                                      ? NetworkImage(
                                          _avatarUrl!,
                                        )
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 80.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          widget.podcast.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(
                                          widget.podcast.duration,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AudioWave(
                            height: 150,
                            width: 340,
                            spacing: 5,
                            animation: false,
                            bars: bars.asMap().entries.map((entry) {
                              return AudioWaveBar(
                                height: entry.value,
                                color: Colors.white
                                    .withOpacity(entry.key < nBar ? 1 : .5),
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Duration position = _audioPlayer.position;

                                  if (position.inSeconds < 10) {
                                    _audioPlayer.seek(
                                      Duration.zero,
                                    );

                                    return;
                                  }

                                  position =
                                      position - const Duration(seconds: 10);

                                  _audioPlayer.seek(
                                    position,
                                  );
                                },
                                icon: const Icon(
                                  Icons.replay_10,
                                  color: Colors.white,
                                  size: kDefaultPadding * 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() => isPlaying = !isPlaying);

                                  if (isPlaying) {
                                    _audioPlayer.play();
                                  } else {
                                    _audioPlayer.pause();
                                  }
                                },
                                icon: Icon(
                                  !isPlaying ? Icons.play_arrow : Icons.pause,
                                  color: Colors.white,
                                  size: kDefaultPadding * 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Duration position = _audioPlayer.position;

                                  position =
                                      position + const Duration(seconds: 10);

                                  _audioPlayer.seek(
                                    position,
                                  );
                                },
                                icon: const Icon(
                                  Icons.forward_10,
                                  color: Colors.white,
                                  size: kDefaultPadding * 2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    List<String> listDuration = [];

    if (duration.inHours > 0) {
      listDuration.add("${duration.inHours % 24} h");
    }

    if (duration.inMinutes % 60 > 0) {
      listDuration.add("${duration.inMinutes % 60} min");
    }

    return listDuration.join(" ");
  }
}
