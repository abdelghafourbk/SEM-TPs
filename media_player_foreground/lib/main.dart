import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Media Player'),
        ),
        body: const AudioPlayerWidget(),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> playAudio() async {
    try {
      await audioPlayer.play(UrlSource('sounds/minecraftKey.mp3'));
    } catch (e) {
      print("Audio playback error: $e");
    }

    setState(() {
      isPlaying = true;
    });
    //! Start the foreground service
    ForegroundService().start();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();

    setState(() {
      isPlaying = false;
    });

    //! Stop the foreground service
    ForegroundService().stop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isPlaying)
            ElevatedButton(
              onPressed: stopAudio,
              child: const Text('Stop Audio'),
            )
          else
            ElevatedButton(
              onPressed: playAudio,
              child: const Text('Play Audio'),
            ),
        ],
      ),
    );
  }
}
