import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

typedef OnError = void Function(Exception exception);

// https://qurani-api.herokuapp.com/api/reciters

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer player = AudioPlayer();

  late final dynamic data;

  getData() async {
    var url = Uri.parse('https://qurani-api.herokuapp.com/api/reciters');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  initState() {
    getData();
    super.initState();
  }

  Widget remoteUrl() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
