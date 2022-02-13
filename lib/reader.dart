import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class Reader extends StatefulWidget {
  final String? reader_id;
  Reader({Key? key, String? this.reader_id}) : super(key: key);

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  AudioPlayer player = AudioPlayer();

  var data = [];
  bool loading = true;

  getData() async {
    try {
      var url = Uri.parse(
          'https://qurani-api.herokuapp.com/api/reciters/${widget.reader_id}');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      setState(() {
        data = jsonDecode(response.body);
        loading = false;
      });
    } catch (err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("حدث خطأ ما في جلب البيانات الرجاء إعادة المحاولة لاحقا")));
    }
  }

  initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Reader(reader_id: data[index]['id'])),
                          );
                        },
                        child: Container(),
                      ),
                    );
                  }),
            ),
    );
  }
}
