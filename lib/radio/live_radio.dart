import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:radio/radio/components/radio_descrption.dart';
import 'package:radio/radio/components/radio_header.dart';
import 'package:radio/radio/components/radio_player.dart';
import 'streaming_controller.dart';

class LiveRadio extends StatefulWidget {
  LiveRadio({Key? key}) : super(key: key);

  @override
  State<LiveRadio> createState() => _LiveRadioState();
}

class _LiveRadioState extends State<LiveRadio> {
  var streamingController = StreamingController();

  @override
  initState() {
    super.initState();
    streamingController.config(url: 'http://160.19.99.214:8000/fm');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            RadioHeader(),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.3,
                maxChildSize: 0.70,
                minChildSize: 0.20,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      RadioDescription(scrollController: scrollController),
                      RadioPlayer()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
