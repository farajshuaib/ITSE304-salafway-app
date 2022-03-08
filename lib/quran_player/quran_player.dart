import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class QuranPlayer extends StatefulWidget {
  final data;
  final bool isLocal;

  QuranPlayer(this.data, this.isLocal);

  @override
  _QuranPlayerState createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  String currentUrl = "";
  bool currentState = true;
  var localAudioCacheURI;
  AudioPlayer audioPlayer = AudioPlayer();
  late AudioCache player;

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildWidgetBackground(mediaQuery),
          _buildWidgetContainerQuranPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetContainerQuranPlayer(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.padding.top + 16.0),
      child: Column(
        children: <Widget>[
          _buildWidgetActionAppBar(),
          SizedBox(height: 48.0),
          _buildWidgetPanelQuranPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetPanelQuranPlayer(MediaQueryData mediaQuery) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 36.0),
              _buildWidgetPhoto(mediaQuery),
              SizedBox(height: 48.0),
              _buildWidgetQuranInfo(),
              _buildWidgetControlQuranPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetControlQuranPlayer() {
    return Expanded(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Icon(Icons.fast_rewind),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentState == true)
                    currentState = false;
                  else
                    currentState = true;
                });

                play(widget.data['url']);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child:
                      currentState ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                ),
              ),
            ),
            Expanded(
              child: Icon(Icons.fast_forward),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetQuranInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "سورة",
            style: TextStyle(
              fontFamily: "title",
              color: Color(0xFF7D9AFF),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            widget.data['name'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "title",
              fontSize: 30.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetPhoto(MediaQueryData mediaQuery) {
    return Center(
      child: Container(
        width: mediaQuery.size.width / 2.5,
        height: mediaQuery.size.width / 2.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/quran_image.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetActionAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
          Text(
            "سورة",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "title",
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetBackground(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/quran_image.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }

  Future play(String url) async {
    player = AudioCache(fixedPlayer: audioPlayer);

    if (currentState) {
      audioPlayer.pause();
    } else {
      if (widget.isLocal) {
        player.play(url);
      } else {
        audioPlayer.play(url,
            isLocal: false, stayAwake: true, respectSilence: false);
      }
    }
  }
}
