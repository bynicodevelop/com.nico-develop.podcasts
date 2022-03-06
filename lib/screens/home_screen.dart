import 'package:com_nico_develop_podcasting/components/podcast_list/podcast_list_component.dart';
import 'package:com_nico_develop_podcasting/configs/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _avatarUrl;
  String? _headerUrl;

  @override
  void initState() {
    super.initState();

    FirebaseStorage.instance
        .ref("users/${kDefaultUserParameters["uid"]}/avatar.png")
        .getDownloadURL()
        .then((url) {
      setState(() => _avatarUrl = url);
    });

    FirebaseStorage.instance
        .ref("users/${kDefaultUserParameters["uid"]}/header.jpeg")
        .getDownloadURL()
        .then((url) {
      setState(() => _headerUrl = url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: _headerUrl != null
                          ? Image.network(
                              _headerUrl!,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: -60,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              blurRadius: 20.0,
                              spreadRadius: 0.0,
                              offset: const Offset(0, 10.0),
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _avatarUrl != null
                                ? NetworkImage(
                                    _avatarUrl!,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 80,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          kDefaultUserParameters["name"],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          kDefaultUserParameters["description"],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 45.0,
                ),
                const PodcastListComponent()
              ],
            ),
          )
        ],
      ),
    );
  }
}
