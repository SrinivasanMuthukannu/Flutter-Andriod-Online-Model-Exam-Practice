/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//void main() => runApp(VideoPlayerApp());

*/
/*class VideoPlayerApp extends StatelessWidget {
  VideoPlayerApp({this.videoUrl});
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Related Video for this Model Test',
      home: VideoPlayerScreen(videoUrl: videoUrl),
    );
  }
}*//*


class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key,@required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    _controller = VideoPlayerController.network(
        this.widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
  }
}
*/
