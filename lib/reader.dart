import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class Reader extends StatefulWidget {
  final String? reader_id;
  Reader({Key? key, String? this.reader_id}) : super(key: key);

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  AudioPlayer player = AudioPlayer();

  var data = {};
  var surasData = [];
  String currentUrl = "";
  bool loading = true;

  getData() async {
    try {
      var url = Uri.parse(
          'https://qurani-api.herokuapp.com/api/reciters/${widget.reader_id}');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var responseData = jsonDecode(response.body);
      setState(() {
        data = responseData;
        surasData = responseData['surasData'];
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

  Future play(String url) async {
    print(url);
    try {
      if (currentUrl == url) {
        player.pause();
        setState(() {
          currentUrl = "";
        });
      } else {
        player.play(url,
            isLocal: false, stayAwake: true, respectSilence: false);
        setState(() {
          currentUrl = url;
        });
      }
    } catch (err) {
      print('$err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        backgroundColor: Color(0xFF2A5089),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: surasData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: GestureDetector(
                                onTap: () =>
                                    play(surasData[index]['url'].toString()),
                                child: Container(
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 15, 10, 15),
                                    margin:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                            blurRadius: 3)
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                            currentUrl ==
                                                    surasData[index]['url']
                                                        .toString()
                                                ? Icons
                                                    .pause_circle_filled_rounded
                                                : Icons.play_arrow_outlined,
                                            color: Colors.black45),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${surasData[index]['name'].toString()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff2D2E2F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
