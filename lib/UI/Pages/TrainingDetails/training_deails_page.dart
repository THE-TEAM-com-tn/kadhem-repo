import 'dart:convert';

import 'package:elearning_provider/UI/Widgets/youtube_video_player.dart';
import 'package:elearning_provider/models/training_model.dart';
import 'package:flutter/material.dart';
import '../../Widgets/drive_video_player.dart';
import '../../Widgets/nav_bar.dart';
import 'package:http/http.dart' as http;

class TrainingDetails extends StatefulWidget {
  final Training training;
  const TrainingDetails({super.key, required this.training});

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  Color textColor = Colors.black;
  bool youtube = false;
  String _videoId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final String _videoUrl = widget.training.trailerVid;
    checkLink(widget.training.trailerVid);
  }

  void checkLink(String _videoUrl) {
    if (_videoUrl.contains("youtube.com") || _videoUrl.contains("youtu.be")) {
      // Extract the video ID from the URL
      if (_videoUrl.contains("youtube.com")) {
        _videoId = _videoUrl.split("v=")[1];
      } else if (_videoUrl.contains("youtu.be")) {
        _videoId = _videoUrl.split("/").last;
      }
      youtube = true;
    } else {
      final regExp = RegExp(r"/d/([a-zA-Z0-9_-]{11}).*");
      final match = regExp.firstMatch(_videoUrl);
      _videoId =
          "https://drive.google.com/uc?export=download&id=${match!.group(1)}?usp=sharing";
      youtube = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Training training = widget.training;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomNavBar(selectedIndex: 1,),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          training.image,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              training.title,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${training.price} DT",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            GestureDetector(
                                onTap: () {
                                  print("ala");
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onHover: (event) {
                                    setState(() {
                                      textColor = Colors
                                          .red; // Change the text color to red when hovering
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      textColor = Colors
                                          .black; // Reset the text color when the mouse leaves
                                    });
                                  },
                                  child: Text(
                                    "by ${training.author}",
                                    style: TextStyle(
                                        fontSize: 18.0, color: textColor),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Add to cart'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tags',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ...training.tags!.map(
                              (tag) => Chip(
                                label: Text(tag),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ...training.category.map(
                              (category) => Chip(
                                label: Text(category),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(training.description),
                    ],
                  ),
                ),
                Container(
                    height: 450,
                    child: youtube
                        ? YoutubeVideoPlayer(videoId: _videoId)
                        : VideoPlayerWidget(videoUrl: _videoId)),
                const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Lessons',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Add your list of lessons here
              ],
            ),
          )),
    );
  }
}
