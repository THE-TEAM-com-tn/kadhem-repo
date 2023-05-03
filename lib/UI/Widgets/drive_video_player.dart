import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    print(videoUrl) ;
    final _controller = VideoPlayerController.network("https://drive.google.com/uc?export=download&id=1RKPi3QBSdSPvIsXWjYJ6QhY7wfuiX98f");
    return VideoPlayer(_controller);
  }
}
