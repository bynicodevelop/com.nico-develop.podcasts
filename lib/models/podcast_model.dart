import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PodcastModel {
  final String uid;
  final String title;
  final String thumbnail;
  final DateTime date;
  final Duration duration;
  final Reference audioUrl;

  const PodcastModel({
    required this.uid,
    required this.title,
    required this.thumbnail,
    required this.date,
    required this.duration,
    required this.audioUrl,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) => PodcastModel(
        uid: json['uid'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        date: (json['date'] as Timestamp).toDate(),
        duration: Duration(
          seconds: json['duration'],
        ),
        audioUrl: json['audioUrl'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'title': title,
        'thumbnail': thumbnail,
        'date': date.toIso8601String(),
        'duration': duration.inSeconds,
        'audioUrl': audioUrl,
      };
}
