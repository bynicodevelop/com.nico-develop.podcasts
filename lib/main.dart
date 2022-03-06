import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nico_develop_podcasting/configs/custom_theme_data.dart';
import 'package:com_nico_develop_podcasting/configs/providers.dart';
import 'package:com_nico_develop_podcasting/firebase_options.dart';
import 'package:com_nico_develop_podcasting/repositories/podcast_repository.dart';
import 'package:com_nico_develop_podcasting/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseStorage.instance.useStorageEmulator(
      host,
      9199,
    );
  }

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  runApp(App(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
  ));
}

class App extends StatelessWidget {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  const App({
    Key? key,
    required this.firestore,
    required this.storage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PodcastRepository podcastRepository = PodcastRepository(
      firestore: firestore,
      storage: storage,
    );

    return Provider(
      podcastRepository: podcastRepository,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.defaultTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
