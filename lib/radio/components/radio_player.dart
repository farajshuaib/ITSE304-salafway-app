import 'package:flutter/material.dart';
import 'package:radio/radio/streaming_controller.dart';

class RadioPlayer extends StatelessWidget {

late var streamingController ;
  RadioPlayer({Key? key}) : super(key: key){
    streamingController = StreamingController();
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -45.0,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff2D2E2F),
          border: Border.all(
              width: 5,
              color: Theme.of(context).primaryColor),
        ),
        child: StreamBuilder(
          stream: streamingController.streamingController.stream,
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null ||
                snapshot.data == "paused_event") {
              return IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 44,
                  color: Colors.white,
                ),
                onPressed: () {
                  streamingController.play();
                },
              );
            } else if (snapshot.data == "playing_event") {
              return IconButton(
                icon: Icon(
                  Icons.pause,
                  size: 44,
                  color: Colors.white,
                ),
                onPressed: () {
                  streamingController.pause();
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
