import 'dart:async';

import 'package:flutter/services.dart';

class StreamingController {
  MethodChannel _channel = const MethodChannel('streaming_channel');
  var streamingController = StreamController<String>();

  StreamingController() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'playing_event':
          streamingController.sink.add(call.method);
          return 'Playing, ${call.arguments}';
        case 'paused_event':
          streamingController.sink.add(call.method);
          return 'Paused, ${call.arguments}';
        case 'stopped_event':
          streamingController.sink.add(call.method);
          return 'Stopped, ${call.arguments}';
        case 'loading_event':
          streamingController.sink.add(call.method);
          return 'Loading, ${call.arguments}';
        default:
          throw MissingPluginException();
      }
    });
  }

  Future config({String? url}) async {
    try {
      String result = await _channel.invokeMethod('config', <String, dynamic>{
        'url': url,
        'notification_title': "قناة طريق السلف",
        'notification_description': "",
        'notification_color': "#2A5592",
        'notification_stop_button_text': "Stop",
        'notification_pause_button_text': "Pause",
        'notification_play_button_text': "Play",
        'notification_playing_description_text': "Playing",
        'notification_stopped_description_text': "Stopped"
      });
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future play() async {
    try {
      String result = await _channel.invokeMethod('play', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future pause() async {
    try {
      String result = await _channel.invokeMethod('pause', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future stop() async {
    try {
      String result = await _channel.invokeMethod('stop', <String, dynamic>{});
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }

  void dispose() {
    streamingController.close();
  }
}
