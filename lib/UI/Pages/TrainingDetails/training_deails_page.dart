import 'package:elearning_provider/models/training_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

import '../../Widgets/nav_bar.dart';

class TrainingDetails extends StatefulWidget {
  final Training training;
  const TrainingDetails({super.key, required this.training});

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  late VideoPlayerController _controller;
  Color textColor = Colors.black;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Training training = widget.training;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:const Size.fromHeight(60.0) ,
        child: CustomNavBar(),
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
                                    style:  TextStyle(
                                      fontSize: 18.0,
                                      color: textColor
                                    ),
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
                /*  _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 2.0,
                        child: VideoPlayer(_controller),
                        
                      )
                    : CircularProgressIndicator(),*/
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
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
