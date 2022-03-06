import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nico_develop_podcasting/models/podcast_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PodcastRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  late CollectionReference<PodcastModel> _podcastsRef;

  PodcastRepository({
    required this.firestore,
    required this.storage,
  }) {
    _podcastsRef = firestore.collection('podcasts').withConverter<PodcastModel>(
          fromFirestore: (snapshot, _) => PodcastModel.fromJson({
            ...snapshot.data()!,
            'uid': snapshot.id,
            'audioUrl': storage.ref("podcasts/${snapshot.id}/podcast.mp3")
          }),
          toFirestore: (movie, _) => movie.toJson(),
        );
  }

  Future<List<PodcastModel>> getPodcasts(String userId) async {
    List<QueryDocumentSnapshot<PodcastModel>> podcasts = await _podcastsRef
        .where(
          "userId",
          isEqualTo: userId,
        )
        .get()
        .then((snapshot) => snapshot.docs);

    return podcasts.map((doc) => doc.data()).toList();
  }
}
