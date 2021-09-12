import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'helper.dart';
import 'input.dart';

void main() {
  runApp(MyMain());
}

class MyMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: DefaultTabController(
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text("Media Player"),
                centerTitle: true,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(text: "Audio"),
                    Tab(text: "Video"),
                  ],
                ),
                leading: Container(
                  child: Image.asset("assets/logo.jpg"),
                )),
            body: TabBarView(
              children: <Widget>[
                MyApp(),
                App(),
              ],
            ),
          ),
          length: 2,
          initialIndex: 0,
        ));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Player(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Player extends StatefulWidget {
  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  bool f1 = false;
  bool f2 = false;
  bool f3 = false;
  bool stop = false;
  AudioPlayer a1 = AudioPlayer();
  AudioPlayer a2 = AudioPlayer();
  AudioPlayer a3 = AudioPlayer();
  String textValue = "Sample";

  @override
  void deactivate() {
    a1.stop();
    a2.stop();
    a3.stop();
    super.deactivate();
  }

  void songControl(int number, bool s, AudioCache ac, bool stop) {
    if (number == 1) {
      if (!s) {
        setState(() {
          f1 = true;
          f2 = f3 = false;
          ac.play("1.mp3");
          a2.pause();
          a3.pause();
        });
      } else if (stop) {
        setState(() {
          a1.stop();
          f1 = false;
        });
      } else {
        setState(() {
          f1 = f2 = f3 = false;
          a1.pause();
        });
      }
    }
    if (number == 2) {
      if (!s) {
        setState(() {
          f2 = true;
          f1 = f3 = false;
          ac.play("2.mp3");
          a1.pause();
          a3.pause();
        });
      } else if (stop) {
        setState(() {
          a2.stop();
          f2 = false;
        });
      } else {
        setState(() {
          f1 = f2 = f3 = false;
          a2.pause();
        });
      }
    }
    if (number == 3) {
      if (!s) {
        setState(() {
          f3 = true;
          f1 = f2 = false;
          ac.play("3.mp3");
          a1.pause();
          a2.pause();
        });
      } else if (stop) {
        setState(() {
          a3.stop();
          f3 = false;
        });
      } else {
        setState(() {
          a3.pause();
          f1 = f2 = f3 = false;
        });
      }
    }
  }

  dynamic buildTile(String song, int number, bool s, AudioCache p) {
    return Expanded(
      child: Center(
        child: Container(
          width: 300.0,
          height: 100.0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 30.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 2.0),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      song,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  width: 60.0,
                ),
                SizedBox(width: 90.0),
                Container(
                  width: 60,
                  height: 60,
                  child: Card(
                    child: FlatButton(
                      child: Icon(s ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        songControl(number, s, p, stop);
                      },
                    ),
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 30.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 60,
                  height: 60,
                  child: Card(
                    child: FlatButton(
                      child: Icon(Icons.stop),
                      onPressed: () {
                        songControl(number, s, p, true);
                      },
                    ),
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AudioCache p1 = AudioCache(fixedPlayer: a1);
    AudioCache p2 = AudioCache(fixedPlayer: a2);
    AudioCache p3 = AudioCache(fixedPlayer: a3);

    return Scaffold(
      body: Column(
        children: <Widget>[
          buildTile("Past Life", 1, f1, p1),
          SizedBox(width: 10.0),
          buildTile("Roar", 2, f2, p2),
          SizedBox(width: 10.0),
          buildTile("You", 3, f3, p3),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter URL',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
              },
            ),
          ),
          Container(
            width: 200,
            height: 40,
            child: Card(
              child: FlatButton(
                child: Text("Play Audio"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AudioPlayerNet(
                          urlLink: textValue,
                        );
                      },
                    ),
                  );
                },
              ),
              elevation: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
