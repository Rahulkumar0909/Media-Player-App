import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatelessWidget {
  PlayVideo({this.urlLink});

  final urlLink;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: GetVideo(
          link: urlLink,
        ),
      ),
    );
  }
}

class GetVideo extends StatefulWidget {
  GetVideo({this.link});
  final link;
  @override
  _GetVideoState createState() => _GetVideoState();
}

class _GetVideoState extends State<GetVideo> {
  YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    initialize(widget.link);
  }

  void initialize(dynamic l) {
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(l));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube Player"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
