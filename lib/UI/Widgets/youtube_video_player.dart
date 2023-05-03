import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:youtube_player_iframe_plus/youtube_player_iframe_plus.dart';
class YoutubeVideoPlayer extends StatefulWidget {
  final String videoId;
  const YoutubeVideoPlayer({super.key, required this.videoId});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        enableJavaScript: true
      ),
    );
    _controller.setSize(const Size(200,200));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFramePlus(
            controller: _controller,
            aspectRatio: 16/9,
          );
        
  }
}
